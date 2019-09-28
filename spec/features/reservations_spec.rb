require 'rails_helper'

RSpec.feature "Reservationsに関するテスト", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  before do
    @user1 = FactoryBot.create(:user, :create_with_reservations, :create_with_reviews)
    @owner1 = FactoryBot.create(:owner, :create_with_restaurants)
  end

  feature "ユーザーがログインした状態で" do
    before do
      login_as(@user1)
    end
    feature "予約登録ページから予約をする" do
      before do
        visit new_reservation_path
        find_field('reservation[usage_day]').set("2019-11-30")
        find_field('reservation[use_start_time]').set("2019-11-30 12:00")
        find_field('reservation[use_end_time]').set("2019-11-30 17:00")
        find_field('reservation[usage_number]').set("5")
        # choose "現金払い" from: 'reservation[payment]'
      end
      scenario "正しく保存されているか" do
        expect {
          find("inputo[name='commit']").click
        }.to change(@user1.reservations, :count).by(1)
      end
      scenario "リダイレクト先は正しいか" do
        find("input[name='commit']").click
        expect(page).to have_current_path user_path(@user1)
      end
      scenario "サクセスメッセージが表示されるか" do
        find("input[name='commit']").click
        expect(page).to have_content "登録しました"
      end
    end
    feature "予約編集ページで内容を編集する" do
      before do
        visit edit_reservation_path
        find_field('reservation[usage_day]').set('2019-11-30')
        find_field('reservation[use_start_time]').set('2019-11-30 12:00')
        find_field('reservation[use_end_time]').set('2019-11-30 17:00')
        find("input[name='commit']").click
      end
      scenario "予約情報が編集されているか" do
        expect(page).to have_content "2019-11-30"
        expect(page).to have_content "2019-11-30 12:00"
        expect(page).to have_content "2019-11-30 17:00"
      end
    end
    feature "予約編集ページで内容をキャンセルする" do
      before do
        reservation = @user1.reservations.first
        visit user_path(@user1)
      end
      scenario "予約がキャンセルされているかどうか" do
        expect {
          all("a[data-method='delete']").select{|n| n[:href] == user_path(@user1.reservations.first)}[0].click
        }.to change(@user1.reservation, :count).by(-1)
      end
      scenario "リダイレクト先が正しいか" do
        all("a[data-method='delete']").select{|n| n[:href] == user_path(@user1.reservations.first)}[0].click
        expect(page).to have_current_path user_path(@user1)
      end
    end
  end

end

require 'rails_helper'

RSpec.feature "Usersに関するテスト", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  before do
    # 予約もレビューもしているユーザー
    @user1 = FactoryBot.create(:user, :create_with_reservations, :create_with_reviews)
    # FKを１つも持たないユーザー
    @user2 = FactoryBot.create(:user)
  end
  feature "ログインしていない状態で" do
    feature "以下のページへアクセスした際のリダイレクト先の確認" do
      scenario "userの詳細ページ" do
        visit user_path(@user1)
        expect(page).to have_current_path new_user_session_path
      end

      scenario "userの編集ページ" do
        visit edit_user_path(@user1)
        expect(page).to have_current_path new_user_session_path
      end
    end
  end


  feature "ログインした状態で" do
    before do
      login_as(@user1, :scope => :user )
    end
    feature "表示内容とリンクの確認" do
      scenario "userの詳細ページの表示内容とリンクの確認" do
        visit user_path(@user1)
        # ユーザー情報
        expect(page).to have_content @user1.last_name
        expect(page).to have_content @user1.first_name
        expect(page).to have_content @user1.last_kana
        expect(page).to have_content @user1.first_kana
        expect(page).to have_content @user1.phone_number
        expect(page).to have_content @user1.email
        # expect(page).to have_content @user1.encrypted_password
        # ユーザー編集ボタンがあることの確認
        expect(page).to have_link "",href: edit_user_path(@user1)
        # ユーザー退会ボタンがあることの確認
        expect(all("a[data-method='delete']")[-1][:href]).to eq(user_registration_path)
        # 予約したレストラン情報
        @reservations = @user1.reservations
        @user1.reservations.each do |reservation|
          expect(page).to have_content reservation.restaurant.restaurant_name
          expect(page).to have_content reservation.restaurant.restaurant_address
          expect(page).to have_content reservation.usage_day.strftime('%m月%d日')
          expect(page).to have_content reservation.use_start_time.strftime('%H時%M分')
          expect(page).to have_content reservation.use_end_time.strftime('%H時%M分')
          expect(page).to have_link "",href: edit_reservation_path(@user1)
        end
      end
      scenario "userの詳細ページにtableタグを使用しているか" do
        visit user_path(@user1)
        expect(page).to have_selector "table"
      end
    end

    feature "自分のプロフィールの更新" do
      before do
        @phone_number = Faker::Base.regexify(/0[0-9]{9,10}/)
        visit edit_user_path(@user1)
        find_field('user[last_name]').set('updated_last_name')
        find_field('user[first_name]').set('updated_first_name')
        find_field('user[last_kana]').set('updated_last_kana')
        find_field('user[first_kana]').set('updated_first_kana')
        find_field('user[phone_number]').set(@phone_number)
        find_field('user[email]').set('hogehoge@example.com')
        find("input[name='commit']").click
      end
      scenario "userが更新されているか" do
        expect(page).to have_content "updated_last_name"
        expect(page).to have_content "updated_first_name"
        expect(page).to have_content "updated_last_kana"
        expect(page).to have_content "updated_first_kana"
        expect(page).to have_content @phone_number
        expect(page).to have_content "hogehoge@example.com"
      end
      scenario "リダイレクト先は正しいか" do
        expect(page).to have_current_path user_path(@user1)
      end
    end
  end


















    # Rspec
end

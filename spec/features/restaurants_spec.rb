require 'rails_helper'

RSpec.feature "Restaurants", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  before do
    @user1 = FactoryBot.create(:user, :create_with_reservations, :create_with_reviews)
    @owner1 = FactoryBot.create(:owner, :create_with_restaurants)
  end

  feature "オーナーがログインした状態で" do
    before do
      login_as(@owner1, :scope => :owner )
    end
    feature "表示内容とリンクの確認（登録ページ）" do
      before do
        visit new_restaurant_path
        find_field('restaurant[restaurant_name]').set('restaurant_name')
        find_field('restaurant[scheduled_usage_fee]').set('scheduled_usage_fee')
        find_field('restaurant[facility]').set('facility')
        find_field('restaurant[possible_day]').set('2019-10-30')
        find_field('restaurant[available_start_time]').set('2019-10-30 16:28:13')
        find_field('restaurant[available_end_time]').set('2019-10-30 19:28:13')
        find_field('restaurant[rest_day]').set('2019-10-31 19:28:13')
        find_field('restaurant[restaurant_address]').set('神南101')
        find_field('restaurant[seat_number]').set('seat_number')
        select "埼玉県", from: 'reservation[prefecture]'
        find("input[name='commit']").click
      end
      scenario "restaurantが更新されているか" do
        expect(page).to have_content "updated_restaurant_name"
        expect(page).to have_content "scheduled_usage_fee"
        expect(page).to have_content "facility"
        expect(page).to have_content "2019-10-30"
        expect(page).to have_content "2019-10-30 16:28:13"
        expect(page).to have_content "2019-10-30 19:28:13"
        expect(page).to have_content "2019-10-31 19:28:13"
        expect(page).to have_content "神南101"
        expect(page).to have_content "seat_number"
        expect(page).to have_content "prefecture"
      end
      scenario "リダイレクト先は正しいか" do
        expect(page).to have_current_path owner_path(@owner1)
      end
      scenario "サクセスメッセージが表示されるか" do
        find("input[name='commit']").click
        expect(page).to have_content "登録しました"
      end
    end
  end

  feature "ユーザーがログインした状態で" do
    before do
      login_as(@user1, :scope => :user )
    end
    feature "表示内容とリンクの確認（一覧ページ）" do
      scenario "restaurantの一覧ページの表示内容とリンクは正しいか" do
        visit restaurants_path
        @search = Restaurant.includes(:reservations).ransack(params[:q])
        @results = @search.result(distinct: true).order(rastaurant_order: "DESC")
        @results.each do |results|
          expect(page).to have_content results.restaurant_name
          # アクティブストレージ保留
          expect(page).to have_content results.prefecture
          expect(page).to have_content results.restaurant_address
          expect(page).to have_content results.available_start_time.strftime('%Y年%m月%d日 %H時%M分')
          expect(page).to have_content results.available_end_time.strftime('%Y年%m月%d日 %H時%M分')
          expect(page).to have_content results.scheduled_usage_fee
          expect(page).to have_link "",href: restaurant_path(results)
        end
      end
    end
    feature "表示内容とリンクの確認（詳細ページ）" do
      scenario "restaurantの詳細ページの表示内容とリンクは正しいか" do
        visit restaurant_path
        # 店舗情報
        expect(page).to have_content restaurant.restaurant_name
        expect(page).to have_content restaurant.prefecture
        expect(page).to have_content restaurant.restaurant_address
        expect(page).to have_content restaurant.available_start_time.strftime('%Y年%m月%d日 %H時%M分')
        expect(page).to have_content restaurant.available_end_time.strftime('%Y年%m月%d日 %H時%M分')
        expect(page).to have_content restaurant.scheduled_usage_fee
        expect(page).to have_content restaurant.seat_number
        expect(page).to have_content restaurant.facility
        expect(page).to have_link "",href: restaurant_reservations_form_path
        # 店舗位置情報
        # レビュー
        reviews.each do |review|
          expect(page).to have_content review.review_name
          expect(page).to have_content review.comment
        end
      end
    end
  end


  feature "ログインしていない状態で" do
    scenario "restaurantの一覧ページの表示内容とリンクは正しいか" do
      visit restaurants_path
    end
  end



end

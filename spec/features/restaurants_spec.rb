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
        # select "埼玉県", from: '#restaurant_prefecture'
        find('#restaurant_prefecture').find(:xpath, 'option[1]').select_option
        file_path = Rails.root.join('spec', 'files', 'sample.jpeg')
        attach_file('restaurant[images][]', file_path)
        find("input[name='commit']").click
      end
      scenario "リダイレクト先は正しいか" do
        expect(page).to have_current_path owner_path(@owner1)
      end
    end
  end

  feature "ユーザーがログインした状態で" do
    before do
      login_as(@user1, :scope => :user )
    end
    feature "表示内容とリンクの確認（一覧ページ）" do
      query = "a"
      before do
        #検索フォームに値を入れる
        visit restaurants_path
        find_field('q[restaurant_name_or_facility_or_seat_number_cont_any]').set(query)
        #検索実行ボタンを押す
        find("input[name='commit']").click
      end
      scenario "restaurantの一覧ページの表示内容とリンクは正しいか" do
        visit restaurants_path
        @search = Restaurant.includes(:reservations).ransack(query)
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
        restaurant = FactoryBot.create(:restaurant)
        visit restaurant_path(restaurant.id)
        # 店舗情報
        expect(page).to have_content restaurant.restaurant_name
        expect(page).to have_content restaurant.prefecture
        expect(page).to have_content restaurant.restaurant_address
        expect(page).to have_content restaurant.available_start_time.strftime('%Y年%m月%d日 %H時%M分')
        expect(page).to have_content restaurant.available_end_time.strftime('%Y年%m月%d日 %H時%M分')
        expect(page).to have_content restaurant.scheduled_usage_fee
        expect(page).to have_content restaurant.seat_number
        expect(page).to have_content restaurant.facility
        expect(page).to have_link "",href: restaurant_reservations_form_path(restaurant.id)
        # 店舗位置情報
        # レビュー
        restaurant.reviews.each do |review|
          expect(page).to have_content review.review_name
          expect(page).to have_content review.comment
        end
      end
    end
  end
end

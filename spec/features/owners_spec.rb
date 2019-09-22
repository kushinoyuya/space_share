require 'rails_helper'

RSpec.feature "Ownersに関するテスト", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  before do
    # 店舗登録しているオーナー
    @owner1 = FactoryBot.create(:owner, :create_with_restaurants)
    # FKを１つも持たないオーナー
    @owner2 = FactoryBot.create(:owner)
  end
  feature "ログインしていない状態で" do
    feature "以下のページへアクセスした際のリダイレクトの確認" do
      scenario "ownerの詳細ページ" do
        visit owner_path(@owner1)
        expect(page).to have_current_path new_owner_session_path
      end

      scenario "ownerの編集ページ" do
        visit edit_owner_path(@owner1)
        expect(page).to have_current_path new_owner_session_path
      end
    end
  end

  feature "ログインした状態で" do
    before do
      login_as(@owner1, :scope => :owner )
    end
    feature "表示内容とリンクの確認" do
      scenario "ownerの詳細ページの表示内容とリンクの確認" do
        visit owner_path(@owner1)
        # オーナー情報
        expect(page).to have_content @owner1.last_name
        expect(page).to have_content @owner1.first_name
        expect(page).to have_content @owner1.last_kana
        expect(page).to have_content @owner1.first_kana
        expect(page).to have_content @owner1.phone_number
        expect(page).to have_content @owner1.email
        # オーナー編集ボタンがあることの確認
        expect(page).to have_link "",href: edit_owner_path(@owner1)
        # オーナー退会ボタンがあることの確認
        expect(all("a[data-method='delete']")[-1][:href]).to eq(owner_registration_path)
        # 予約情報
        @restaurants = @owner1.restaurants
          @restaurants.each do |restaurant|
            restaurant.reservations.limit(10).reverse_each do |reservation|
              expect(page).to have_content reservation.restaurant.restaurant_name
              expect(page).to have_content reservation.user.last_name
              expect(page).to have_content reservation.user.first_name
              expect(page).to have_content reservation.usage_number
              expect(page).to have_content reservation.usage_day.strftime('%m月%d日')
              expect(page).to have_content reservation.use_start_time.strftime('%H時%M分')
              expect(page).to have_content reservation.use_end_time.strftime('%H時%M分')
              expect(page).to have_content reservation.payment
              expect(page).to have_content reservation.user.phone_number
            end
          end
        end
        scenario "ownerの詳細ページにtableタグを使用しているか" do
          visit owner_path(@owner1)
          expect(page).to have_selector "table"
        end
      end

    feature "自分のプロフィールの更新" do
      before do
        @phone_number = Faker::Base.regexify(/0[0-9]{9,10}/)
        visit edit_owner_path(@owner1)
        find_field('owner[last_name]').set('updated_last_name')
        find_field('owner[first_name]').set('updated_first_name')
        find_field('owner[last_kana]').set('updated_last_kana')
        find_field('owner[first_kana]').set('updated_first_kana')
        find_field('owner[phone_number]').set(@phone_number)
        find_field('owner[email]').set('hogehoge@example.com')
        find("input[name='commit']").click
      end
      scenario "ownerが更新されているか" do
        expect(page).to have_content "updated_last_name"
        expect(page).to have_content "updated_first_name"
        expect(page).to have_content "updated_last_kana"
        expect(page).to have_content "updated_first_kana"
        expect(page).to have_content @phone_number
        expect(page).to have_content "hogehoge@example.com"
      end
      scenario "リダイレクト先は正しいか" do
        expect(page).to have_current_path owner_path(@owner1)
      end
    end
  end












end

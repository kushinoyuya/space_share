# frozen_string_literal: true

class Owners::SessionsController < Devise::SessionsController

  # ログイン後予約一覧画面に遷移するpathを設定
  def after_sign_in_path_for(resource)
    reservations_path(resource)
  end

  # ログアウト後オーナーログイン画面へ遷移するpathを設定
  def after_sign_out_path_for(resource)
    new_owner_session_path
  end



  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

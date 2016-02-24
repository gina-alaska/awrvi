class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  skip_authorization_check

  def open_id
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "OpenID")
    else
      session['devise.open_id_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def developer
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Developer")
    else
      session['devise.developer_data'] = request.env['omniauth.auth']
      redirect_to user_omniauth_authorize_path(:developer)
    end
  end

  def failure
    redirect_to root_path
  end
end

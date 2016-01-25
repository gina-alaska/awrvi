class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

  def open_id
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "OpenID")
    else
      session['devise.open_id_data'] = request.evn['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

def open_id
  # You need to implement the method below in your model
  @user = User.find_for_open_id(env["omniauth.auth"], current_user)
  if @user.persisted?
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
    sign_in_and_redirect @user, :event => :authentication
  else
    session["devise.open:id_data"] = env["openid.ext1"]
    redirect_to new_user_registration_url
  end
end
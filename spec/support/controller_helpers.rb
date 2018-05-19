module ControllerHelpers
  def login_user(user = create(:user))
    session[:user_id] = user.id
    session[:ctime] = Time.now.tomorrow.utc.to_i
  end
end

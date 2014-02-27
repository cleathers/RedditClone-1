module SessionsHelper
  def current_user=(user)
    @current_user = user
    session[:token] = user.token
  end

  def current_user
    return nil if session[:token].nil?
    @current_user ||= User.find_by_token(session[:token])
  end

  def logout!
    current_user.reset_token!
    session[:token] = nil
  end

  def logged_in?
    !!current_user
  end

end

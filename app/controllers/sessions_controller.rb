class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user][:username],params[:user][:password])

    if @user.nil?
      flash.now[:errors] = ["Invalid login/credentials"]
      render :new
    else
      self.current_user = @user
      redirect_to root_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  def new
    @user = User.new
    render :new
  end

  private
    def session_params
      params.require(:user).permit(:username, :password)
    end

end

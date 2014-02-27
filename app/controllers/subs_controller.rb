class SubsController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @subs = current_user.subs
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.mod_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:name)
  end

  def link_params
    params.permit(:links => [:title, :url, :body]).require(:links).values
  end

  def ensure_logged_in
    unless logged_in?
      flash[:errors] = ['You need to log in']
      redirect_to new_session_url
    end
  end

end

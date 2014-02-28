class SubsController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @subs = current_user.subs
  end

  def new
    @sub = Sub.new
    5.times { @sub.links.build }
    render :new
  end

  def create
    @sub = Sub.new(sub_params)

    @sub.mod_id = current_user.id
    @sub.links.new(link_params)



    @sub.links.each do |link|
      link.user_id = current_user.id
    end

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    get_sub
    render :show
  end

  def edit
    get_sub
    (5 - @sub.links.count).times { @sub.links.build }
    render :edit
  end

  def update
    get_sub

      # Goes through each array in link_params
      # Checks if current_link is a link. If it is, updates
      # checks its subs array to see if it's in the current sub. Updates if it is
      # else, it assigns a user_id to the hash and builds a new link.
 
      # Be wary my N + 1 query
 
      link_params.each do |link|
        current = Link.find_by_url(link[:url])
        current.nil?
 
        if !current.nil? && current.subs.where( :id == @sub.id)
          current.update_attributes(link)
        else
          link['user_id'] = current_user.id
          @sub.links.new(link)
        end
      end
 
 
      if @sub.update_attributes(sub_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        @sub.links.each { |link| flash.now[:errors] << link.errors.full_messages }
        render :edit
      end
  end

  private
  def get_sub
    @sub = Sub.find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:name)
  end

  def link_params
    params.permit(:links => [:title, :url, :body])
          .require(:links)
          .values
          .reject { |data| data.values.all?(&:blank?) }
  end

  def ensure_logged_in
    unless logged_in?
      flash[:errors] = ['You need to log in']
      redirect_to new_session_url
    end
  end



end

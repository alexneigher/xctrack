class HomeController < ApplicationController
  before_action :fetch_users

  def index
    #scope this by group later
    @users = User.all
    if params[:pilot_ids]
      @rendered_user_ids = params[:pilot_ids].split(',').map(&:to_i)
    else
      @rendered_user_ids = @users.map(&:id)
    end
  end

  def fetch_coordinates
    @coordinates = @users.map(&:fetch_coordinates)
    render :json => @coordinates
  end

  private

    def fetch_users
      user_ids = params[:pilot_ids]
      if user_ids.present?
        ids = user_ids.split(',')
        @users = User.where(id: ids)
      else
        @users = User.all
      end

    end

end

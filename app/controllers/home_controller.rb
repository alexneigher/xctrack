class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :fetch_users

  def index
  end

  def fetch_coordinates
    @coordinates = @users.map(&:fetch_coordinates)
    render :json => @coordinates
  end

  private

    def fetch_users
      user_ids = params[:pilot_ids]
      if user_ids
        ids = user_ids.split(',')
        @users = User.where(id: ids)
      else
        @users = User.all
      end

    end

end

class HomeController < ApplicationController
  before_action :fetch_users

  def index
    @coordinates = @users_on_map.map(&:fetch_coordinates)
  end


  private
    def fetch_users
      @users = User.all #scope by current group eventually

      if params[:pilots]
        ids = params[:pilots].split(',')
        @users_on_map = @users.where(id: ids)
      else
        @users_on_map = @users
      end

      @rendered_user_ids = @users_on_map.map(&:id)
    end

end


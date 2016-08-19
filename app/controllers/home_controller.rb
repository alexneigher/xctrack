class HomeController < ApplicationController

  def index
    @users = User.all
  end

  def fetch_coordinates
    @users = User.all
    @coordinates = @users.map(&:fetch_coordinates)
    render :json => @coordinates
  end

end

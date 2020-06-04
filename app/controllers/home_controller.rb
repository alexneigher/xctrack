class HomeController < ApplicationController

  def index
    fetch_users
    @coordinates = @users_on_map.map(&:fetch_coordinates)
  end

  def terms_and_conditions

  end

end


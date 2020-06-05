class HomeController < ApplicationController

  def index
    fetch_users
    @coordinates = @users_on_map.map(&:fetch_coordinates)
  end

  def terms_and_conditions

  end

  def privacy_policy

  end

  def accept_terms_and_purchase
    user = current_user

    user.update(accepted_terms_and_privacy: true)

    redirect_to root_path
  end

end


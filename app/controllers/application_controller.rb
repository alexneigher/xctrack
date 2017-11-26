class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl if: :ssl_configured?

  private

    def fetch_users(group = nil)
      user_collector = UserCollectorService.new(group, params)
      
      @users = user_collector.users

      @users_on_map = user_collector.users_on_map

      @rendered_user_ids = user_collector.rendered_user_ids
    end

    def ssl_configured?
      !Rails.env.development?
    end
end

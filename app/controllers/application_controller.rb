class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def fetch_users(group = nil)

      if group
        @users = group.users.with_waypoints.order(:name)
      else
        @users = User.with_waypoints.order(:name)
      end

      #for a specific subset of pilots (specified by params)
      if params[:pilots]
        ids = params[:pilots].split(',')
        @users_on_map = @users.where(id: ids)

      #if no params, but in groups show page
      elsif group
        @users_on_map = @users

      #don't show anybody
      else
        @users_on_map = []
      end

      @rendered_user_ids = @users_on_map.map(&:id)
    end
end

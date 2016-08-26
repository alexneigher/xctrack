class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def fetch_users(group = nil)

      if group
        @users = group.users.order(:name)
      else
        @users = User.all.order(:name)
      end

      if params[:pilots]
        ids = params[:pilots].split(',')
        @users_on_map = @users.where(id: ids)
      else
        @users_on_map = []
      end

      @rendered_user_ids = @users_on_map.map(&:id)
    end
end

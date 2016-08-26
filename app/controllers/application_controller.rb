class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    #make sure only admin users have access to certain pages
    def authenticate_admin_access
      unless current_user.admin? || @user == current_user
        flash[:error] = 'Bad Robot'
        redirect_to users_path
      end
    end

    def fetch_users(group = nil)
      if group
        @users = group.users
      else
        @users = User.all
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

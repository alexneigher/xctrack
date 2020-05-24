class UserCollectorService

  def initialize(group = nil, params = {})
    @group = group
    @params = params
  end

  #check for group members, or just all users, memoize them for later use
  def users
    if @group
      @users ||= @group.users.tracking_enabled.with_waypoints.order(:name)
    else
      @users ||= User.tracking_enabled.with_waypoints.order(:name)
    end
  end

  def users_on_map
    #for a specific subset of pilots (specified by params)
    if @params[:pilots]
      ids = @params[:pilots].split(',')
      users_on_map = @users.where(id: ids)

    #if no params, but in groups show page
    elsif @group
      users_on_map = @users

    #don't show anybody
    else
      users_on_map = []
    end

    users_on_map
  end

  def rendered_user_ids
    users_on_map.collect(&:id)
  end

end

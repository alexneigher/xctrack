module ApplicationHelper

  def title_helper
    base_string = 'XcTrack - The Mobile Pilot Tracker'
    return base_string unless @group || @users_on_map

    if @group
      str = "- #{@group.name}"
    elsif @users_on_map.length > 1
      str = 'Multiple Active Pilots'
    elsif @users_on_map.length == 1
      str = "- #{@users_on_map.first.name}"
    end

    return "#{base_string} #{str}"
  end

  def add_user_to_map(rendered_user_ids, user, current_group, *args, &block)
    if current_group
      link_to group_path(current_group, pilots: (rendered_user_ids + [user.id]).join(',')), *args, &block
    else
      link_to root_path(pilots: (rendered_user_ids + [user.id]).join(',')), *args, &block
    end

  end

  def remove_user_from_map_link(rendered_user_ids, user, current_group, *args, &block)
    if current_group
      link_to group_path(current_group, pilots: (rendered_user_ids - [user.id]).join(',')), *args, &block
    else
      link_to root_path(pilots: (rendered_user_ids - [user.id]).join(',')), *args, &block
    end
  end


  def show_all_path(rendered_user_ids, current_group, *args, &block)
    if current_group
      link_to group_path(current_group), *args, &block
    else
      link_to root_path(pilots: rendered_user_ids), *args, &block
    end
  end
end

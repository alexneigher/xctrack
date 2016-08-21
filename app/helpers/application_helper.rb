module ApplicationHelper

  def add_user_to_map(rendered_user_ids, user)
    (rendered_user_ids + [user.id]).join(',')
  end

  def remove_user_from_map(rendered_user_ids, user)
    (rendered_user_ids - [user.id]).join(',')
  end
end

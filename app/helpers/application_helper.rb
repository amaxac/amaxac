module ApplicationHelper
  def css_nav_item(action_name)
    "active"  if controller.action_name == action_name
  end

  def title_for_output
    content_for?(:title) ? yield(:title) : "Обман, чтобы набрать классы"
  end
end

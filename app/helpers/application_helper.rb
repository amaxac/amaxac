module ApplicationHelper
  def css_nav_item(action_name)
    "active"  if controller.action_name == action_name
  end

  def title_for_output
    content_for?(:title) ? yield(:title) : "Обман, чтобы набрать классы"
  end

  def image_for_output(image)
    image_tag(image.link, alt: image.text)
  end

  def klass_button(image)
    link_to klass_image_path(image), class: "klass-button btn btn-sm", method: :post, remote: true, disabled: image.voted?(request.remote_ip) do
      # fa_icon("thumbs-o-up") + " КЛАСС " +
      content_tag(:i, nil, class: "klass-icon") + " Класс! " +
      (image.rating.to_s  if image.rating > 0)
    end
  end
end

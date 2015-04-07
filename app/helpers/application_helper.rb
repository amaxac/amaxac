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
    options = { class: "klass-button btn btn-sm", method: :post, remote: true, disabled: image.voted?(request.remote_ip) }
    link_to klass_image_path(image), options do
      content_tag(:i, nil, class: "klass-icon") + " Класс! " +
      (image.rating.to_s  if image.rating > 0)
    end
  end

  def menu_item(css_class, link)
    content_tag(:li, link, class: css_nav_item(css_class))
  end

  def footer_content
    author = link_to("Vizakenjack", "http://vzkj.ru", target: "_blank")
    vk_group = link_to("Филиалом Одноклассников", "http://vk.com/ok_filial", target: "_blank")
    github = link_to("Исходный код", "https://github.com/Vizakenjack/ok", target: "_blank")
    "Сделал #{author} | Вдохновлен #{vk_group} | #{github}".html_safe
  end
end

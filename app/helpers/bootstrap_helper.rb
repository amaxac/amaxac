module BootstrapHelper
  ALERT_TYPES = [:error, :info, :success, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?
      
      type = :success if type == 'notice'
      type = :danger   if type == 'alert'
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                           msg.to_s.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def glyph(name, *classes)
    css_class = "glyphicon glyphicon-#{name}"
    css_class << " " + classes.map { |e| e }.join(" ")  if classes.present?
    content_tag :i, nil, :class => css_class
  end

end
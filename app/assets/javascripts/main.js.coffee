window.create_alert = (response, style) ->
  if window.processing
    return false
  if typeof(response) == "string"
    response = { message: response }

  style = style || "success";

  window.processing = true
  dismiss = '<a class="close" data-dismiss="alert">×</a>'
  if response.header
    h4 = '<h4 class="alert-heading">'+response.header+'</h4>'
  else
    h4 = ''
  inner_p = '<p>'+response.message+'</p>'
  alert_window = '<div id="handy-alert"><div class="inner-alert alert alert-'+style+'">'+dismiss+h4+inner_p+'</div></div>'

  $('#handy-alert').replaceWith(alert_window)
  $('#handy-alert').css('display', 'none').slideDown('normal')
  window.processing = false
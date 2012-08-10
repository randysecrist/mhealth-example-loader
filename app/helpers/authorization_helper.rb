module AuthorizationHelper
  def app_checkbox(app_name)
    ('<div class="control-group">' +
     '<label class="control-label">' +
    app_name.titleize +
    '</label><div class="controls">' +
    check_box_tag('app[]', app_name) +
    "</div></div>").html_safe
  end
end

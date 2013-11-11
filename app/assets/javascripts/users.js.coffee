//= require ajax_submit

window.admin_user_group_add = (obj)->
  makeAjaxPost(
    window.location.href + "/group_add",
    { group: $("#group").val() },
    (data, stat, xhr)->
      $("#active_admin_content .user .groups").html(data.group_form)
      register_admin_user_group()
    (xhr, stat, err)->
      alert(stat);
  )

window.admin_user_group_remove = (obj)->
  makeAjaxPost(
    $(this).find("a").attr("href"), 
    {}, 
    (data, stat, xhr)->
      $("#active_admin_content .user .groups").html(data.group_form)
      register_admin_user_group()
    (xhr, stat, err)->
      alert(stat);
  )
  event.preventDefault();
  return false;


window.register_admin_user_group = ->
  $("#active_admin_content .user .groups select#group").on("change", admin_user_group_add)
  $("#active_admin_content .user .groups div.group .action").on("click", admin_user_group_remove)

$(document).ready ->
  register_admin_user_group()

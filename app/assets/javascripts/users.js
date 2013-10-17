function makeAjaxCall(ajaxUrl, functionSuccess, functionFailure){
 $.ajax({
  type: "GET",
  url: ajaxUrl,
  contentType: "application/json; charset=utf-8",
  data: {},
  dataType: "json",
  success: functionSuccess,
  error: functionFailure
 });
}

function makeAjaxDestroy(ajaxUrl, dataHash, functionSuccess, functionFailure){
 $.ajax({
  type: "DELETE",
  url: ajaxUrl,
  contentType: "application/json; charset=utf-8",
  data: dataHash,
  dataType: "json",
  success: functionSuccess,
  error: functionFailure
 });
}

function makeAjaxPost(ajaxUrl, dataHash, functionSuccess, functionFailure){
 $.ajax({
  type: "POST",
  url: ajaxUrl,
  //contentType: "application/json; charset=utf-8",
  data: $.param(dataHash),
  dataType: "json",
  processData: false,
  success: functionSuccess,
  error: functionFailure
 });
}

function admin_user_group_add(obj){
 makeAjaxPost(window.location.href + "/group_add", {group: $("#group").val()}, function(data, stat, xhr){
  $("#active_admin_content .user .groups").html(data.group_form);
  register_admin_user_group();
 }),
 function(xhr, stat, err){
  alert(stat);
 }
}

function admin_user_group_remove(obj){
 makeAjaxPost($(this).find("a").attr("href"), {}, function(data, stat, xhr){
  $("#active_admin_content .user .groups").html(data.group_form);
  register_admin_user_group();
 },
 function(xhr, stat, err){
  alert(stat);
 });
 event.preventDefault();
 return false;
}

function register_admin_user_group(){
 $("#active_admin_content .user .groups select#group").on("change", admin_user_group_add);
 $("#active_admin_content .user .groups div.group .action").on("click", admin_user_group_remove);
}
$(document).ready(function(){
 register_admin_user_group();
});

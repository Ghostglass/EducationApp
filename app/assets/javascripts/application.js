// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui/widget
//= require jquery-ui/widgets/sortable
//= require_tree .

window.onload = function () {
  function fadeAlert(){
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
      $(this).remove();
    });
  }

  window.setTimeout(fadeAlert, 4000);

  $(".p-ipt").click(function () {
    const internal_label = $(this).find("+ span");
    internal_label.addClass("internal-label-anim");
  });
  $(".p-ipt").blur(function () {
    const internal_label = $(this).find("+ span");
    internal_label.removeClass("internal-label-anim");
  });
}

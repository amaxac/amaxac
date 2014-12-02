// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require zeroclipboard
//= require turbolinks
//= require_tree .


function ready() {
  $(".autocomplete").autocomplete({
    source: '/images/autocomplete.json',
    select: function( event, ui ) {
      $(this).val(ui.item.label);
      $("form.image").submit();
      $(this).val('')
      return false;
    }
  });
}

function init_clipboard_copy() {
  var client = new ZeroClipboard( $(".copy") );
  client.on( "ready", function( readyEvent ) {
    client.on( "aftercopy", function( event ) {
      var t = $(event.target);
      t.text(t.data("clipboard-text") + " - скопировано")
    } );
  } );
}

function slide_row(object) {
  object.closest('tr')
      .children('td')
      .animate({ padding: 0 })
      .wrapInner('<div />')
      .children()
      .slideUp("normal", function() { object.closest('tr').remove(); });
}




$(document).ready(ready);
$(document).on('page:load', ready);

$(document).on("page:change", function(){
  init_clipboard_copy();
});

$(document).on("page:before-change", function(){
  ZeroClipboard.destroy();
});
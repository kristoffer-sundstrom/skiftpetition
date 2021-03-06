// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
    var availableTags = ["Dokan Dojo", "Dynamix Herrljunga", "Dynamix Köping", "Göteborgs Ju-jutsuklubb", "JJK Samurai", "Ju-Jutsu Ryu Jönköping", "Kumla Kampsport", "Köping Martial Arts", "Linköping Budoklubb", "Linköpings Budoklubb", "Linköpings Budoklubb/Grizzly MMA", "Shindo", "Västerås Ju-Jutsuklubb", "Växjö Ju-jutsuklubb/ Team Dynamix", "Växjö Jujutsuklubb", "Växjö ju-jutsu", "Örnsköldsviks Ju-Jutsu Club"];

    function split( val ) {
          return val.split( /,\s*/ );
        }
        function extractLast( term ) {
          return split( term ).pop();
        }

    $("#registration_club")
          .bind( "keydown", function( event ) {
            if ( event.keyCode === $.ui.keyCode.TAB &&
                $( this ).data( "autocomplete" ).menu.active ) {
              event.preventDefault();
            }
          })
          .autocomplete({
            minLength: 0,
            source: function( request, response ) {
              // delegate back to autocomplete, but extract the last term
              response( $.ui.autocomplete.filter(
                availableTags, extractLast( request.term ) ) );
            },
            focus: function() {
              // prevent value inserted on focus
              return false;
            },
            select: function( event, ui ) {
              var terms = split( this.value );
              // remove the current input
              terms.pop();
              // add the selected item
              terms.push( ui.item.value );
              // add placeholder to get the comma-and-space at the end
              terms.push( "" );
              this.value = terms.join( ", " );
              return false;
            }
          });


});
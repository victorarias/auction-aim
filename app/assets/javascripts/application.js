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
//= require message-bus.js
//= require_tree .

$(function() {
  MessageBus.start();

  MessageBus.callbackInterval = 500;
  MessageBus.subscribe("/bids", function(data){
    data = JSON.parse(data);
    updateBids(data.id, data.bids);
  });

  function updateBids(item_id, bids) {
    list = $("#" + item_id);
    rendered_bids = render_bids(bids);
    list.empty().append(rendered_bids);
  }

  function render_bids(bids) {
    return bids.map(function(bid) {
      li = $("<li/>").append(bid.amount.toString() + " SEK");
      li.css('color', bid.color);
      return li;
    });
  }
});



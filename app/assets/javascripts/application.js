// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require underscore
//= require_tree .


$(function() {
  window.addPanel({id: 'customer-list', title: 'Customers', content: '/customers.html'});
  window.addPanel({id: 'current-projects-list', title: 'Current Projects', content: '/projects/current.html'});
  window.addPanel({id: 'leads-list', title: 'Leads', content: '/projects/lead.html'});
  window.addPanel({id: 'my-projects-list', title: 'My Projects', content: '/projects/my.html'});
  window.addPanel({id: 'ticket-list', title: 'Tickets', content: '/tickets.html'});
/*
  window.addPanel({id: 'ticket-list', title: 'Tickets', content: '/tickets.html'});
  window.addPanel({id: 'new-customer', title: 'New Customer', content: '/customers/new.html'});
  window.addPanel({id: 'new-ticket', title: 'New Ticket', content: '/tickets/new.html'});
*/
  $('#panels').sortable({
    connectWith: 'header',
    handle: 'h2',
    tolerance: 'pointer',
    placeholder: 'panel placeholder',
    items: 'div.panel',
    start: function(event, ui) {
      klass = ui.helper.attr('class').match(/width-\d/)[0];
      ui.placeholder.addClass(klass).html('<section class="panel"></section>');
    }
  });

  $('#panels .panel a').live('click', function() {
    window.addAside({
      title: $(this).text(),
      id: $(this).attr('href').replace(/\//g, '-'),
      content: $(this).attr('href')
    });
    return false;
  });

  $('aside a').live('click', function() {
    var popups = [];
    $('aside a').each(function() {
      var popup =  {
        title: $(this).text(),
        id: $(this).attr('href').replace(/\//g, '-'),
        content: $(this).attr('href')
      }
      popups.push(popup);
    });
    window.addPopup(popups, $(this).attr('href').replace(/\//g, '-'));
    return false;
  });

  $('#popup a[href^=/]').live('click', function() {
    window.addPopup({
      title: $(this).text(),
      id: $(this).attr('href').replace(/\//g, '-'),
      content: $(this).attr('href')
    });
    return false;
  });

  $('body.sessions #content, body.registrations #content, body.passwords #content, body.confirmations #content').dialog({
      title: $('h2').text(),
      draggable: false,
      width: $(window).width() / 2,
      height: $(window).height() / 2 ,
      resizable: false,
      create: function(event, ui) {
        window.popupButtons($(this));
      },
      close: function(event, ui) {
        window.location = '/';
      }
    });

});


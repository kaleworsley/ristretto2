window.addAside = (aside) ->
  Aside = _.template('''
  <aside id="aside-<%= id %>">
    <section class="panel">
      <h2><%= title %></h2>
      <div class="content">
      </div>
    </section>
  </div>
  ''')

  $('body aside').remove();
  $('body').addClass('aside');
  $('body #dashboard').append(Aside(aside))
  $('#aside-' + aside.id + ' .content').load(aside.content + ' #content')


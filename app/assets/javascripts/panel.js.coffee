window.addPanel = (panel) ->
  Panel = _.template('''
  <div class="panel <%= width %>">
    <section id="panel-<%= id %>" class="panel">
      <h2><%= title %></h2>
      <div class="content">
      </div>
    </section>
  </div>
  ''')
  panel = _.extend({width: 'width-1'}, panel)
  $('#panels').append(Panel(panel))
  $('#panel-' + panel.id + ' .content').load(panel.content + ' #content');


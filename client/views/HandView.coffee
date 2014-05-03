class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'playerLoses', => @gameEnd('loses')
    @collection.on 'playerWins', => @gameEnd('wins')
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  gameEnd: (outcome) ->
    @$el.append '<div>Game Over</div><div>Player '+outcome+'</div>'
    $('.hit-button').attr('disabled', true)
    $('.stand-button').attr('disabled', true)
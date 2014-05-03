class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @model.on 'playerWins', => @gameEnd('wins')
    @model.on 'playerLoses', => @gameEnd('loses')
    @model.on 'playerTies', => @gameEnd('ties')

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  gameEnd: (outcome) ->
    $('body').append '<div>Game Over</div><div>Player ' + outcome + '</div>'
    $('.hit-button').attr('disabled', true)
    $('.stand-button').attr('disabled', true)
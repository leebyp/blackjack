#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stood', =>
      @get('dealerHand').hit()
    @get('dealerHand').on 'checkGameOutcome', =>
      @checkGameOutcome()

  checkGameOutcome: ->
    playerScores = @get('playerHand').scores()
    dealerScores = @get('dealerHand').scores()
    for value1, key1 in playerScores
      if value1 <= 21
        for value2, key2 in dealerScores
          if value2 <= 21
            if value1 > value2
              @trigger 'playerWins',@
              return
    @trigger 'playerLoses',@
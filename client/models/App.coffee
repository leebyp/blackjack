# app model redirects most of the logic by triggering events, since it has access to the deck and hands of cards

#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    
    @get('playerHand').on 'stood', =>
      @get('dealerHand').hit()

    @get('playerHand').on 'playerLoses', =>
      @trigger 'playerLoses', @
    @get('dealerHand').on 'playerWins', =>
      @trigger 'playerWins', @
    @get('dealerHand').on 'checkGameOutcome', =>
      @checkResults()

  checkResults: ->
    playerScores = @get('playerHand').scores()
    dealerScores = @get('dealerHand').scores()
    playerMaxScore = 0
    for score in playerScores
      if score <= 21
        playerMaxScore = Math.max(playerMaxScore, score) 
    dealerMaxScore = 0
    for score in dealerScores
      if score <= 21
        dealerMaxScore = Math.max(dealerMaxScore, score) 
    if playerMaxScore > dealerMaxScore then @trigger 'playerWins', @
    else if playerMaxScore < dealerMaxScore then @trigger 'playerLoses', @
    else if playerMaxScore == dealerMaxScore then @trigger 'playerTies', @
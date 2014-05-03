class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    if @isDealer?
      @checkDealer()
    else
      @checkPlayer()

  stand: ->
    @trigger 'stood',@

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  printScores: ->
    scoresarray = @scores()
    score1 = scoresarray[0]
    score2 = scoresarray[1]
    if score2?
      "#{score1} or #{score2}"
    else 
      "#{score1}"


  checkPlayer: ->
    if @scores()[0] > 21 then @trigger 'playerLoses', @

  checkDealer: ->
    dealerScore = @scores()
    length = dealerScore.length
    if dealerScore[0] > 21
      @trigger 'playerWins', @
      return
    if dealerScore[length-1] < 17
      @hit()
      return
    for score in dealerScore
      if 17 <= score <= 21
        @trigger 'checkGameOutcome',@
        return

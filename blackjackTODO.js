# Collections
	. Deck
		- takes the Card model
		- on initialise, creates method 'ADD', creates array from 0-51, shuffles, then gives them an object param (rank 0-12, suit 0-3), and returns
		- has method to 'DEALPLAYER', creates and returns new hand collection, both showing
		- has method to 'DEALDEALER', creates and returns new hand collection, one hidden one showing
	. Hand
		- takes the Card model,
		- has method to 'HIT', this.add(this.deck.pop()).last()
		- has method to 'SCORES', potential scores array, taking into account aces in hand

# Models
	. App
		- sets 'DECK' new deck
		- sets 'PLAYERHAND', using deck.DEALPLAYER
		- sets 'DEALERHAND', using deck.DEALDEALER
	. Card
		- on initialise, creates property 'SET', with revealed, value, suitName, rankName (from params)
		- has method 'FLIP', flips revealed true/false and returns card

# Views
	. AppView
		- click HIT, get the PLAYERHAND from APPMODEL and do HIT method
		- click STAND, get the PLAYERHAND from APPMODEL and do STAND method
		- render on initialise
	. CardView
		- LISTENS to: re-render when CARDMODEL changes (ie. the flip method is instantiated happens)
	. HandView
		- LISTENS to: re-render when HANDCOLLECTION add remove changes, renders revealed scores of hand from HAND.SCORES



****************************************************************
//. check the score on every HIT - if over 21, BUST => end of game
. set the DEALERHAND revealed to TRUE, when player stands in APPMODEL
. dealer deals continuously until over 17 && better than players score || self bust => end of game

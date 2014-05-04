# card view to re-render on additional card (flips between the revealed / unrevealed card)

class window.CardView extends Backbone.View

  className: 'card'

#  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
#    @$el.html @template @model.attributes
    @$el.css('background-image', 'url(img/cards/'+ @model.get('rankName') + '-' + @model.get('suitName') + '.png)') unless !@model.get 'revealed'
    @$el.addClass 'covered' unless @model.get 'revealed'

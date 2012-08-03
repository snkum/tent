

Tent.ResizeSupport = Ember.Mixin.create
  resize: ->
  	# Propagate the event down the tree. This is the only even that trickles down as opposed to bubbling up
  	@get('childViews').forEach (child) -> child.resize()

Ember.$(document).ready -> 
  Ember.View.reopen Tent.ResizeSupport
  window.onresize = ->
    for view of Em.View.views
      if !Ember.View.views[view].get('parentView')
        break
    rootView = Ember.View.views[view]
    rootView.resize() if rootView && typeof(rootView.resize) == 'function'
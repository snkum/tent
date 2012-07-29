#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.SpanSupport = Ember.Mixin.create
  estimateSpan: ->
    currentView = this
    while (currentView)
      span = Number(currentView.get('span'))
      unless (span == 0) || isNaN(span)
        return span
      currentView = currentView.get('parentView')
    12

  spanClass: (-> 'span' + @get('span') if @get('span')).property('span')

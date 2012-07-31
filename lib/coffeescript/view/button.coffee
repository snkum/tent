#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Button = Ember.View.extend
  classNames : ['btn']
  tagName : 'button'
  template: Ember.Handlebars.compile '{{view.translatedLabel}}'

  init: ->
    @_super()
    type = @get('type')
    classNames = @get('classNames')
    classNames.push('btn-' + type) if type  

  translatedLabel: (->
    Tent.translate @get('label')
  ).property('label')      
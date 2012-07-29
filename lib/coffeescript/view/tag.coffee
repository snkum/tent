#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Tag = Ember.View.extend
  tagName: 'span'
  type: 'info'
  classNameBindings: ['labelClasses']
  labelClasses: (-> 'label ' +  'label-' + @get('type')).property('type')
  template: Ember.Handlebars.compile '{{view.translatedText}}'

  init: ->
    @_super()
    type = @get('type')
    classNames = @get('classNames')
    classNames.push('label-' + type) if type

  translatedText: (->
    Tent.translate @get('text')
  ).property('text')

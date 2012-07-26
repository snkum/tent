#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Tag = Ember.View.extend
  tagName: 'span'
  classNames: (->
    type = @get('type')
    ['label', if type then 'label-' + type else '']
  ).property('type')
  template: Ember.Handlebars.compile '{{view.translatedText}}'

  translatedText: (->
    Tent.translate @get('text')
  ).property('text')

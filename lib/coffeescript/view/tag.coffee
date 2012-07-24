#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Tag = Ember.View.extend
  tagName: 'span'
  classNames: ['label', 'label-info']
  template: Ember.Handlebars.compile '{{view.translatedText}}'

  translatedText: (->
    Tent.translate @get('text')
  ).property('text')

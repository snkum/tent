#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests AmountField UI Widget part of the tent library.
#
module "Tent.AmountField Widget", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure currency is appended and has numeric only', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField valueBinding="name" labelBinding="label" currencyBinding="currency"}}'
    name: '111111'
    label: 'FooBar'
    currency: 'USD'

  appendView()

  equal view.$('.add-on').text(), view.get('currency'), 'currency is rendered'
  equal view.$('.error').length, 0, 'error class gets applied'
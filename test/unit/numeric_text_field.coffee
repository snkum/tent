#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests NumericTextField UI Widget part of the tent library.
#
module "Tent.NumericTextField Widget", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure it gives error for non numeric values', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  equal view.$('.error').length, 1, 'error class gets applied'
  equal view.$('.help-inline').text(), Tent.messages.NUMERIC_ERROR, 'Received Tent.messages.NUMERIC_ERROR'  


test 'Ensure it gives no error for numeric values', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" labelBinding="label"}}'
    name: '1234'
    label: 'FooBar'

  appendView()

  equal view.$('.error').length, 0, 'no error class applied'
  equal view.$('.help-inline').text(), '', 'no error received'  
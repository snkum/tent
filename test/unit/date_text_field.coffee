#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'sci-ui'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests UI Widgets part of the sci-ui library.
#
module "SCi - Basic Widgets", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure Date TextField renders for text date', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view SCiCustomer.DateTextView valueBinding="date" }}'
    date: '10/5/2012'

  appendView()

  ok view.$('input')?, 'text input field gets rendered'
  equal view.$('input').attr('value'), "10/5/2012", 'Date is rendered'


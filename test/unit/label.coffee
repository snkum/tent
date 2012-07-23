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

test 'Ensure Label is rendered', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view SCi.Label}}'
    
  appendView()

  ok view.$()?, 'label gets rendered'
  equal view.$('.labels').length, 1, 'labels class gets applied'
  

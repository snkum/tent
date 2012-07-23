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

test 'Ensure Checkboxes are rendered', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view SCi.Check}}'
    
  appendView()

  ok view.$()?, 'checkbox gets rendered'
  equal view.$('.checkbox').length, 1, 'btn-init class gets applied'
  

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

test 'Ensure ButtonView rendered', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view SCi.Button}}'
    isActive: true
    isDisabled: false
 
  appendView()

  ok view.$()?, 'button field gets rendered'
  equal view.$('.btn-init').length, 1, 'btn-init class gets applied'
    
test 'enable button function', ->
  view = SCi.Button.create()
  view.enableButton()
  isActive = view.isActive
  isDisabled = view.isDisabled
  equal isActive, true, "button active"
  equal isDisabled, false, "button disabled"
  

test 'disable button function', ->
  view = SCi.Button.create()
  view.disableButton()
  isActive = view.isActive
  isDisabled = view.isDisabled
  equal isActive, false, "button active"
  equal isDisabled, true, "button disabled"
  


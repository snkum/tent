#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests UI Widgets part of the tent library.
#
module "Tent - Basic Widgets", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure TextField renders for text', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  ok view.$('input')?, 'text input field gets rendered'
  equal view.$('.tent-text-field').length, 1, 'tent-text-field class gets applied'
  equal view.$('label').text(), Tent.translate(view.get('label')), 'label is rendered'

test 'Ensure Textfield renders Span if isEditable=false', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label" isEditable=false}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()
  
  ok view.$('span')?, 'span gets rendered'
  equal $('.controls span').text(), view.get('name') , 'value is set to span'
  equal view.$('.uneditable-input').length, 1, 'uneditable-input class gets applied'

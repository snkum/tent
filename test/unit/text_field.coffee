#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

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

test 'Ensure TextField renders for text', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view SCi.TextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  ok view.$('input')?, 'text input field gets rendered'
  equal view.$('.sci-text-field').length, 1, 'sci-text-field class gets applied'
  equal view.$('.label').text(), SCi.translate(view.get('label')), 'label is rendered'
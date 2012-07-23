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

test 'Ensure search TextField renders for text', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view SCiCustomer.SearchBox valueBinding="name" labelBinding="label" placeholderBinding="SEARCH"}}'
    name: 'foobar'
    label: 'Foo Bar'

  appendView()

  ok view.$('input')?, 'text input field gets rendered'
  equal view.$('.search-div').length, 2, 'search-div class gets applied'
  equal view.$('input').attr('placeholder'), "SEARCH", 'Placeholder is rendered'


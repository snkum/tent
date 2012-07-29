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
module "Tent.SpanSupport tests", ->
    @TemplateTests = Ember.Namespace.create()
    @TemplateTests.MockField = Ember.View.extend Tent.SpanSupport
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test "estimateSpan should be able to fetch span when immediate parent is spanned", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view TemplateTests.MockField id="field" valueBinding="name" label="estimateSpan Test"}}'
    span: 5

  appendView()

  equal Ember.View.views.field.estimateSpan(), 5, 'estimateSpan is fetched correctly when immediate parent has a numeric span'

  view.set('span', '11')
  equal Ember.View.views.field.estimateSpan(), 11, 'estimateSpan is fetched correctly when immediate parent has a non-numeric number span'

  view.set('span', 'sfw')
  equal Ember.View.views.field.estimateSpan(), 12, 'estimateSpan is estimated correctly when immediate parent has a NaN span'

test "estimateSpan should be able to fetch span when a non-immediate parent is spanned", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{#view}}{{#view}}{{view TemplateTests.MockField id="field" valueBinding="name" label="estimateSpan Test"}}{{/view}}{{/view}}'
    span: 5

  appendView()

  equal Ember.View.views.field.estimateSpan(), 5, 'estimateSpan is fetched correctly when immediate parent has a numeric span'

  view.set('span', '11')
  equal Ember.View.views.field.estimateSpan(), 11, 'estimateSpan is fetched correctly when immediate parent has a non-numeric number span'

  view.set('span', 'sfw')
  equal Ember.View.views.field.estimateSpan(), 12, 'estimateSpan is estimated correctly when immediate parent has a NaN span'


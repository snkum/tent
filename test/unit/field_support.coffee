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
module "Tent.FieldSupport mixin tests", ->
    @TemplateTests = Ember.Namespace.create()
    @TemplateTests.MockField = Ember.View.extend Tent.FieldSupport
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Mandatory fields identified and enforced', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view TemplateTests.MockField valueBinding="name" labelBinding="label" isMandatory="true"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()
 
  ok view.$('.control-group').hasClass('mandatory'), 'mandatory class gets applied'
  ok !view.$('.control-group').hasClass('error'), 'mandatory validation did not kick-in when field has value'

  Ember.run -> view.set('name', '')
  ok view.$('.control-group').hasClass('error'), 'mandatory validation is enforced'


test 'Non-Mandatory fields should not be visually identified', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view TemplateTests.MockField valueBinding="name" labelBinding="label" isMandatory="false"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  ok !view.$('.control-group').hasClass('mandatory'), 'mandatory class was not applied'

test "parentSpan should be able to fetch span when immediate parent is spanned", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view TemplateTests.MockField id="field" valueBinding="name" label="parentSpan Test"}}'
    span: 5

  appendView()

  equal Ember.View.views.field.parentSpan(), 5, 'parentSpan is fetched correctly when immediate parent has a numeric span'

  view.set('span', '11')
  equal Ember.View.views.field.parentSpan(), 11, 'parentSpan is fetched correctly when immediate parent has a non-numeric number span'

  view.set('span', 'sfw')
  equal Ember.View.views.field.parentSpan(), 12, 'parentSpan is estimated correctly when immediate parent has a NaN span'

test "parentSpan should be able to fetch span when a non-immediate parent is spanned", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{#view}}{{#view}}{{view TemplateTests.MockField id="field" valueBinding="name" label="parentSpan Test"}}{{/view}}{{/view}}'
    span: 5

  appendView()

  equal Ember.View.views.field.parentSpan(), 5, 'parentSpan is fetched correctly when immediate parent has a numeric span'

  view.set('span', '11')
  equal Ember.View.views.field.parentSpan(), 11, 'parentSpan is fetched correctly when immediate parent has a non-numeric number span'

  view.set('span', 'sfw')
  equal Ember.View.views.field.parentSpan(), 12, 'parentSpan is estimated correctly when immediate parent has a NaN span'


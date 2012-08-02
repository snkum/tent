#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))


module "Tent.Form tests", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure Tent.Form renders default horizontal style', ->
  view=Tent.Form.create({})
  appendView()
  equal view.get('formStyle'), "horizontal"
  
test 'Ensure Tent.Form renders after set of inner element', ->
  view=Tent.Form.create({
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'
  })
  appendView()
  equal view.get('formStyle'), "horizontal"
  
test 'Ensure Tent.Form renders after set width of Form bellow sum of inner element', ->
  view=Tent.Form.create({
    attributeBindings: "style"
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'
    style: 'width:300px'
  })
  appendView()
  equal view.get('formStyle'), "vertical"
  
test 'Ensure Tent.Form renders after set width of Form above sum of inner element', ->
  view=Tent.Form.create({
    attributeBindings: "style"
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'
    style: 'width:700px'
  })
  appendView()
  equal view.get('formStyle'), "horizontal"
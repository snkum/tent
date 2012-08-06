#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))


module "Tent.Form Phantom tests", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

# test 'Ensure Tent.Form renders after resize of Form', ->
  # view=Tent.Form.create({
    # template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label"}}'
    # name: 'foobar'
    # label: 'FooBar'
  # })
  # appendView()
  # equal view.get('formStyle'), "horizontal",'form style now converted into horizontal'
  # console.log 'Current width ' +$(window).width() + '. Sending window.resize'
  # window.resizeTo(300,900)
  # page.viewportSize = { width: 300, height: 900 }
  # console.log 'Width changed to '+$(window).width()
  # equal view.get('formStyle'), "vertical",'after resize form style now converted into vertical'
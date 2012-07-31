#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

module "Tent.Button tests", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure Button renders', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button label="Primary" typeBinding="type" }}'
    type: "primary"

  appendView()

  ok view.$('button')?, 'button got rendered'
  ok view.$('button').hasClass('btn'), 'btn class gets applied'
  ok view.$('button').hasClass("btn-"+view.get('type')+""), 'type class gets applied'  
  
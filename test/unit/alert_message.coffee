#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

module "Tent.AlertMessage tests", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure AlertMessage renders for text', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AlertMessage text="System will be down on sunday" type="info"}}'

  appendView()

  ok view.$('div')?, 'div got rendered'
  ok view.$('div').hasClass('alert'), 'alert class gets applied'
  ok view.$('div').hasClass('alert-info'), 'alert-info class gets applied'  

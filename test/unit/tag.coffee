#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

module "Tent.Tag tests", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure TextField renders for text', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Tag text="important" type="info"}}'

  appendView()

  ok view.$('span')?, 'span got rendered'
  ok view.$('span').hasClass('label'), 'label class gets applied'
  ok view.$('span').hasClass('label-info'), 'label-info class gets applied'

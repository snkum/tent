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
module "Tent.ProgressBar - Basic Widgets", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy() 
      view = null
    @TemplateTests = undefined

test 'Ensure Progressbar renders ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ProgressBar progress="50" isStriped=true isAnimated=true}}'

  appendView()

  ok view.$('div')?, 'progressbar div gets rendered'
  ok view.$('div').hasClass('bar'), 'bar class gets applied'
  equal view.$().find('.bar').attr('style'),  'width:50%;', 'binds progress as bar width'
  ok view.$('div').hasClass('progress-striped'),  'progress-stripped class applied'
  ok view.$('div').hasClass('active'),  'active class applied for isAnimated' 

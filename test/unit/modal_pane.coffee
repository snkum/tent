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
module "Tent.ModalPane - Basic Widgets", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy() 
      view = null
    @TemplateTests = undefined

test 'Ensure ModalPane renders ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane textBinding="text" headerBinding="header" 
    primaryBinding="primary" secondaryBinding="secondary"}}'
    text: 'Do you want to perform this action!!!'
    header: 'My Heading'
    primary: 'OK'
    secondary: 'Cancel'

  appendView()

  ok view.$('div')?, 'modal div gets rendered'
  ok view.$('div').hasClass('modal-header'), 'modal-header class gets applied'
  ok view.$('div').hasClass('modal-body'), 'modal-body class gets applied'  
  ok view.$('div').hasClass('modal-footer'), 'modal-footer class gets applied'  

  ok view.$("div.modal-header:contains('"+Tent.translate(view.get('header'))+"')").length > 0 , 'header rendered' 
  equal view.$('.modal-body').text().trim(), Tent.translate(view.get('text')), 'body is rendered' 
  ok view.$("div.modal-footer:contains('"+view.get('primary')+"')").length > 0 , 'footer rendered primary'
  ok view.$("div.modal-footer:contains('"+view.get('secondary')+"')").length > 0 , 'footer rendered secondary'   

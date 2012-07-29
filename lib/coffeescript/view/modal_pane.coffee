#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/modal_pane'

jQuery = window.jQuery
modalPaneBackdrop = '<div class="modal-backdrop"></div>'

Tent.ModalPane = Ember.View.extend
  templateName: 'modal_pane'
  classNames: ['modal']
  header:null
  text:null
  primary:null
  secondary:null
  showBackdrop:true

  translatedText: (->
    Tent.translate @get('text')
  ).property('text')

  translatedHeader: (->
    Tent.translate @get('header')
  ).property('header')

  click: (event)->
    target = event.target
    targetClick = target.getAttribute('click')
    (@destroy(); false) if targetClick == 'close' || 'primary' || 'secondary'

  didInsertElement: -> 
    @_appendBackdrop() if @showBackdrop   

  willDestroyElement: ->
    @_backdrop.remove()   

  _appendBackdrop: ->
    @_backdrop = jQuery(modalPaneBackdrop).appendTo(@$().parent())  


Tent.ModalHeader = Ember.View.extend
  tagName: 'h3'
  defaultTemplate: Ember.Handlebars.compile '{{view.parentView.translatedHeader}}'

Tent.ModalBody = Ember.View.extend
  tagName: 'p'
  defaultTemplate: Ember.Handlebars.compile '{{view.parentView.translatedText}}'  
#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

set = Ember.set
get = Ember.get;

require '../template/button_group'

Tent.ButtonGroup = Ember.View.extend 
  templateName: 'button_group'
  classNames: ['btn-group']
  options: null  

  init: -> 
    @_super()
    @set('_options', Ember.ArrayProxy.create({content: @get('options')}) || [] ) 
 
  translatedLabel: (->
    Tent.translate @get('label')
  ).property('label')

  click: (event)->
    if @$().hasClass('open') then @$().removeClass('open') else @$().addClass('open')  
    false
    
Tent.ButtonOptions = Ember.View.extend
  template: Ember.Handlebars.compile '<a href="#">{{view.label}}</a>'

  init: ->
    @_super()
    @optionLabelPath()
    @optionTargetPath()
  
  label: (-> 
    content = get(this, 'content')
    get(content, @_actionLabel)
  ).property('content')  

  target: (-> 
    content = get(this, 'content')
    Tent.translate get(content, @_actionTarget)
  ).property('content')  

  optionLabelPath: ->
    labelPath = get(@, 'parentView.parentView.optionLabelPath')
    return if !labelPath
    @set('_actionLabel', labelPath)

  optionTargetPath: ->
    targetPath = get(@, 'parentView.parentView.optionTargetPath')
    return if !targetPath 
    @set('_actionTarget', targetPath)
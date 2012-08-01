#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

set = Ember.set
get = Ember.get;

require '../template/button_group'

Tent.ButtonGroup = Ember.View.extend 
  templateName: 'button_group'
  classNames: ['tent-btn-group','btn-group']
  options: null  

  init: -> 
    @_super()
    @set('_options', Ember.ArrayProxy.create({content: @get('options')}) || [] ) 

  click: (event)->
    if @$().hasClass('open') then @$().removeClass('open') else @$().addClass('open')  
    false


Tent.ButtonOptions = Ember.View.extend Ember.TargetActionSupport,
  template: Ember.Handlebars.compile '<a href="#">{{view.label}}</a>'

  init: ->
    @_super()
    @optionLabelPath()
    @optionTargetPath()
    @optionActionPath()
  
  click: ->
    dropdown = @get('parentView.parentView')
    if dropdown.$().hasClass('open') then dropdown.$().removeClass('open') else dropdown.$().addClass('open')
    @triggerAction()
    
  label: (-> 
    content = get(this, 'content')
    get(content, @_optionLabel)
  ).property('content')  

  target: (-> 
    content = get(this, 'content')
    get(content, @_optionTarget)
  ).property('content')  

  action: (->
    content = get(this, 'content')
    get(content, @_optionAction)
  ).property('content')

  optionLabelPath: ->
    labelPath = get(@, 'parentView.parentView.optionLabelPath')
    return if !labelPath
    @set('_optionLabel', labelPath)

  optionTargetPath: ->
    targetPath = get(@, 'parentView.parentView.optionTargetPath')
    return if !targetPath 
    @set('_optionTarget', targetPath)

  optionActionPath: ->
    actionPath = get(@, 'parentView.parentView.optionActionPath')
    return if !actionPath
    @set('_optionAction', actionPath)  

    
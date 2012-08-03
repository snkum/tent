#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
require '../template/button'
set = Em.get
get = Em.get
Tent.Button = Ember.View.extend Ember.TargetActionSupport,
  templateName: 'button'
  label: 'Button'
  type: null
  isDisabled: false
  action: null
  classNameBindings:['tent-button','hasOptions:tent-button-group button-group']
  init: ->
    @_super()
    @set('_options', Ember.ArrayProxy.create({content: @get('options')}) || [] )
  targetObject: (->
    if (target = @get('target'))
      return Em.get(target)
    else
      return @get('context')
  ).property('target', 'context')
  triggerAction: ->
    if !@isDisabled 
      if !get(@,'hasOptions')
        @_super() 
      else 
        return (if @$().hasClass('open') then @$().removeClass('open') else @$().addClass('open'))
      
  classes: (->
    classes = (if (type = @get("type")) isnt null and @BUTTON_CLASSES.indexOf(type.toLowerCase()) isnt -1 then "btn btn-" + type.toLowerCase() else "btn")
    classes = classes+" dropdown-toggle" if @get("hasOptions")
    classes = classes+" disabled" if @get("isDisabled")
    return classes
  ).property('type','hasOptions')   
  hasOptions: (->
    (options = @get('_options')) isnt `undefined` and options.get('length') isnt 0
  ).property('_options')
  BUTTON_CLASSES: [
    'primary',
    'info', 
    'success',
    'warning',
    'danger',
    'inverse'
    ]
 

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


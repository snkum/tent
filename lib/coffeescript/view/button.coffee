#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
require '../template/button'

Tent.Button = Ember.View.extend
  templateName: 'button'
  label: 'Button'
  type: null
  isDisabled: false
  isDisabledAsBoolean: Tent.computed.boolCoerceGently 'isDisabled'
  action: null
  target: null
  classes: (->
    classes = (if @get("hasOptions") then ["btn-group"] else ((if (type = @get("type")) isnt null and @BUTTON_CLASSES.indexOf(type.toLowerCase()) isnt -1 then "btn-" + type.toLowerCase() else "")))
    classes = classes+" "+"disabled" if @get("isDisabled")
    return classes
  ).property('type','hasOptions')   
  hasOptions: (->
    @get('options') != undefined
  ).property('options')
  BUTTON_CLASSES: [
    'primary',
    'info', 
    'success',
    'warning',
    'danger',
    'inverse'
    ]
  
Tent.ButtonElement = Ember.Button.extend Ember.TargetActionSupport,
  classNameBindings: ["parentView.classes"] 
  attributeBindings: ["parentView.isDisabledAsBoolean:disabled"] 
  action: (->
    Em.getPath(this,"parentView.action")
  ).property() 
  target:(->
    Em.getPath(this,"parentView.target")
  ).property()
  click: ->
    @triggerAction()

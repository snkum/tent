#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
require '../template/button'

Tent.Button = Ember.View.extend Ember.TargetActionSupport,
  templateName: 'button'
  label: 'Button'
  type: null
  isDisabled: false
  action: null
  targetObject: (->
    if (target = @get('target'))
      return Em.get(target)
    else
      return @get('context')
  ).property('target', 'context')
  triggerAction: ->
    @_super() if !@isDisabled
  classes: (->
    classes = (if @get("hasOptions") then ["btn-group"] else ((if (type = @get("type")) isnt null and @BUTTON_CLASSES.indexOf(type.toLowerCase()) isnt -1 then "btn btn-" + type.toLowerCase() else "btn")))
    classes = classes+" disabled" if @get("isDisabled")
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
 
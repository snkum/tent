#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Button = Ember.View.extend
  label: 'Default'
  type: ''
  isDisabled: false
  event: null
  classNames: ->
    classes = (if @get("hasOptions") then ["btn-group"] else ((if (type = @get("type")) isnt null and @BUTTON_CLASSES.indexOf("btn-" + type) isnt -1 then ["btn-" + type] else [])))
    classes.push('disabled') if @get("isDisabled")
    return classes
  translatedLabel: Tent.translate 'label'
  attributesBinding: ['isDisabled:disabled']
  click: (event)->
    #TODO  event.target is this and @get "event" isnt null
     
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
  

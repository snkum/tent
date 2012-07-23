#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../util/translation_support'

Tent.FieldSupport = Ember.Mixin.create Tent.TranslationSupport, 
  isMandatory: false
  isVisible: true
  isEditable: true
  fieldClass: 'field'
  
  isMandatoryAsBoolean: Tent.computed.boolCoerceGently 'isMandatory'
  isVisibleAsBoolean: Tent.computed.boolCoerceGently 'isVisible'
  isEditableAsBoolean: Tent.computed.boolCoerceGently 'isEditable'



  isHidden: Ember.computed.not 'isVisibleAsBoolean'
  isViewOnly: Ember.computed.not 'isEditableAsBoolean'

  mixinClasses: 'control-group'
  classNameBindings: [
    'mixinClasses'
    'isMandatoryAsBoolean:mandatory'
    'isHidden:hidden'
    'isViewOnly:view-only'
    'hasErrors:error']

  translatedLabel: Tent.computed.translate 'label'

  validate: ->
    value = this.get('value')  
    value? && value != ''

  hasErrors: (->
    !this.validate() if this.validate?
  ).property('value')

  observesErrors: (->
    classNames = @get('classNames')
    if @get('hasErrors')
      classNames[classNames.length] = 'error' unless classNames.contains('error')
    else
      classNames.removeObject 'error'
  ).observes('hasErrors')

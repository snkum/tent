#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../util/translation_support'
require './visibility_support'
require './validation_support'
require './mandatory_support'

Tent.FieldSupport = Ember.Mixin.create Tent.TranslationSupport, Tent.ValidationSupport, Tent.VisibilitySupport, Tent.MandatorySupport, 
  fieldClass: 'field'
  mixinClasses: 'control-group'
  classNameBindings: [
    'mixinClasses',
    'isMandatoryAsBoolean:mandatory',
    'isHidden:hidden',
    'isViewOnly:view-only',
    'hasErrors:error']
  
  isEditable: true
  isEditableAsBoolean: Tent.computed.boolCoerceGently 'isEditable'
  isViewOnly: Ember.computed.not 'isEditableAsBoolean'

  translatedLabel: Tent.computed.translate 'label'

  hasPrefix: false  

  parentSpan: ->
    parentView = @get('parentView')
    while (parentView)
      span = Number(parentView.get('span'))
      unless (span == 0) || isNaN(span)
        return span
      parentView = parentView.get('parentView')
    12

  inputSizeClass: (->
    return Tent.FieldSupport.SIZE_CLASSES[@parentSpan() - 1]
  ).property()

  unEditableClass: (-> 'uneditable-input' unless @get('isEditable')).property('isEditable')

Tent.FieldSupport.SIZE_CLASSES = [
  'input-mini',
  'input-small',
  'input-mini',
  'input-medium',
  'input-large',
  'input-xlarge',
  'input-xlarge',
  'input-xlarge',
  'input-xxlarge',
  'input-xxlarge',
  'input-xxlarge',
  'input-xxlarge',
]

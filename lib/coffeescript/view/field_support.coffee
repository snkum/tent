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
    'mixinClasses'
    'isMandatoryAsBoolean:mandatory'
    'isHidden:hidden'
    'isViewOnly:view-only'
    'hasErrors:error']
  
  isEditable: true
  isEditableAsBoolean: Tent.computed.boolCoerceGently 'isEditable'
  isViewOnly: Ember.computed.not 'isEditableAsBoolean'

  translatedLabel: Tent.computed.translate 'label'

  hasPrefix: false  

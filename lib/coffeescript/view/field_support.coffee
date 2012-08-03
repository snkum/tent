#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../util/translation_support'
require './visibility_support'
require './validation_support'
require './mandatory_support'
require './span_support'

Tent.FieldSupport = Ember.Mixin.create Tent.SpanSupport, Tent.TranslationSupport, Tent.ValidationSupport, Tent.VisibilitySupport, Tent.MandatorySupport, 
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

  inputSizeClass: (->
    return Tent.FieldSupport.SIZE_CLASSES[@estimateSpan() - 1]
  ).property()

  widthExpectation: (->
    formStyle = @get('form.formStyle')
    fieldSize = Tent.FieldSupport.SIZE_MAP[@get('inputSizeClass')]
    if formStyle == 'horizontal' then fieldSize + 150 else Math.max(fieldSize, 150) 
  ).property('form')
  		
  form: (->
    Ember.View.views[@$().closest('form').attr('id')]
  ).property()
  
  resize: ->
  	#@_super()
  	@estimateFormStyle()
  	
  didInsertElement: ->
    @_super()
    @estimateFormStyle()
  	
  estimateFormStyle: ->
  	form.set('formStyle', if @get('widthExpectation') > form.$().width() then 'vertical' else 'horizontal') if (form = @get('form'))

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

Tent.FieldSupport.SIZE_MAP =
  'input-mini': 60
  'input-small': 90
  'input-medium': 150
  'input-large': 210
  'input-xlarge': 270
  'input-xxlarge': 530
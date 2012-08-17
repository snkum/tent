#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../mixin/field_support'
require '../template/text_field'

Tent.NumericTextField = Tent.TextField.extend Tent.FieldSupport,
  validate: ->
    isValid = @_super()
    value = @get('value')
    isValidNumber = isValid && (value != '') && !(isNaN(value) || isNaN(parseFloat(value))) 
    @addValidationError(Tent.messages.NUMERIC_ERROR) unless isValidNumber
    isValidNumber
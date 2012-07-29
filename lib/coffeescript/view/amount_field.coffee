#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require './field_support'
require '../template/text_field'

Tent.AmountField = Tent.NumericTextField.extend
  hasPrefix: true
  prefix: (->
    @get('currency')
  ).property('currency')
  
  inputSizeClass: (->
    return Tent.AmountField.SIZE_CLASSES[@estimateSpan() - 1]
  ).property()

Tent.AmountField.SIZE_CLASSES = [
  'input-mini',
  'input-mini',
  'input-mini',
  'input-small',
  'input-medium',
  'input-large',
  'input-xlarge',
  'input-xlarge',
  'input-xlarge',
  'input-xxlarge',
  'input-xxlarge',
  'input-xxlarge',
]

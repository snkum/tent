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

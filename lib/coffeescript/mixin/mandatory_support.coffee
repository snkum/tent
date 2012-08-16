#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../util/computed'

Tent.MandatorySupport = Ember.Mixin.create
  isMandatory: false
  isMandatoryAsBoolean: Tent.computed.boolCoerceGently 'isMandatory'

  validate: ->
    @_super()
    value = this.get('value')  
    isValid = value? && value != '' 
    @addValidationError(Tent.messages.MANDATORY_ERROR) unless isValid
    isValid


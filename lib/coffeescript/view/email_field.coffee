#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require './field_support'
require '../template/text_field'

Tent.EmailTextField = Tent.TextField.extend Tent.FieldSupport,
  validate: ->
    isValid = @_super()
    value = @get('value')
    pattern = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i;
    isValidEmail = isValid && pattern.test(value)
    @addValidationError(Tent.messages.EMAIL_FORMAT_ERROR) unless isValidEmail
    isValidEmail
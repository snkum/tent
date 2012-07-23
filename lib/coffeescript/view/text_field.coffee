#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require './field_support'
require '../template/text_field'

Tent.TextField = Ember.View.extend Tent.FieldSupport,
  templateName: 'text_field'
  classNames: ['tent-text-field']


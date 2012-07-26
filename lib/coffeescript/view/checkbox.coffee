#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require './field_support'
require '../template/checkbox'

Tent.Checkbox = Ember.View.extend Tent.FieldSupport,
  templateName: 'checkbox'
  classNames: ['tent-checkbox', 'control-group']
  
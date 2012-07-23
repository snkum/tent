#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require './field_support'
require '../template/text_field'

SCi.TextField = Ember.View.extend SCi.FieldSupport,
  templateName: 'text_field'
  classNames: ['sci-text-field']


#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

SCi.computed = {} unless SCi.computed?

SCi.computed.boolCoerceGently = (dependentKey)->
  Ember.computed dependentKey, ((key)->
    value =  @get(dependentKey) || ''
    result = (value.toLowerCase() == 'true') if typeof(value) == 'string'
    result = value if typeof(value) == 'boolean'
    result
  )

SCi.computed.translate = (dependentKey) ->
  Ember.computed dependentKey, ((key)->
    value =  @get(dependentKey) || ''
    SCi.translate value 
  )

#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.computed = {} unless Tent.computed?

Tent.computed.boolCoerceGently = (dependentKey)->
  Ember.computed dependentKey, ((key)->
    value =  @get(dependentKey)
    return value if typeof(value) == "boolean"
    return value.toBoolean() if typeof(value) == 'string'
    return value != 0 if typeof(value) == 'number'
  )

Tent.computed.translate = (dependentKey) ->
  Ember.computed dependentKey, ((key)->
    value =  @get(dependentKey) || ''
    Tent.translate value 
  )

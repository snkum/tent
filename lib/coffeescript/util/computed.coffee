#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.computed = {} unless Tent.computed?

Tent.computed.boolCoerceGently = (dependentKey)->
  Ember.computed dependentKey, ((key)->
    value =  @get(dependentKey) || ''
    result = (value.toLowerCase() == 'true') if typeof(value) == 'string'
    result = value if typeof(value) == 'boolean'
    result
  )

Tent.computed.translate = (dependentKey) ->
  Ember.computed dependentKey, ((key)->
    value =  @get(dependentKey) || ''
    Tent.translate value 
  )

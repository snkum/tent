#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.ValidationSupport = Ember.Mixin.create  

  validate: -> 
    @flushValidationErrors()
    true

  hasErrors: (->
    (!@validate() if @validate?) || false
  ).property('value') 

  observesErrors: (->
    classNames = @get('classNames')
    if @get('hasErrors')
      classNames[classNames.length] = 'error' unless classNames.contains('error')
    else
      classNames.removeObject 'error'
  ).observes('hasErrors')

  flushValidationErrors: ->
    @set('validationErrors', [])
    
  addValidationError: (error) ->
    @set('validationErrors', error)


#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/select'

Tent.Select = Ember.View.extend
  templateName: 'select'
  classNames: ['tent-select', 'control-group']

  init: ->
    @_super()
    @set('_list', Tent.SelectableArrayProxy.create({content: @get('list')}) || [])

  selectionDidChange: (->
    @set('selection', @get('list.selected'))
  ).observes('list.selected')    

  _prompt: (-> 
    if !@get('multiple')
      if prompt = @get('prompt') then prompt else "Please Select..." 
  ).property('prompt')
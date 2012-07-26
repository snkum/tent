#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/checkbox_group'

Tent.CheckboxGroup = Ember.View.extend
  templateName: 'checkbox_group'
  classNames: ['tent-checkbox-group', 'control-group']

  init: ->
    @_super()
    @set('_list', Tent.SelectableArrayProxy.create({content: @get('list')}) || [])

  checkedDidChange: (->
    console.log @get('list.selected')
    @set('checked', @get('list.selected'))
  ).observes('list.selected')    


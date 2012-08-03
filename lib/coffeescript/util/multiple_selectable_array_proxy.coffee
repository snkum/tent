#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.MultipleSelectableArrayProxy = Ember.ArrayProxy.extend
  _selectedElement: null
  _selectedIndex: -1
  _selectedElementsArray: []
  _selectedIndexArray: []

  selected: ((key, value) ->
    if (value != undefined)
      if (value == null)
        @set '_selectedElement', null
        @set '_selectedIndex', -1
      else
        selectedIndex = @indexOf value
        if (selectedIndex >= 0)
          @set '_selectedElement', value
          @set '_selectedIndex', selectedIndex
          if @_selectedElementsArray.contains(@_selectedElement)
            @_selectedElementsArray.removeObject(@_selectedElement)
            @_selectedIndexArray.splice(@_selectedIndexArray.indexOf(@_selectedIndex),1)
          else
            @_selectedElementsArray.pushObject(@_selectedElement)
            @_selectedIndexArray.push(@_selectedIndex)
             
    @get '_selectedElement'
  ).property().volatile()

  
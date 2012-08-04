#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
 
Tent.SelectionSupport = Ember.ArrayProxy.extend
  _selectedElement: null
  _selectedIndex: -1
  _currentElement: null
  _currentIndex: -1
  _selectedElementsArray: []
  _selectedIndexArray: []
  
  selected: ((key, value) ->
    if (value != `undefined`)
      if @isMulitpleSelectionAllowed
        x = @multi(value)
      else 
        x = @single(value)
    x
  ).property().volatile()

  single: ((value)->
    if (value != `undefined`)
      if (value != null)
        if value != @_selectedElement
          selectedIndex = @indexOf value
          if (selectedIndex >= 0)
            @set '_selectedElement', value
            @set '_selectedIndex', selectedIndex
        else 
          @set '_selectedElement', null
          @set '_selectedIndex', -1
    @get '_selectedElement' 
  )
  
  multi: ((value)->
    if(value!=`undefined`)
      if @_selectedElementsArray.contains(value)
        @_selectedElementsArray.removeObject(value)
        @_selectedIndexArray.splice(@_selectedIndexArray.indexOf(@_currentIndex),1)
        @set '_selectedElement', null
        @set '_selectedIndex', -1
      else
        @_selectedElementsArray.addObject(value)
        @_selectedIndexArray.push(value)
    @get '_selectedElement'        
  ) 

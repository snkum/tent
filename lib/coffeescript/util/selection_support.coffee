#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
 
Tent.SelectionSupport = Ember.ArrayProxy.extend
  _selectedElement: null
  _selectedIndex: -1
  _selectedElementsArray: []
  _selectedIndexArray: []
  _selection: null

  
  selected: ((key, value) ->
    if (value != `undefined`)
      if @isMulitpleSelectionAllowed
        @set('_selection', @multi(value).slice())
      else 
        @set('_selection', @single(value))
    @get('_selection')
  ).property().volatile()

  single: ((value)->
    if (value != `undefined`)
      if (value != null)
        if value != @_selectedElement
          selectedIndex = @indexOf value
          if (selectedIndex >= 0)
            @set '_selectedElement', value
            @set '_selectedIndex', @indexOf(value)
        else 
          @set '_selectedElement', null
          @set '_selectedIndex', -1
    @get '_selectedElement' 
  )
  
  multi: ((value)->
    if(value!=`undefined`)
      if @_selectedElementsArray.contains(value)
        @_selectedElementsArray.removeObject(value)
        @_selectedIndexArray.splice(@_selectedIndexArray.indexOf(value),1)
      else
        @_selectedElementsArray.addObject(value)
        @_selectedIndexArray.push(@indexOf(value))
    @get '_selectedElementsArray'        
  ) 

  contentDidChange: (->
    content = @get 'content'
    #@_super()
    if @isMulitpleSelectionAllowed
    #add the code for multiple selection support
    else
      currentIndex = @get '_selectedIndex'
      if (currentIndex >= 0)
        # There is a selectedElement. Lets make sure it was not affected by the change
        newIndex = @indexOf @get('_selectedElement');
        if (currentIndex != newIndex)
          # selectedElement was impacted by the change
          if (newIndex == -1)
            # selectedElement was removed. Make the element at the current location the selectedElement
            if (currentIndex >= content.length)
              currentIndex = content.length - 1
            @set '_selectedElement', if (currentIndex == -1) then null else @objectAt(currentIndex)
          else
            @set '_selectedIndex', newIndex
  ).observes('content.@each')

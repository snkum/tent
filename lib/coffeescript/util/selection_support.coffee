#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
 
Tent.SelectionSupport = Ember.ArrayProxy.extend
  
  init: ->
    @_super()
    @set '_selectedElementsArray', []
    @set '_selectedIndexArray', []
    @set '_selectedElement', null
    @set '_selectedIndex', -1
    @set '_selection', null

  
  selected: ((key, value) ->
    if value != `undefined`
      if @get('isMultipleSelectionAllowed')
        @set('_selection', @_multiSelection(value).slice())
      else
        @set('_selection', @_singleSelection(value))
    @get('_selection')
  ).property().volatile()

  _singleSelection: ((value)->
    if (value != `undefined`)
      if (value != null)
        if value != @get('_selectedElement')
          if (@indexOf value >= 0)
            @set '_selectedElement', value
            @set '_selectedIndex', @indexOf(value)
        else
          @set '_selectedElement', null
          @set '_selectedIndex', -1
      else
        @set '_selectedElement', null
        @set '_selectedIndex', -1
    @get '_selectedElement'
  )
  
  _multiSelection: (value) ->
    if(value != `undefined`)
      if (value != null)
        selectedElements = @get('_selectedElementsArray')
        selectedIndices = @get('_selectedIndexArray')
        if selectedElements.contains(value)
          selectedElements.removeObject(value)
          selectedIndices.splice(selectedIndices.indexOf(@indexOf(value)),1)
        else
          selectedElements.addObject(value)
          selectedIndices.push(@indexOf(value))
      else 
        @set '_selectedElementsArray', []
        @set '_selectedIndexArray', []        
    @get '_selectedElementsArray'

  contentDidChange: (->
    content = @get 'content'
    #@_super()
    if @get('isMultipleSelectionAllowed')
      currentIndexArray = @get '_selectedIndexArray'
      currentElementsArray = @get '_selectedElementsArray'
      newIndexArray = []
      if currentElementsArray.length != 0
        #create a new index array which has the list of the existing selected element indeces 
        for element in currentElementsArray
          if content.contains(element)
            newIndexArray.push(content.indexOf element)
        #These will be unequal if any selected elements were affected
        if currentIndexArray.toString() != newIndexArray.toString()
          @set('_selectedElementsArray', [])
          @set('_selectedIndexArray', [])
          if newIndexArray.length != 0
            for element in newIndexArray
              @set('selected', content.objectAt(element))
          else 
            @set('selected', null)
    else
      currentIndex = @get '_selectedIndex'
      currentElement = @get '_selectedElement' 
      if currentElement != null
        #If selected element was not deleted
        if content.contains(currentElement)
          newIndex = @indexOf currentElement
          #check if selected element was affected
          if newIndex != currentIndex
            @set '_selectedIndex', content.indexOf currentElement
        else 
          @set 'selected', null
  ).observes('content.@each')

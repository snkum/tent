#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
 
Tent.SelectionSupport = Ember.ArrayProxy.extend
  _selectedElement: null
  _selectedIndex: -1
  _selection: null

  init: ->
    @_super()
    @set '_selectedElementsArray', []
    @set '_selectedIndexArray', []
  
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
    @get '_selectedElementsArray'

  contentDidChange: (->
    content = @get 'content'
    #@_super()
    if @get('isMultipleSelectionAllowed')
      currentIndexArray = @get '_selectedIndexArray'
      currentElementsArray = @get '_selectedElementsArray'
      #only if something is selected
      if currentElementsArray.length != 0
        #create a new index array which has all updated indexes in case of any change and remove the index of deleted item if any
        for element of currentElementsArray
          if content.contains(element)
            newIndexArray.push(@indexOf element)
        #if these are equal no change is required but if unequal changes are required
        if currentIndexArray.toString() != newIndexArray.toString()
          @set('_selectedIndexArray', newIndexArray.slice())
          @set('_selectedElementsArray', [])
          for element of newIndexArray
            @get('_selectedElementsArray').addObject(content.objectAt(element))
          @set('selected', @get('_selectedElementsArray').slice())
          
    else
      currentIndex = @get '_selectedIndex'
      currentElement = @get '_selectedElement'
      #handling required only if anything is selected 
      if currentElement != null
        #check if selected element is deleted or something else
        #in case selected element is not tampered
        if content.contains(currentElement)
          #newIndex is the index of array element after any change has occured in case the selected element is not deleted
          newIndex = @indexOf @get('_selectedElement')
          #if position of selected element in the array is changed then do the following
          if newIndex != currentIndex
            @set '_selectedIndex', newIndex
        else #case where selected element is deleted
          @set '_selectedElement', null
          @set '_selectedIndex', -1
          @set 'selected', null
  ).observes('content.@each')

#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.SelectableArrayProxy = Ember.ArrayProxy.extend
  _selectedElement: null
  _selectedIndex: -1

  selected: ((key, value) ->
    if (value != undefined)
      if (value == null)
        @set '_selectedElement', null
        @set '_selectedIndex', -1
      else
        selectedIndex = @indexOf value
        if (selectedIndex >= 0)
          if @get('_selectedElement') == value
            @set '_selectedElement', null
            @set '_selectedIndex', -1
          else
            @set '_selectedElement', value
            @set '_selectedIndex', selectedIndex
    @get '_selectedElement'
  ).property().volatile()

  contentDidChange: (->
    content = @get 'content'
    #@_super()
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

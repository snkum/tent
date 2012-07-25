#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require './selectable_array_proxy'

Tent.NavigableList = Tent.SelectableArrayProxy.extend

  contentDidChange: ->
    @_super()
    selection = @get('selected')
    content = @get('content')
    if (content && Em.none(selection))
      @set 'selected',content.objectAt(0)

  init: ->
    @_super()
    @contentDidChange()

  # TODO: Evaluate performance herewith
  hasNext: (->
    content = @get('content')
    contentLength = @get('length') - 1
    selection = @get('selected')
    position = @indexOf(selection)
    position < contentLength;
  ).property('selected').cacheable()

  hasPrevious: (->
    selection = @get('selected')
    position = @indexOf(selection)
    position > 0
  ).property('selected').cacheable()

  selectionPosition: ->
    selection = @get('selected')
    @indexOf selection

  next: ->
    canAdvance = @get('hasNext')
    if (canAdvance)
      position = @selectionPosition()
      nextObject = @objectAtContent(position + 1)
      @set 'selected', nextObject

  previous: ->
    canAdvance = @get('hasPrevious')
    if (canAdvance)
      position = @selectionPosition()
      previousObject = @objectAtContent(position - 1)
      @set 'selected', previousObject

  selectItemByProperty: ->
    result = @filterProperty(propName,value)
    result = if result.length then result[0] else null
    if (result)
      @set 'selected',result
    result


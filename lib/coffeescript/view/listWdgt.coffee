#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#


require '../template/selectable_list'
require '../template/list_row'
require '../template/list_cell'

Tent.List = Ember.View.extend
  tagName: 'list'
  templateName: 'selectable_list'
  visibleList: (->
    @get('listhead').split(',')
  ).property('listhead')
  
  init: ->
    @_super()
    @set('_list', @get('list'))
    @set('_list.selected',null)
    @set('entrySelected',null)
    @set('entryClicked',1)
    
Tent.ListCurrent = Ember.View.extend
  tagName: 'ul'
  classNames: ['nav', 'nav-pills', 'nav-stacked']
  templateName: 'list_row'
  init: ->
    @_super()
    @set('selection',null)
    
  allLists: (-> @get('parentView.parentView')).property()
  select: (tmp) ->
    @set('allLists._list.selected', @get('content'))
    @set('allLists.entryClicked', @get('allLists.entryClicked')+1)
    @set('allLists.entrySelected',tmp)
  
  selectionDidChange: (->
    @set('selection', @get('allLists._list.selected'))
  ).observes('allLists._list.selected')
  
  isEntrySelected: (entry) ->
    if @get('selection') isnt null
      #for the time when page first renders or when nothing is selected
      entry is @get('allLists.entrySelected')
    else
      false
      
Tent.ListCell = Ember.View.extend
  tagName: 'li'
  templateName: 'list_cell'
  classNameBindings: ['isHeading','isSelected']
  
  init: ->
    @_super()
    @set('val', @get('content'))
    @set('selected',null)
  
  isHeading: (->
    if @get('content') is 'Name'
      'tent-heading'
    else
      'tent-list'
  ).property('val')
  
  parentList: (-> @get('parentView.parentView')).property()
  isSelected: (->
    'active' if @get('parentList').isEntrySelected(@selected)
  ).property('parentList.allLists.entrySelected')
  
  mouseUp: ->
    str = @get('parentList.content')[@get('content')]
    @set('selected',str)
    if @get('parentList.allLists.entryClicked')%2 is 0
      @set('parentList.allLists.entryClicked', 0)
    else
      @set('parentList.allLists.entryClicked', 1) 
    if @get('content') isnt 'Name'
      @get('parentList').select(str)
      
  value: (->
    cell = @get('parentList.content')
    if cell then cell[@get('val')] else ''
  ).property('content', 'parentView')
  
  icon: (->
    cell = @get('parentList.content')
    if cell then cell['icon'+@get('val')] else ''
  ).property('content','parentView')  
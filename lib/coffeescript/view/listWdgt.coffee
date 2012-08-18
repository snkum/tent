#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#


require '../template/selectable_list'
require '../template/list_row'

Tent.List = Ember.View.extend
  tagName: 'list'
  templateName:'selectable_list'
  visibleList: (->
    @get('listhead').split(',')
  ).property('listhead')
  
  init: ->
    @_super()
    @set('_list', @get('list'))
    @set('_list.selected',null)
    @set('entrySelected',null)

    
  
        
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
  defaultTemplate: Ember.Handlebars.compile('<a>{{view.value}}</a>')
  classNameBindings: ['isHeading','isSelected']
  
  init: ->
    @_super()
    @set('val', @get('content'))
    @set('selected',null)
  
  isHeading: (->
    'tent-heading'  if @get('content') is 'Name'
  ).property('val')
  
  parentList: (-> @get('parentView.parentView')).property()
  isSelected: (->
    'active' if @get('parentList').isEntrySelected(@selected)
  ).property('parentList.allLists.entrySelected')
  
  mouseUp: ->
    str = @get('parentList.content')[@get('content')]
    @set('selected',str)    
    if @get('content') isnt 'Name'
      @get('parentList').select(str) 
      
  value: (->
    cell = @get('parentView.parentView.content')
    if cell then cell[@get('val')] else ''
  ).property('content', 'parentView')
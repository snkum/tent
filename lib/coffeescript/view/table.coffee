#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/table'
require '../template/table_row'

Tent.Table = Ember.View.extend
  classNames: ['table', 'table-bordered', 'table-condensed']
  tagName: 'table'
  templateName: 'table'
  _columns: (->
    @get('columns').split(',')
    ).property('columns')
  visibleColumns: (-> @get('_columns')).property('_columns')

  init: ->
    @_super()
    @set('_list', Tent.SelectionSupport.create({content: @get('list')}))
    @set(('_list.isMulitpleSelectionAllowed'), @get('multiselection'))

  isRowSelected: (row) ->
    if @get('multiselection')
      @get('_list._selectedElementsArray').contains(row.get('content'))
    else 
      row.get('content') == @get('_list._selectedElement')


  select: (selection) ->
    @set('_list.selected', selection)
    
  selectionDidChange: (->
    @set('selection', @get('_list._selectedElement'))
  ).observes('_list.selected', '_list._selectedElementsArray.length')

Tent.TableRow = Ember.View.extend
  tagName: 'tr'
  templateName: 'table_row'
  classNameBindings: [
    'isSelected:tent-selected']
  multiselBinding: 'parentTable.multiselection'

  parentTable: (-> @get('parentView.parentView')).property()
  isSelected: (-> @get('parentTable').isRowSelected(this))
    .property('parentTable.selection', 'parentTable._list._selectedElementsArray.length')
  
  mouseUp: ->
    @get('parentTable').select(@get('content'))
    if !(@$('input').prop('checked'))
      @$('input').prop('checked',true) 
    else 
      @$('input').prop('checked',false)
    
Tent.TableCell = Ember.View.extend
  tagName: 'td'
  classNameBindings: ['isRadio:tent-width-small']
  defaultTemplate: Ember.Handlebars.compile('{{view.value}}')
  value: (->
    row = @get('parentView.parentView.content')
    if row then row[@get('content')] else ''
  ).property('content', 'parentView')

Tent.TableHeader = Ember.View.extend
  tagName: 'th'
  defaultTemplate: Ember.Handlebars.compile('{{view.printableColumnName}}')
  printableColumnName: (->
    columnName = @get('content')
    columnName.camelToWords() if typeof(columnName) == 'string'
  ).property('content')

#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/table'
require '../template/row'

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
    @set('_list', Tent.MultipleSelectableArrayProxy.create({content: @get('list')}))

  isRowSelected: (row) ->
    @get('_list').get('_selectedElementsArray').contains(row.get('content'))

  select: (selection) ->
    @set('_list.selected', selection)
    
  selectionDidChange: (->
    @set('selection', @get('_list.selected'))
  ).observes('_list.selected')

Tent.TableRow = Ember.View.extend
  tagName: 'tr'
  templateName: 'row'
  classNameBindings: [
    'isSelected:tent-selected']

  parentTable: (-> @get('parentView.parentView')).property()
  isSelected: (-> @get('parentTable').isRowSelected(this))
    .property('parentTable.selection')
  
  mouseUp: ->
    @get('parentTable').select(@get('content'))
    @$('input').prop('checked',true) if !(@$('input').prop('checked'))
    
    
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

#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/table'

Tent.Table = Ember.View.extend
  classNames: ['table', 'table-striped', 'table-bordered', 'table-condensed']
  tagName: 'table'
  templateName: 'table'
  _columns: (-> @get('columns').split(',')).property('columns')
  visibleColumns: (-> @get('_columns')).property('_columns')

  init: ->
    @_super()
    @set('_list', Tent.SelectableArrayProxy.create({content: @get('list')}))

  select: (selection) ->
    @set('_list.selected', selection)

  selectionDidChange: (->
    @set('selection', @get('_list.selected'))
  ).observes('_list.selected')

Tent.TableRow = Ember.View.extend
  tagName: 'tr'
  defaultTemplate: Ember.Handlebars.compile('{{collection contentBinding="view.parentTable.visibleColumns" itemViewClass="Tent.TableCell"}}')
  parentTable: (-> @get('parentView.parentView')).property()
  mouseUp: ->
    @get('parentTable').select(@get('content'))

Tent.TableCell = Ember.View.extend
  tagName: 'td'
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

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

Tent.TableRow = Ember.View.extend
  tagName: 'tr'
  defaultTemplate: Ember.Handlebars.compile('{{collection contentBinding="view.parentView.parentView.visibleColumns" itemViewClass="Tent.TableCell"}}')

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

#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/table'

Tent.Table = Ember.View.extend
  classNames: ['table', 'table-bordered', 'table-condensed']
  tagName: 'table'
  templateName: 'table'
  _columns: (-> 
    x = @get('columns').split(',')
    x.unshift ''
    x
    ).property('columns')
  visibleColumns: (-> @get('_columns')).property('_columns')

  init: ->
    @_super()
    @set('_list', Tent.SelectableArrayProxy.create({content: @get('list')}))

  isRowSelected: (row) ->
    row.get('content') == @get('_list.selected')

  select: (selection) ->
    @set('_list.selected', selection)

  selectionDidChange: (->
    @set('selection', @get('_list.selected'))
  ).observes('_list.selected')

Tent.TableRow = Ember.View.extend
  tagName: 'tr'
  defaultTemplate: Ember.Handlebars.compile('{{collection contentBinding="view.parentTable.visibleColumns" itemViewClass="Tent.TableCell"}}')
  classNameBindings: [
    'isSelected:tent-selected']

  parentTable: (-> @get('parentView.parentView')).property()
  isSelected: (-> @get('parentTable').isRowSelected(this)).property('parentTable.selection')
  
  mouseUp: ->
    @get('parentTable').select(@get('content'))
    @$('input').prop('checked',true) 
    
    
Tent.TableCell = Ember.View.extend
  tagName: 'td'
  classNameBindings: ['isRadio:tent-width-small']
  defaultTemplate: Ember.Handlebars.compile('{{view.value}}')
  value: (->
    if @content == ''
      # @set('isRadio',true)
      row = new Handlebars.SafeString('\<input type=\'radio\' name=\'selection\'\>')   
    else
      row = @get('parentView.parentView.content')
      if row then row[@get('content')] else ''
  ).property('content', 'parentView')

Tent.TableHeader = Ember.View.extend
  tagName: 'th'
  defaultTemplate: Ember.Handlebars.compile('{{view.printableColumnName}}')
  printableColumnName: (->
    columnName = @get('content')
    columnName.camelToWords() if typeof(columnName) == 'string' && columnName isnt ''
  ).property('content')

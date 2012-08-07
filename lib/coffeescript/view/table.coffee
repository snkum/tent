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
    @set(('_list.isMultipleSelectionAllowed'), @get('multiselection'))
    if @get('defaultSelection')
      if @get('multiselection')
        for element in @get('defaultSelection')
          @select element
      else
        @select @get('defaultSelection')

  isRowSelected: (row) ->
    if @get('multiselection')
      if @get('_list.selected') isnt null
        #for the time when page first renders or when nothing is selected
        @get('_list.selected').contains(row.get('content'))
      else
        false
    else
      row.get('content') == @get('_list.selected')

  select: (selection) ->
    @set('_list.selected', selection)
    
  selectionDidChange: (->
    @set('selection', @get('_list.selected'))
  ).observes('_list.selected')

Tent.TableRow = Ember.View.extend
  tagName: 'tr'
  templateName: 'table_row'
  classNameBindings: ['isSelected:tent-selected']
  multiselBinding: 'parentTable.multiselection'
  
  didInsertElement: ->
    # checks the radioButtons/checkboxes in case of defaultselection
    @checkSelection()

  parentTable: (-> @get('parentView.parentView')).property()
  isSelected: (-> @get('parentTable').isRowSelected(this))
    .property('parentTable.selection')
  
  checkSelection: (-> 
    if @get 'isSelected'
      @$('input').prop('checked',true)
    else
      @$('input').prop('checked',false)
  ).observes('isSelected')
  
  mouseUp: ->
    @get('parentTable').select(@get('content'))
    
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

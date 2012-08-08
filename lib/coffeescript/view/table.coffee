#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
# Always pass an array to the list binding and default selection even 
# if there is only one item in the array for table view 
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
    @set('multiselection', false) if @get('multiselection') == undefined
    @set('isEditable', true) if @get('isEditable') == undefined
    @set('_list', Tent.SelectableArrayProxy.create({content: @get('list')}))
    @set(('_list.isMultipleSelectionAllowed'), @get('multiselection'))
    if @get('defaultSelection')
      for element in @get('defaultSelection')
        @select element
      
  isRowSelected: (row) ->
      if @get('_list.selected') isnt null
        #for the time when page first renders or when nothing is selected
        @get('_list.selected').contains(row.get('content'))
      else
        false

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
    if @get('parentTable').get('isEditable')
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
  
  mouseUp: (event)->
    @get('parentTable').select(@get('content')) if @get('parentTable').get('isEditable')
    # to remove default click events of checkbox and radiobuttons
    @$("input").click (event) ->
      $(@).prop('checked',false) if $(@).prop('checked') 
      false if event.target is @
    
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

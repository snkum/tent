require "./table"
require "../template/slick"
require "vendor/scripts/jquery-ui-1.8.16.custom.min"
require "vendor/scripts/jquery.event.drag-2.0.min"
require "vendor/scripts/slick.rowselectionmodel"
require "vendor/scripts/slick.checkboxselectcolumn"
require "vendor/scripts/slick.core"
require "vendor/scripts/slick.grid"


Tent.SlickGrid = Ember.View.extend(
	templateName: 'slick'
	tagName: 'div'
	rowSelection: null
	grid: null
	multiSelect: false
	listBinding: 'controller.list'

	options = 
		enableCellNavigation: true
		enableColumnReorder: true
		multiColumnSort: false
	
	_listContentDidChange: (->
		if @grid?
			console.log 'render list  with ' + @list.length + ' items'
			@grid.setData(@get("list"))
			@grid.render()
	).observes 'list'

	_rowSelectionDidChange: (->
		# Allow the controller field to observe any selection changes
		@set('controller.rowSelection', @get('rowSelection'))
	).observes 'rowSelection'
	 
	didInsertElement: ->
		@renderGrid()

	renderGrid: ->
		if @multiSelect
			@renderMultiSelectGrid()
		else
			@renderSingleSelectGrid()

		@grid.onSort.subscribe((e, args) =>
			@sortCallback e,args
		)
		@grid.render()

	renderMultiSelectGrid: ->
		checkboxSelector = new Slick.CheckboxSelectColumn({
			cssClass: "slick-cell-checkboxsel"
		});
		@columns.splice(0,0,checkboxSelector.getColumnDefinition())
		@grid = new Slick.Grid(@$().find(".grid"), @get('list'), @columns, @options)
		@grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}))
		@grid.registerPlugin(checkboxSelector)
		@grid.onSelectedRowsChanged.subscribe((e, args) =>
			@multiRowSelectionCallback e,args
		)

	renderSingleSelectGrid: ->
		@grid = new Slick.Grid(@$().find(".grid"), @get('list'), @columns, @options)
		rowSelectionModel = new Slick.RowSelectionModel()
		@grid.setSelectionModel(rowSelectionModel)
		rowSelectionModel.onSelectedRangesChanged.subscribe((e, args) =>
			@rowSelectionCallback e,args	
		)

	willDestroyElement: ->
		@grid.onClick.unsubscribe(->)

	rowSelectionCallback: (e, range) ->
		@.set('rowSelection', @getSelectedRow(range))
		e.stopPropagation

	multiRowSelectionCallback: (e, range) ->
		@.set('rowSelection', @getSelectedRows(range))
		e.stopPropagation

	getSelectedRow: (range) ->
		row = @grid.getDataItem range[0].fromRow

	getSelectedRows: (range) ->
		rows = []
		for item in range.rows
			rows.push(@grid.getDataItem item)
		return rows

	sortCallback: (e, args) ->
		console.log 'sort'
		if args.multiColumnSort
			@get('controller').sortMultiColumn(args.sortCols)
		else
			@get('controller').sortSingleColumn(args.sortCol, args.sortAsc)
		
)

Pad.TaskList = Tent.SlickGrid.extend(
	columnsBinding: 'controller.columns'

	options: 
		enableCellNavigation: true
		enableColumnReorder: true
		multiColumnSort: true

	rowSelectionCallback: (e, args) ->
		@_super(e, args)

	logRowSelection: (->
		console.log "Title = #{@rowSelection.title}"
	).observes('rowSelection')
)
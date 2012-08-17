#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###
GridController
- content: bind to Model
- modelType: 
- store
- rowSelection holds the object represented by the selected row
###

Tent.Controllers.GridController = Ember.ArrayController.extend
	content: null
	modelType: null
	store: null
	rowSelection: null 

	list: (->
		# The store returns a cache of DS.Model objects, so we need to convert
		# to an ordinary array
		return @getArrayFromModelArray(@get('content'))
	).property('content')

	getArrayFromModelArray: (modelArray)-> 
		_list = []
		for item in modelArray.toArray()
			if item?
				# TO REMOVE: this is here to show that the sort is being applied
				json = item.toJSON()
				json.title += Math.round(Math.random() * 100)
				_list.push json
				#_list.push item.toJSON()
		return _list

	sortMultiColumn: (cols) ->
		query = @generateQueryFromCols(cols)
		result = @store.findQuery(@modelType, query)
		@set('content', result)
	
	sortSingleColumn: (col, ascending) ->
		query = @generateQueryFromCol(col, ascending)
		result = @store.findQuery(@modelType, query)
		@set('content', result)

	generateQueryFromCols: (cols) ->
		query = []
		for col in cols
			query.push
				sortDir: if col.sortAsc then 'up' else 'down'
				sortKey: col.sortCol.field
		return query
		
	generateQueryFromCol: (col, ascending) ->
		query =
			sortKey: col.field
			sortDir: if ascending then 'up' else 'down'
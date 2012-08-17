require('coffeescript/models/task_model')

Pad.Controllers.TaskMultiSelectListController = Tent.Controllers.GridController.extend
	modelType: Pad.Models.TaskModel
	content: Pad.store.findAll(Pad.Models.TaskModel)
	store: Pad.store
	columns: [
		    {id: "title", name: "Title", field: "title", sortable: true},
		    {id: "duration", name: "Duration", field: "duration", sortable: true},
		    {id: "%", name: "% Complete", field: "percentComplete"},
		    {id: "start", name: "Start", field: "start"},
		    {id: "finish", name: "Finish", field: "finish"},
		    {id: "effort-driven", name: "Effort Driven", field: "effortDriven"}
		  ]
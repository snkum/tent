
Pad.Models.TaskModel = DS.Model.extend
	id: DS.attr('number')
	title: DS.attr('string')
	duration: DS.attr('string')
	percentComplete: DS.attr('string')
	start: DS.attr('string')
	finish: DS.attr('string')
	effortDriven: DS.attr('string')

Pad.Models.TaskModel.FIXTURES = [{
			id: 1,
			title: "Task 1",
			duration: "5 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 2,
			title: "Task 2",
			duration: "6 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 3,
			title: "Task 3",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 4,
			title: "Task 4",
			duration: "14 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 5,
			title: "Task 5",
			duration: "27 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 6,
			title: "Task 6",
			duration: "2 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 7,
			title: "Task 7",
			duration: "75 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 8,
			title: "Task 8",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 9,
			title: "Task 9",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		}]
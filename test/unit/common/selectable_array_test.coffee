require 'tent'
setup = (->
  @TemplateTests = Ember.Namespace.create()
)

teardown = ( ->
  @TemplateTests = undefined
)

module 'selection tests', setup, teardown

test 'simple selection', ->
  array = Tent.SelectionSupport.create content:['one', 'two', 'three'] 
  array.set 'isMultipleSelectionAllowed', false
  array.set 'selected', 'two'
  equal array.get('selected'), 'two', 'selection works with no prior selection'
  array.set 'selected', 'three'
  equal array.get('selected'), 'three', 'selection works with prior selection'

test 'selection retained with array mutation', ->
  array = Tent.SelectionSupport.create content:["orange", "mango", "banana", "sugar", "tea"]
  array.set 'isMultipleSelectionAllowed', false
  array.set 'selected', 'banana'
  array.pushObject 'coffee'
  equal array.get('selected'), 'banana', 'selection retained when new element appended'
  equal array.get('_selectedIndex'), array.indexOf(array.get('selected')), 'index retained when new element appended' 
  array.insertAt 0,'ORANGE'
  equal array.get('selected'), 'banana', 'selection retained when earlier element modified'
  equal array.get('_selectedIndex'), array.indexOf(array.get('selected')), 'index adjusted when earlier element modified'
  array.removeAt 1, 1
  equal array.get('selected'), 'banana', 'selection retained when earlier element removed'
  equal array.get('_selectedIndex'), array.indexOf(array.get('selected')), 'index adjusted when earlier element modified'

test 'selected sets to null when current selection is removed', ->
  array = Tent.SelectionSupport.create content:["orange", "mango", "banana", "sugar", "tea"]
  array.set 'isMultipleSelectionAllowed', false
  array.set 'selected', 'banana'   # selected index = 2
  array.removeAt 2, 1              # selected index = 2/sugar
  equal array.get('selected'), null, 'selection is set to null when selected element is deleted'
  equal array.get('_selectedIndex'), -1, 'index set to -1 when current selection is deleted'
  
#### tests for multiple selection

test 'simple multiple selection', ->
  array = Tent.SelectionSupport.create 
    content: ['one', 'two', 'three']
    isMultipleSelectionAllowed: true
  array.set 'selected', 'one'
  equal array.get('selected').length, 1, 'selection works with no prior selection'
  array.set 'selected', 'two'
  equal array.get('selected').length, 2, 'selection works with prior selection, elements are added to the array'
      
test 'selection retained with array mutation in a multi-select scenario', ->
  array = Tent.SelectionSupport.create content:["orange", "mango", "banana", "sugar", "tea"]
  array.set 'isMultipleSelectionAllowed', true
  array.set 'selected', 'banana'
  array.pushObject 'coffee'
  equal array.get('selected'), 'banana', 'selection retained when new element appended'
  array.insertAt 0,'ORANGE'
  equal array.get('selected'), 'banana', 'selection retained when earlier element modified'
  equal array.get('_selectedIndexArray').toString(), '3', 'Indeces are adjusted'
  array.removeAt 1, 1
  equal array.get('selected'), 'banana', 'selection retained when earlier element removed'
  equal array.get('_selectedIndexArray').toString(), '2', 'Indeces are adjusted'
  
test 'element deleted from array when selection is removed in a multi-select scenario', ->
  array = Tent.SelectionSupport.create content:["orange", "mango", "banana", "sugar", "tea"]
  array.set 'isMultipleSelectionAllowed', true
  array.set 'selected', 'banana'   # selected index = 2
  array.set 'selected', 'tea'   # selected index = 4
  array.removeAt 2, 1       
  equal array.get('selected'), 'tea', 'Deleted object is removed from the array if it was selected'
  equal array.get('_selectedIndexArray'), '3', 'indeces are adjusted' 
  array.removeAt 3, 1
  equal array.get('selected'), '', 'when all the selected elements are deleted selected is an empty array'

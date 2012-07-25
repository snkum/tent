module 'selection tests'

test 'simple selection', ->
  array = Tent.SelectableArrayProxy.create content:['one', 'two', 'three']
  array.set 'selected', 'two'
  equal array.get('selected'), 'two', 'selection works with no prior selection'
  array.set 'selected', 'three'
  equal array.get('selected'), 'three', 'selection works with prior selection'

test 'selection retained with array mutation', ->
  array = Tent.SelectableArrayProxy.create content:["orange", "mango", "banana", "sugar", "tea"]
  array.set 'selected', 'banana'
  array.pushObject 'coffee'
  equal array.get('selected'), 'banana', 'selection retained when new element appended'
  array.insertAt 0,'ORANGE'
  equal array.get('selected'), 'banana', 'selection retained when earlier element modified'
  array.removeAt 1, 1
  equal array.get('selected'), 'banana', 'selection retained when earlier element removed'

test 'selected relocates when current selection is removed', ->
  array = Tent.SelectableArrayProxy.create content:["orange", "mango", "banana", "sugar", "tea"]
  array.set 'selected', 'banana'   # selected index = 2
  array.removeAt 2, 1              # selected index = 2/sugar
  equal array.get('selected'), 'sugar', 'selection moves to the next element when selected element is removed from array'
  array.removeAt 2, 2              # 'orange','mango'
  equal array.get('selected'), 'mango', 'selection moves to last element if all elements after and including current selection is removed from the array'
  array.clear()
  equal array.get('selected'), null, 'selected element becomes null when all elements from the array are removed'

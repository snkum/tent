testContent = [1,2]
navList = null

module "NavigableList Tests", ->
  navList = Tent.NavigableList.create
    content:testContent

test "initial selection is set to first element", ->
  targetObject = testContent.objectAt(0);
  equal navList.get('selected'), targetObject, "should be equal"

test "hasNext reports forward navigability", ->
  ok navList.get('hasNext'),"should have next available"

test "hasNext won't advance past end", ->
  navList.next()
  ok !navList.get('hasNext'),"should NOT have next available"

test "hasPrevious reports backward navigability", ->
  navList.next()
  ok navList.get('hasPrevious'),"should have previous available"

test "next increments selection", ->
  targetObject = testContent.objectAt 1
  navList.next()
  equal navList.get('selected'), targetObject, "should be equal"

test "previous decrements selection", ->
  targetObject = testContent.objectAt 0
  navList.next()
  navList.previous()
  equal navList.get('selected'), targetObject, "should be equal"

test "next does not increment selection when no more options are available", ->
  targetObject = testContent.objectAt 1
  navList.next()
  navList.next() # s/b no-op - list is 2 elements long
  equal navList.get('selected'), targetObject, "should be equal"


test "previous does not decrement selection when no more elements are available", ->
  targetObject = testContent.objectAt(0)
  navList.previous()
  equal navList.get('selected'), targetObject, "should be equal"

test "previous does not decrement selection when no more elements are available", ->
  myContent = [
    {id:'one', value:1},
    {id:'two', value:2},
    {id:'three', value:3}]
  myList = Tent.NavigableList.create
    content:myContent
  targetObject = myContent.objectAt(2)

  result = myList.selectItemByProperty('id','three')
  equal targetObject, result, "should be the same"
  equal targetObject, myList.get('selected')





view_1 = view_2 =view_3 ={}

setup = (->
  view_1 = SCi.SelectButtonView.create(items: [ "Option-1", "Option-2", "Option-3", "Option-4" ])
  view_2 = SCi.SelectButtonView.create(
    items: [{title: "Option-1",val: "1"},{title: "Option-2",val: "2"},{title: "Option-3",val: "3"}]
    itemTitleKey: "title"
    itemValueKey: "val"
  )
  view_3 = SCi.SelectButtonView.create(
    items: [ Em.Object.create(
      title: "Option-1"
      val: "1"
    ), Em.Object.create(
      title: "Option-2"
      val: "2"
    ), Em.Object.create(
      title: "Option-3"
      val: "3"
    ) ]
    itemTitleKey: "title"
    itemValueKey: "val"
    value: "2"
  )
  view_1.appendTo('#qunit-fixture')
  view_2.appendTo('#qunit-fixture')
  view_3.appendTo('#qunit-fixture')
)
teardown = ->
  view_1.destroyElement()
  view_2.destroyElement()
  view_3.destroyElement()
  

module "SCi.SelectButtonView", setup, teardown

test "Test bindings of view which have items as an array of strings", ->
  #Check parent div, it is inserted in DOM properly
  equal view_1.$().parent().attr('id'), 'qunit-fixture', 'Element is properly inserted to DOM'
  equal view_2.$().parent().attr('id'), 'qunit-fixture', 'Element is properly inserted to DOM'
  equal view_3.$().parent().attr('id'), 'qunit-fixture', 'Element is properly inserted to DOM'
  
  #Assert tag name 
  ok((view_1.tagName =="label") and (view_2.tagName == "label") and (view_3.tagName == "label"))
  class_1 = view_1.get('classNames')
  class_2 = view_2.get('classNames')
  class_3 = view_3.get('classNames') 
  #Assert class name binding 
  ok((class_1[0] == "ember-view") and (class_2[0] == "ember-view") and (class_3[0] == "ember-view"))
  ok((class_1[1] == "sci-select-label") and (class_2[1] == "sci-select-label") and (class_3[1] == "sci-select-label"))
  #Assert default fields
  ok((view_1.get('defaultTitle') =="SELECT") and (view_2.get('defaultTitle') =="SELECT") and (view_3.get('defaultTitle') =="SELECT"))
  ok((view_1.get('defaultValue') =="") and (view_2.get('defaultValue') =="") and (view_3.get('defaultValue') ==""))
  
  #item title key and value
  ok view_1.get("itemTitleKey") == null
  ok view_1.get("itemValueKey") == null
  ok view_2.get("itemTitleKey") == "title"
  ok view_2.get("itemValueKey") == "val"
  ok view_3.get("itemTitleKey") == "title"
  ok view_3.get("itemValueKey") == "val"
  equal view_1.get("items").length, 4, 'items length of view_1 is 4'
  equal view_2.get("items").length, 3, 'items length of view_2 is 3'
  equal view_3.get("items").length, 3, 'items length of view_3 is 3'
  
  #Assert value property
  equal view_3.get("value"), "2", 'Value properly set to view_3'
  
  #Now check the child views
  child_1 = view_1.get("childViews").objectAt(0)
  child_2 = view_2.get("childViews").objectAt(0)
  child_3 = view_3.get("childViews").objectAt(0)
  #Assert tag name 
  ok((child_1.tagName =="select") and (child_2.tagName == "select") and (child_3.tagName == "select"))
  
  option_child_1 = child_1.get("childViews")
  option_child_2 = child_2.get("childViews")
  option_child_3 = child_3.get("childViews")
  
  equal option_child_1.length, 4, 'options length of view_1 is 4'
  equal option_child_2.length, 3, 'options length of view_2 is 3'
  equal option_child_3.length, 3, 'options length of view_3 is 3'

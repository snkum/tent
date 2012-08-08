#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests UI Widgets part of the tent library.
#

setup = (->
  @TemplateTests = Ember.Namespace.create()
)

teardown = ( ->
  if view
    Ember.run -> view.destroy()
    view = null
  @TemplateTests = undefined
)

module "Tent - Basic Widgets - table", setup, teardown

test 'Ensure Table is rendered with radio buttons(single selection)', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" multiselection=false isEditable=true}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  appendView()

  ok view.$('table')?, 'table gets rendered'
  ok view.$('thead')?, 'header gets rendered'
  ok view.$('tbody')?, 'body gets rendered'
  rows = view.$('tr')
  equal rows.length, 4, 'all the rows get rendered(header row and body rows)'
  equal view.$('td:eq(0):has(input[type=radio])').length,
    1, 'radio button gets rendered'
  equal view.$('td:eq(1)').text(), "Matt", 'Name column gets rendered'
  equal view.$('td:eq(2)').text(), "22", 'Age column gets rendered'
  equal Ember.View.views[view.$('table').attr('id')].get('selection'),
    undefined,'none of the rows is selected'
  
test 'Ensure Single Selection and Deselection', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" multiselection=false isEditable=true}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  appendView()

  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  rowView2 = Ember.View.views[view.$('tr:eq(2)').attr('id')]
  rowView1.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection').objectAt(0),
    rowView1.get('content'), 'selection is updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    true, 'css gets added on selection'
  rowView2.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection').objectAt(0),
    rowView2.get('content'), 'selection property of table is updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    false, 'css gets removed when some other row is selected'
  equal $(rowView2.$()[0]).prop('classList').contains('tent-selected'),
    true, 'class added to the new selection'
  rowView2.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection').objectAt(0),
    null, 'none of the rows is selected'
  equal $(rowView2.$()[0]).prop('classList').contains('tent-selected'),
    false, 'css removed from the last selected row'

test 'radio button in synch with row selection and deselection', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" multiselection=false isEditable=true}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  appendView()
  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  rowView2 = Ember.View.views[view.$('tr:eq(2)').attr('id')]
  rowView1.mouseUp()
  equal rowView1.$('input').prop('checked'), true,
    'radio button gets checked automatically on row selection'
  rowView2.mouseUp()
  equal rowView1.$('input').prop('checked'), false,
    'radio button gets unchecked automatically when some other row is selected'
  equal rowView2.$('input').prop('checked'), true,
    'new radio button gets checked'
  rowView2.mouseUp()
  equal rowView2.$('input').prop('checked'), false,
    'radio button gets unchecked automatically on deselection'

test 'Ensures default selection', ->
  people= [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  peoplelist = people.slice(0,1)
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" defaultSelectionBinding="peopleList" multiselection=false isEditable=true}}'
    people: people
    peopleList: peoplelist
  appendView()
  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    true, 'css added on default selection'
  rowView1.didInsertElement()
  equal rowView1.$('input').prop('checked'), true,
    'radio button gets in case of default selection'
  
  
test 'Ensure Table is rendered with checkboxes(multiple selection)', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" multiselection=true isEditable=true}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  appendView()

  ok view.$('table')?, 'table gets rendered'
  ok view.$('thead')?, 'header gets rendered'
  ok view.$('tbody')?, 'body gets rendered'
  rows = view.$('tr')
  equal rows.length, 4, 'all the rows get rendered(header row and body rows)'
  equal view.$('td:eq(0):has(input[type=checkbox])').length,
    1, 'checkbox gets rendered'
  equal view.$('td:eq(1)').text(), "Matt", 'Name column gets rendered'
  equal view.$('td:eq(2)').text(), "22", 'Age column gets rendered'
  equal Ember.View.views[view.$('table').attr('id')].get('selection'),
    undefined, 'none of the rows is selected'

test 'Ensure Multiple Selection And Deselection', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" multiselection=true isEditable=true}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  appendView()

  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  rowView2 = Ember.View.views[view.$('tr:eq(2)').attr('id')]
  rowView1.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection').length,
    1, '1 row is selected'
  equal Ember.View.views[view.$('table').attr('id')].get('selection')
    .objectAt(0), rowView1.get('content'), 'selection object is updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    true, 'css gets added on selection'
  rowView2.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection').length,
    2, '2 rows are selected'
  equal Ember.View.views[view.$('table').attr('id')].get('selection')
   .objectAt(1), rowView2.get('content'), 'selection property updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    true, 'css is not removed from the previously selected row'
  equal $(rowView2.$()[0]).prop('classList').contains('tent-selected'),
    true, 'class added to the new selection'
  rowView2.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection').length,
    1, '1 row is selected after deselection'
  equal Ember.View.views[view.$('table').attr('id')].get('selection')
    .objectAt(0), rowView1.get('content'), 'selection property updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    true, 'css is not removed from the previously selected row'
  equal $(rowView2.$()[0]).prop('classList').contains('tent-selected'),
    false, 'class removed on deselection'
  rowView1.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection').length,
    0, 'none of the rows are selected'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    false, 'css is removed on deselection'

test 'checkbox gets checked on row selection', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" multiselection=true isEditable=true}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  appendView()
  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  rowView2 = Ember.View.views[view.$('tr:eq(2)').attr('id')]
  rowView1.mouseUp()
  equal rowView1.$('input').prop('checked'), true,
    'checkbox gets checked on row selection'
  rowView2.mouseUp()
  equal rowView1.$('input').prop('checked'), true,
    'checkbox of previously selected row is still checked'
  equal rowView2.$('input').prop('checked'),true,
    'new checkbox also gets checked'
  rowView2.mouseUp()
  equal rowView1.$('input').prop('checked'), true,
    'checkbox of previously selected row is still checked'
  equal rowView2.$('input').prop('checked'),
    false, 'checkbox unchecked on deselection'
    
test 'Ensures default (multiple) selection', ->
  people = [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" defaultSelectionBinding="sel" multiselection=true isEditable=true}}'
    people: people
    sel: people.slice(0,2)
  appendView()
  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'),
    true, 'css added on default selection'
  rowView1.didInsertElement()
  equal rowView1.$('input').prop('checked'), true,
    'checkbox checked on default selection'
  rowView2 = Ember.View.views[view.$('tr:eq(2)').attr('id')]
  equal $(rowView2.$()[0]).prop('classList').contains('tent-selected'),
    true, 'css added on default selection'
  rowView2.didInsertElement()
  equal rowView2.$('input').prop('checked'), true,
    'checkbox checked on default selection'
  rowView3 = Ember.View.views[view.$('tr:eq(3)').attr('id')]
  equal $(rowView3.$()[0]).prop('classList').contains('tent-selected'),
    false, 'css doesnt get added on the elements which are not in default list'
  rowView3.didInsertElement()
  equal rowView3.$('input').prop('checked'), false,
    'checkbox unchecked for elements not in default selection'
    
test 'Check default table when no additional parameters are passed', ->
  people = [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson"}}'
    people: people
  appendView()
  ok view.$('table')?, 'table gets rendered'
  ok view.$('thead')?, 'header gets rendered'
  ok view.$('tbody')?, 'body gets rendered'
  rows = view.$('tr')
  equal rows.length, 4, 'all the rows get rendered(header row and body rows)'
  equal view.$('td:eq(0):has(input[type=radio])').length,
    1, 'radio button gets rendered'
  equal view.$('td:eq(1)').text(), "Matt", 'Name column gets rendered'
  equal view.$('td:eq(2)').text(), "22", 'Age column gets rendered'
  equal Ember.View.views[view.$('table').attr('id')].get('selection'),
    undefined,'none of the rows is selected'

test 'Ensure a single row is rendered with no input elements in case of uneditable single selection', ->
  people = [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people"
    columns="name,age" selectionBinding="selectedPerson" defaultSelectionBinding="sel" isEditable=false}}'
    people: people
    sel: people.slice(0,1)
  appendView()
  ok view.$('table')?, 'table gets rendered'
  ok view.$('thead')?, 'header gets rendered'
  ok view.$('tbody')?, 'body gets rendered'
  rows = view.$('tr')
  equal rows.length, 2, '1 selected row and 1 header get rendered'
  equal view.$('td:eq(0):has(input)').length,
    0, 'no input element is rendered'
  equal view.$('td:eq(0)').text(), "Matt", 'Name column gets rendered'
  equal view.$('td:eq(1)').text(), "22", 'Age column gets rendered'
  equal Ember.View.views[view.$('table').attr('id')].get('selection').length,
    1,'1 selected row is rendered'  
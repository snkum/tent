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

test 'Ensure Table is rendered', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people" columns="name,age" selectionBinding="selectedPerson"}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})];
  appendView()

  ok view.$('table')?, 'table gets rendered'
  ok view.$('thead')?, 'header gets rendered'
  ok view.$('tbody')?, 'body gets rendered'
  rows = view.$('tr')
  equal rows.length, 4, 'all the rows get rendered(header row and body rows)'
  equal view.$('td:eq(0):has(input)').length, 1, 'radio button gets rendered'
  equal view.$('td:eq(1)').text(), "Matt", 'Name column gets rendered'
  equal view.$('td:eq(2)').text(), "22", 'Age column gets rendered'
  equal Ember.View.views[view.$('table').attr('id')].get('selection'), undefined, 'none of the rows is selected' 
  
test 'Ensure Selection', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people" columns="name,age" selectionBinding="selectedPerson"}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})];
  appendView()

  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  rowView2 = Ember.View.views[view.$('tr:eq(2)').attr('id')]
  rowView1.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection'), rowView1.get('content'), 'selection object is updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'), true, 'css gets added on selection'  
  rowView2.mouseUp()
  equal Ember.View.views[view.$('table').attr('id')].get('selection'), rowView2.get('content'), 'selection property of table is updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'), false, 'css gets removed when some other row is selected'
  equal $(rowView2.$()[0]).prop('classList').contains('tent-selected'), true, 'class added to the new selection'

test 'radio button gets checked on row selection', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people" columns="name,age" selectionBinding="selectedPerson"}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})];
  appendView()
  rowView1 = Ember.View.views[view.$('tr:eq(1)').attr('id')]
  rowView2 = Ember.View.views[view.$('tr:eq(2)').attr('id')]
  rowView1.mouseUp()
  equal rowView1.$('input').prop('checked'), true, 'radio button gets checked automatically when row is selected by clicking anywhere else on the row'
  rowView2.mouseUp()
  equal rowView1.$('input').prop('checked'), false, 'radio button gets unchecked automatically when some other row is selected'
  equal rowView2.$('input').prop('checked'), true, 'new radio button gets checked'
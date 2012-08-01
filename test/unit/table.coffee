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
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people" columns="name,age" selectionBinding="selectedPerson"}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})];
  appendView()

)
teardown = ( ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

)
module "Tent - Basic Widgets", setup, teardown

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
  equal view.get('childViews').objectAt(0).get('childViews').objectAt(1).get('childViews').length, 3, 'all the elements get rendered'
  equal view.get('childViews').objectAt(0).get('selection'), undefined, 'none of the rows is selected' 
  
test 'Ensure Selection', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Table listBinding="people" columns="name,age" selectionBinding="selectedPerson"}}'
    people: [Ember.Object.create({name: 'Matt', age: 22}),
          Ember.Object.create({name: 'Raghu', age: 1000}),
          Ember.Object.create({name: 'Sakshi', age: 21})];
  appendView()

  rowView1 = view.get('childViews').objectAt(0).get('childViews').objectAt(1).get('childViews').objectAt(0)
  rowView2 = view.get('childViews').objectAt(0).get('childViews').objectAt(1).get('childViews').objectAt(1)
  rowView1.mouseUp()
  equal view.get('childViews').objectAt(0).get('selection'), rowView1.get('content'), 'selection object is updated'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'), true, 'css gets added on selection'  
  rowView2.mouseUp()
  equal view.get('childViews').objectAt(0).get('selection'), rowView2.get('content'), 'none of the rows is selected'
  equal $(rowView1.$()[0]).prop('classList').contains('tent-selected'), false, 'css gets removed when some other low is selected'
  equal $(rowView2.$()[0]).prop('classList').contains('tent-selected'), true, 'class added to the new selection'


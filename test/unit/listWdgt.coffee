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

module "Tent - Basic Widgets - list", setup, teardown

test 'Ensure List is rendered', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.List listBinding="dummy" listhead="Name,One,Two,Three"}}'
    dummy: [Ember.Object.create({Name:'Favourites', One: 'News feed', Two:'Home', Three:''}),
          Ember.Object.create({Name:'Interests', One: 'Lan Games', Two:'Movies', Three:'Cards'})
          Ember.Object.create({Name:'Groups', One: 'Eceans', Two:'Soccer', Three:''})]
  appendView()

  ok view.$('list')?, 'list gets rendered'
  ok view.$('ul')?, 'ul gets rendered'
  ok view.$('li')?, 'li gets rendered'
  lists = view.$('ul')
  equal lists.length, 3, 'all the lists get rendered'
  equal view.$('li:eq(0)').text(), "Favourites", 'Name column gets rendered' 
  equal view.$('li:eq(1)').text(), "News feed", 'Entry One gets rendered' 
  equal view.$('li:eq(2)').text(), "Home", 'Entry Two gets rendered'
  equal view.$('li:eq(3)').text(), "", 'Entry Three gets rendered'
  equal Ember.View.views[view.$('list').attr('id')].get('selection'),
    undefined,'none of the entry is selected'
  
test "Ensure a single list will be used", ->
  dummy = [Ember.Object.create({Name:'Favourites', One: 'News feed', Two:'Home', Three:''}),
          Ember.Object.create({Name:'Interests', One: 'Lan Games', Two:'Movies', Three:'Cards'})
          Ember.Object.create({Name:'Groups', One: 'Eceans', Two:'Soccer', Three:''})]
  sel = dummy.slice(0,1)["One"]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.List listBinding="dummy" listhead="Name,One,Two,Three" entrySelectedBinding="sel"}}'
    dummy: dummy
  appendView()

  ListView1 = Ember.View.views[view.$('ul:eq(0)').attr('id')]
  ListView2 = Ember.View.views[view.$('ul:eq(1)').attr('id')]
  
  EntryView1 = Ember.View.views[view.$('li:eq(1)').attr('id')]
  EntryView2 = Ember.View.views[view.$('li:eq(5)').attr('id')]
  
  EntryView1.mouseUp()
  equal Ember.View.views[view.$('list').attr('id')].get('_list.selected'), ListView1.get('content') , 'list is updated with first selection'
  
  EntryView2.mouseUp()
  equal Ember.View.views[view.$('list').attr('id')].get('_list.selected'), ListView2.get('content') , 'selected list changed. Updated to list 2'
test "Ensure Single Entry Selection from all lists", ->
  dummy = [Ember.Object.create({Name:'Favourites', One: 'News feed', Two:'Home', Three:''}),
          Ember.Object.create({Name:'Interests', One: 'Lan Games', Two:'Movies', Three:'Cards'})
          Ember.Object.create({Name:'Groups', One: 'Eceans', Two:'Soccer', Three:''})]
  sel = dummy.slice(0, 1)["One"]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.List listBinding="dummy" listhead="Name,One,Two,Three" entrySelectedBinding="sel"}}'
    dummy: dummy
  appendView()

  EntryView1 = Ember.View.views[view.$('li:eq(1)').attr('id')]
  EntryView2 = Ember.View.views[view.$('li:eq(2)').attr('id')]
  
  EntryView1.mouseUp()
  equal Ember.View.views[view.$('list').attr('id')].get('entrySelected'), 'News feed', 'selection is updated'
  equal $(EntryView1.$()).prop('classList').contains('active'), true, 'css gets added on selection'
  EntryView2.mouseUp()
  equal Ember.View.views[view.$('list').attr('id')].get('entrySelected'), 'Home', "selection property of list is updated"
  equal $(EntryView1.$()).prop('classList').contains('active'), false, "css gets removed when some other row is selected"
  equal $(EntryView2.$()).prop('classList').contains('active'), true, "class added to the new selection"
    


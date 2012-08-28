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

module "Tent - Basic Widgets - menu", setup, teardown

test 'Ensure Menu is rendered', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Menu setObjBinding="display" dummyBinding="dummy"}}'
    display: [  Ember.Object.create({Name: 'One'})
                Ember.Object.create({Name: 'Two'})
                Ember.Object.create({Name: 'Three'})
                Ember.Object.create({Name: 'Four'})
                Ember.Object.create({Name: 'Five'})]
    dummy: [   Ember.Object.create({Name:'Favourites',iconName:'/images/icon.jpg', One: 'News feed', iconOne:'/images/icon.jpg', Two:'Home', iconTwo:'/images/icon.jpg', Three:''}),
                Ember.Object.create({Name:'Interests', iconName:'/images/icon.jpg', One: 'Lan Games', iconOne:'/images/icon.jpg', Two:'Movies', iconTwo:'/images/icon.jpg',Three:'Cards', iconThree:'/images/icon.jpg',})
                Ember.Object.create({Name:'Groups', iconName:'/images/icon.jpg', One: 'Eceans', iconOne:'/images/icon.jpg', Two:'Soccer', iconTwo:'/images/icon.jpg', Three:''})]
  appendView()
  
  ok view.$('menu')?, 'menu gets rendered'
  ok view.$('ul')?, 'ul gets rendered'
  ok view.$('li')?, 'li gets rendered'
  ok view.$('a')?, 'link gets rendered'
  ok view.$('button'), 'button gets rendered'
  list = view.$('ul')
  equal list.length, 4, 'Nav list and selection list get rendered'
  button = view.$('button')
  equal button.length, 5, 'All butons are rendered'
  equal view.$('a:eq(0)').text(), "Favourites", 'Name column gets rendered' 
  equal view.$('a:eq(1)').text(), "News feed", 'List Entry One gets rendered' 
  equal view.$('a:eq(2)').text(), "Home", 'List Entry Two gets rendered' 
  equal view.$('li:eq(12)').text(), "One", 'Nav Entry One gets rendered'
  equal view.$('li:eq(13)').text(), "Two", 'Nav Entry Two gets rendered'
  equal view.$('li:eq(14)').text(), "Three", 'Nav Entry Three gets rendered' 
  equal view.$('li:eq(15)').text(), "Four", 'Nav Entry Four gets rendered'
  equal view.$('li:eq(16)').text(), "Five", 'Nav Entry Five gets rendered'
  equal view.$('button:eq(0)').text(), "Search", 'Search Button gets rendered'
  equal view.$('button:eq(1)').text(), "", 'Main Button gets rendered'
  equal view.$('button:eq(2)').text(), "Default", 'Default Button gets rendered'
  equal Ember.View.views[view.$('ul').attr('id')].get('selection'),
    undefined,'none of the entry is selected'
    
test "Ensure the navbar is updated properly", ->
  display = [  Ember.Object.create({Name: 'One'})
                Ember.Object.create({Name: 'Two'})
                Ember.Object.create({Name: 'Three'})
                Ember.Object.create({Name: 'Four'})
                Ember.Object.create({Name: 'Five'})]
  dummy = [   Ember.Object.create({Name:'Favourites',iconName:'/images/icon.jpg', One: 'News feed', iconOne:'/images/icon.jpg', Two:'Home', iconTwo:'/images/icon.jpg', Three:''}),
                Ember.Object.create({Name:'Interests', iconName:'/images/icon.jpg', One: 'Lan Games', iconOne:'/images/icon.jpg', Two:'Movies', iconTwo:'/images/icon.jpg',Three:'Cards', iconThree:'/images/icon.jpg',})
                Ember.Object.create({Name:'Groups', iconName:'/images/icon.jpg', One: 'Eceans', iconOne:'/images/icon.jpg', Two:'Soccer', iconTwo:'/images/icon.jpg', Three:''})]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Menu setObjBinding="display" dummyBinding="dummy"}}'
    dummy: dummy
    display: display
  appendView()

  EntryView1 = Ember.View.views[view.$('li:eq(12)').attr('id')]
  EntryView2 = Ember.View.views[view.$('li:eq(13)').attr('id')]
  
  EntryView1.mouseUp()
  equal  EntryView1.get('content')['Name'], "One", 'navbar is updated with first selection'
  equal $(EntryView1.$()).prop('classList').contains('active'), true, 'css gets added on selection'
  
  EntryView2.mouseUp()
  equal EntryView2.get('content')['Name'], "Two", 'selected entry changed. Updated to entry 2'
  equal $(EntryView1.$()).prop('classList').contains('active'), false, "css gets removed when some other entry is selected"
  equal $(EntryView2.$()).prop('classList').contains('active'), true, "class added to the new selection"

test "Ensure selection list appears/disappears on button click", ->
  display = [  Ember.Object.create({Name: 'One'})
                Ember.Object.create({Name: 'Two'})
                Ember.Object.create({Name: 'Three'})
                Ember.Object.create({Name: 'Four'})
                Ember.Object.create({Name: 'Five'})]
  dummy = [   Ember.Object.create({Name:'Favourites',iconName:'/images/icon.jpg', One: 'News feed', iconOne:'/images/icon.jpg', Two:'Home', iconTwo:'/images/icon.jpg', Three:''}),
                Ember.Object.create({Name:'Interests', iconName:'/images/icon.jpg', One: 'Lan Games', iconOne:'/images/icon.jpg', Two:'Movies', iconTwo:'/images/icon.jpg',Three:'Cards', iconThree:'/images/icon.jpg',})
                Ember.Object.create({Name:'Groups', iconName:'/images/icon.jpg', One: 'Eceans', iconOne:'/images/icon.jpg', Two:'Soccer', iconTwo:'/images/icon.jpg', Three:''})]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Menu setObjBinding="display" dummyBinding="dummy"}}'
    dummy: dummy
    display: display
  appendView()

  ButtonView = Ember.View.views[view.$('button:eq(1)').attr('id')]  
  
  ButtonView.click()
  equal view.$('.navbar-container').prop('classList').contains('tent-slidein'), true, "css gets added on button click"
    
  ButtonView.click()
  equal view.$('.navbar-container').prop('classList').contains('tent-slidein'), false, "previous css gets removed on button click"
  equal view.$('.navbar-container').prop('classList').contains('tent-slideout'), true, "new css gets added on button click"
  
  ButtonView.click()
  equal view.$('.navbar-container').prop('classList').contains('tent-slideout'), false, "previous css gets removed on button click"
  equal view.$('.navbar-container').prop('classList').contains('tent-slidein'), true, "new css gets added on button click"
    
test "Ensure style is updated using style buttons", ->
  display = [  Ember.Object.create({Name: 'One'})
                Ember.Object.create({Name: 'Two'})
                Ember.Object.create({Name: 'Three'})
                Ember.Object.create({Name: 'Four'})
                Ember.Object.create({Name: 'Five'})]
  dummy = [   Ember.Object.create({Name:'Favourites',iconName:'/images/icon.jpg', One: 'News feed', iconOne:'/images/icon.jpg', Two:'Home', iconTwo:'/images/icon.jpg', Three:''}),
                Ember.Object.create({Name:'Interests', iconName:'/images/icon.jpg', One: 'Lan Games', iconOne:'/images/icon.jpg', Two:'Movies', iconTwo:'/images/icon.jpg',Three:'Cards', iconThree:'/images/icon.jpg',})
                Ember.Object.create({Name:'Groups', iconName:'/images/icon.jpg', One: 'Eceans', iconOne:'/images/icon.jpg', Two:'Soccer', iconTwo:'/images/icon.jpg', Three:''})]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Menu setObjBinding="display" dummyBinding="dummy"}}'
    dummy: dummy
    display: display
  appendView()
  
  ButtonView1 = Ember.View.views[view.$('button:eq(3)').attr('id')]
  ButtonView2 = Ember.View.views[view.$('button:eq(4)').attr('id')]
  
  ButtonView1.click()
  equal view.$('menu').prop('classList').contains('fb-menu-container'), true, "Menu css style updated on button click" 
  equal view.$('menu').prop('classList').contains('tent-menu-container'), false, "previous css gets removed on button click"
    
  ButtonView2.click()
  equal view.$('menu').prop('classList').contains('gwt-menu-container'), true, "Menu css style updated on button click" 
  equal view.$('menu').prop('classList').contains('fb-menu-container'), false, "previous css gets removed on button click"
  
test "Ensure page is updated and css added on entry selection", ->
  display = [  Ember.Object.create({Name: 'One'})
                Ember.Object.create({Name: 'Two'})
                Ember.Object.create({Name: 'Three'})
                Ember.Object.create({Name: 'Four'})
                Ember.Object.create({Name: 'Five'})]
  dummy = [   Ember.Object.create({Name:'Favourites',iconName:'/images/icon.jpg', One: 'News feed', iconOne:'/images/icon.jpg', Two:'Home', iconTwo:'/images/icon.jpg', Three:''}),
                Ember.Object.create({Name:'Interests', iconName:'/images/icon.jpg', One: 'Lan Games', iconOne:'/images/icon.jpg', Two:'Movies', iconTwo:'/images/icon.jpg',Three:'Cards', iconThree:'/images/icon.jpg',})
                Ember.Object.create({Name:'Groups', iconName:'/images/icon.jpg', One: 'Eceans', iconOne:'/images/icon.jpg', Two:'Soccer', iconTwo:'/images/icon.jpg', Three:''})]
  sel = dummy.slice(0, 1)["One"]
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Menu setObjBinding="display" dummyBinding="dummy" clickedBinding="sel"}}'
    dummy: dummy
    display: display
  appendView()
  
  Menu = Ember.View.views[view.$('menu').attr('id')]
  EntryView1 = Ember.View.views[view.$('li:eq(1)').attr('id')]
  EntryView2 = Ember.View.views[view.$('li:eq(2)').attr('id')]
  
  EntryView1.mouseUp()
  Ember.run.sync()
  equal view.$('a:eq(1)').text(), Ember.View.views[view.$('menu').attr('id')].get('clicked'), 'Page gets updated'
  equal view.$('.navbar-container').prop('classList').contains('tent-slidein'), false, "previous css gets removed on entry selection"
  equal view.$('.navbar-container').prop('classList').contains('tent-slideout'), true, "new css gets added on entry selection"
    
  EntryView1.mouseUp()
  Ember.run.sync()
  equal view.$('a:eq(1)').text(), Ember.View.views[view.$('menu').attr('id')].get('clicked'), 'Page remains same'
  equal view.$('.navbar-container').prop('classList').contains('tent-slidein'), false, "css changes occur"
  equal view.$('.navbar-container').prop('classList').contains('tent-slideout'), true, "css changes occur"
  
  EntryView2.mouseUp()
  Ember.run.sync()
  equal view.$('a:eq(2)').text(), Ember.View.views[view.$('menu').attr('id')].get('clicked'), 'Page gets rendered'
  equal view.$('.navbar-container').prop('classList').contains('tent-slidein'), false, "previous css gets removed on entry selection"
  equal view.$('.navbar-container').prop('classList').contains('tent-slideout'), true, "new css gets added on entry selection"
#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
dispatcher = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
setup = ->
  @TemplateTests = Ember.Namespace.create()
  @TemplateTests.testObject = Em.Object.create(
    options: [Ember.Object.create(
      label: "Add"
      target: "TemplateTests.testObject"
      action: "addEvent"
    ), Ember.Object.create(
      label: "Edit"
      target: "TemplateTests.testObject"
      action: "editEvent"
    )]
    addEvent: ->
      @set "addClicked", true

    editEvent: ->
      @set "editClicked", true
  )
  @TemplateTests.missingProps = Em.Object.create(
    options: [Ember.Object.create(
      action: "addEvent"
    ), Ember.Object.create(
      action: "editEvent"
    )]
    addEvent: ->
      @set "addClicked", true

    editEvent: ->
      @set "editClicked", true
  )

  Ember.run ->
    dispatcher = Ember.EventDispatcher.create()
    dispatcher.setup()
  
teardown = ->
  @TemplateTests = undefined
  Em.run -> 
    view.destroy() if view
    dispatcher.destroy()

module "Button Widget", setup, teardown

#Test case scenarios for simple button functionality

#Case 1: When no additional property set to view, ensure the default layout
test "ensure default layout is rendered when no additional property are set",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button}}'
  
  appendView()
  element= view.$('.btn')
  ok element
  # Assert default behaviour
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal $(element).attr('disabled'), `undefined`, 'Button is by default enable'
  equal $(element).text().trim(), 'Button', 'Label of button is by default Button'
  equal view.$().parent().attr('id'), 'qunit-fixture','Appended to div having id qunit-fixture'

#Case 2: When label property set to "Test Button"
test "ensure label is rendered when set",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button label="Test Button"}}'
  
  appendView()
  element= view.$('.btn')
  ok element
  equal $(element).text().trim(), 'Test Button', 'Label of button is set to Test Button'
  
#Case 3: When type property is set to a unknown class
test "type property is set to a unknown class is gracefully handled",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="unknown"}}'
  
  appendView()
  element= view.$('.btn')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf("unknown"), -1, "class is not applied, it is set to default"

 
#Case 4: When type property is set to a known class
test "button renders correct class, when type property is set to a known class",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="primary"}}'
  
  appendView()
  element= view.$('.btn')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf('btn-primary'), 4 , "btn-primary class applied successfully"

#Case 5: When isDisabled property is set to true
test "buton is disabled when isDisabled property is set to true",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button isDisabled=true}}'
  
  appendView()
  element= view.$('.btn')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf("disabled"), 4, "disabled class applied"
  equal $(element).attr('disabled'), 'disabled', 'disabled attribute applied'

#Case 6: When label and isDisabled both properties is set
test "Ensure no failures when label and isDisabled both are set",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="success" isDisabled="true"}}'
  
  appendView()
  element= view.$('.btn')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf("btn-success"), 4, "disabled class applied"
  equal classes.indexOf("disabled"), 16, "disabled class applied"
  equal $(element).attr('disabled'), 'disabled', 'Disabled attribute applied'

#Case 7: When event name is set to some controller
test "Ensure action is triggered when action is set without target",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button action="display"}}'
    display: ->
      @set "buttonClicked", true
  
  appendView()
  view.$('.btn').trigger('click')
  equal true, view.get('buttonClicked'), 'Button was indeed clicked'


##------------------------------------------------------------------------
## ---------------- Qunit tests for button drop down menu ---------------
## ----------------------------------------------------------------------
#Case 8 : When options provided with view
test "Ensure options are rendered properly, and click event will opens options properly",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="primary" optionsBinding="options" optionLabelPath="label" optionTargetPath="target" optionActionPath="action" contentBinding="content"}}'
    contentBinding: 'TemplateTests.testObject'
  appendView()  
  element= view.$('.btn')
  ok element
  # Assert default behaviour
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1 and classes.indexOf("btn-primary") isnt -1 and classes.indexOf("dropdown-toggle") isnt -1
  equal $(element).attr('disabled'), `undefined`, 'button is by default enable'
  equal $(element).text().trim(), 'Button', 'Label of button is by default Button'
  equal view.$().parent().attr('id'), 'qunit-fixture','appended to div having id qunit-fixture'

  #Check event handler and ensure that list of chioces should be open
  view.$('.btn').trigger('click')
  equal view.$('.open')[0],view.$('.button-group')[0], 'class open is applied'
  equal view.$('.dropdown-menu').css('display'), 'block', 'display property of dropdown-menu is block'
  
  #Now click an event on the list of options
  view.$('ul>li:eq(1)').trigger('click')
  reference = TemplateTests.testObject
  equal true, reference.get('editClicked'), 'edit button choice was clicked'
  equal `undefined`, reference.get('addClicked'), 'add button choie remains unclicked'
  equal view.$('.open').length, 0 , 'dropdown-menu is closed gracefully'
  
#Case 9 : When options provided with view
test "Ensure options are rendered properly with disabled property, and click event should not work",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="primary" optionsBinding="options" optionLabelPath="label" optionTargetPath="target" optionActionPath="action" isDisabled="true" contentBinding="content"}}'
    contentBinding: 'TemplateTests.testObject'
    
  appendView()  
  element= view.$('.btn')
  ok element
  # Assert default behaviour
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1 and classes.indexOf("btn-primary") isnt -1 and classes.indexOf("dropdown-toggle") isnt -1
  equal classes.indexOf("disabled"), 32, "disabled class applied"
  equal $(element).text().trim(), 'Button', 'Label of button is by default Button'
  equal view.$().parent().attr('id'), 'qunit-fixture','appended to div having id qunit-fixture'

  #Check event handler and ensure that list of chioces should be open
  view.$('.btn').trigger('click')
  equal view.$('.open').length, 0, 'click event is not dispatched'

#Case 10 : When options provided with view and all other paths are default
test "Ensure options are rendered properly, and Event will triggered properly(when target property missing from options and default context is view)",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="primary" optionsBinding="options"}}'
    options: [Ember.Object.create(
      label: "Add"
      action: "addEvent"
    ), Ember.Object.create(
      label: "Edit"
      action: "editEvent"
    )]
    addEvent: ->
      @set "addClicked", true

    editEvent: ->
      @set "editClicked", true
  
  appendView()  
  element= view.$('.btn')
  ok element
  # Assert default behaviour
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1 and classes.indexOf("btn-primary") isnt -1 and classes.indexOf("dropdown-toggle") isnt -1
  equal $(element).attr('disabled'), `undefined`, 'button is by default enable'
  equal $(element).text().trim(), 'Button', 'Label of button is by default Button'
  equal view.$().parent().attr('id'), 'qunit-fixture','appended to div having id qunit-fixture'

  #Check event handler and ensure that list of chioces should be open
  view.$('.btn').trigger('click')
  equal view.$('.open')[0],view.$('.button-group')[0], 'class open is applied'
  equal view.$('.dropdown-menu').css('display'), 'block', 'display property of dropdown-menu is block'
  
  #Now click an event on the list of options
  view.$('ul>li:eq(0)').trigger('click')
  equal true, view.get('addClicked'), 'add button choice was clicked'
  equal `undefined`, view.get('editClicked'), 'edit button choie remains unclicked'
  equal view.$('.open').length, 0 , 'dropdown-menu is closed gracefully'


#Case 8 : When options provided with view
test "Ensure options are rendered properly,  and Event will triggered properly(when label and target property missing from options)",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="primary" optionsBinding="options" contentBinding="content"}}'
    contentBinding: 'TemplateTests.missingProps'
    
  appendView()  
  element= view.$('.btn')
  ok element
  # Assert default behaviour
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1 and classes.indexOf("btn-primary") isnt -1 and classes.indexOf("dropdown-toggle") isnt -1
  equal $(element).attr('disabled'), `undefined`, 'button is by default enable'
  equal $(element).text().trim(), 'Button', 'Label of button is by default Button'
  equal view.$().parent().attr('id'), 'qunit-fixture','appended to div having id qunit-fixture'

  #Check event handler and ensure that list of chioces should be open
  view.$('.btn').trigger('click')
  equal view.$('.open')[0],view.$('.button-group')[0], 'class open is applied'
  dropMenu = view.$('.dropdown-menu')
  equal dropMenu.css('display'), 'block', 'display property of dropdown-menu is block'
  equal $('li:eq(0)>a',dropMenu).text(), "Add Event", 'Label is set to "Add Event" successfully'
  equal $('li:eq(1)>a',dropMenu).text(), "Edit Event", 'Label is set to "Add Event" successfully' 
  
  #Now click an event on the list of options
  view.$('ul>li:eq(1)').trigger('click')
  reference = TemplateTests.missingProps
  equal true, reference.get('editClicked'), 'edit button choice was clicked'
  equal `undefined`, reference.get('addClicked'), 'add button choie remains unclicked'
  equal view.$('.open').length, 0 , 'dropdown-menu is closed gracefully'  
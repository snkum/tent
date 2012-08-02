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

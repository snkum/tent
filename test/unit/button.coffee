#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
setup = ->
  @TemplateTests = Ember.Namespace.create()
  
teardown = ->
  @TemplateTests = undefined
  (Em.run -> view.destroy()) if view

module "Button Widget", setup, teardown

#Test case scenarios for simple button functionality

#Case 1: When no additional property set to view, ensure the default layout
test "Case 1: When no additional property set to view, ensure the default layout",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button}}'
  
  appendView()
  element= view.$('button')
  ok element
  # Assert default behaviour
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal $(element).attr('disabled'), `undefined`, 'Button is by default enable'
  equal $(element).text().trim(), 'Button', 'Label of button is by default Button'
  equal view.$().parent().attr('id'), 'qunit-fixture','Appended to div having id qunit-fixture'

#Case 2: When label property set to "Test Button"
test "Case 2: When label property set to Test Button",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button label="Test Button"}}'
  
  appendView()
  element= view.$('button')
  ok element
  equal $(element).text().trim(), 'Test Button', 'Label of button is set to Test Button'
  
#Case 3: When type property is set to a unknown class
test "Case 3: When type property is set to a unknown class",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="unknown"}}'
  
  appendView()
  element= view.$('button')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf("unknown"), -1, "Class is not applied, It set to default"

 
#Case 4: When type property is set to a known class
test "Case 4: When type property is set to a known class",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="primary"}}'
  
  appendView()
  element= view.$('button')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf('btn-primary'), 4 , "btn-primary class applied successfully"

#Case 5: When isDisabled property is set to true
test "Case 5: When isDisabled property is set to true",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button isDisabled="true"}}'
  
  appendView()
  element= view.$('button')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf("disabled"), 4, "disabled class applied"
  equal $(element).attr('disabled'), 'disabled', 'Disabled attribute applied'

#Case 6: When label and isDisabled both properties is set
test "Case 6: When label and isDisabled both properties is set",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button type="success" isDisabled="true"}}'
  
  appendView()
  element= view.$('button')
  ok element
  classes = $(element).attr('class')
  ok classes.indexOf("btn") isnt -1
  equal classes.indexOf("btn-success"), 4, "disabled class applied"
  equal classes.indexOf("disabled"), 16, "disabled class applied"
  equal $(element).attr('disabled'), 'disabled', 'Disabled attribute applied'

#Case 7: When event name is set to some controller
test "Case 7:  When event name is set without target",->
  view = Em.View.create
    template: Ember.Handlebars.compile '{{view Tent.Button action="display" target="parentView"}}'
    display: ->
      console.log "Event fired"
      @set "fired", true
  
  appendView()
  element= view.$('button')
  ok element
  $(element).trigger('click')
  #TODO need to check the event 

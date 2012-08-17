#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))


module "Tent.Select tests", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure Tent.Select renders for list', ->
  application = Ember.Namespace.create()

  application.content = [
      Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
      Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
      Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
    ]

  application.stateSelection = Ember.Object.create()  

  view = Ember.View.create
    app: application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="application.stateSelection"
                          viewName="select"}}'

  appendView()

  ok view.$().length, 'Select was rendered'
  equal view.$('option').length, application.content.length + 1,  'Options were rendered'
  equal view.$().text().trim(), "Please Select...GeorgiaFloridaArkansas", 'Option values were rendered'
  equal view.get('selection'), null, 'Nothing has been selected'

  # add a new object to the list and see if the select holds that object 
  Ember.run -> application.content.pushObject(Ember.Object.create({stateName: 'Alaska', stateCode: 'AK'}))
  equal view.$('option').length, application.content.length + 1,  'New option was added'  




  
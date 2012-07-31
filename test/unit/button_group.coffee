#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

module "Tent.ButtonGroup tests", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure ButtonGroup renders', ->
  application = Ember.Namespace.create()

  application.btnOptions = [
      Ember.Object.create({label: 'Add', target: 'showAdd'}),
      Ember.Object.create({label: 'Edit',  target: 'showEdit'}),
      Ember.Object.create({label: 'Delete',  target: 'showDelete'})
    ]


  view = Ember.View.create
    app: application
    template: Ember.Handlebars.compile '{{view Tent.ButtonGroup 
                                               labelBinding="label" 
                                               optionsBinding="app.btnOptions" 
                                               optionLabelPath="label" 
                                               optionTargetPath="target" }}'
    label: "User"                                           
  appendView()

  ok view.$('div a').hasClass('btn btn-primary'), 'btn btn-primary classes gets applied'
  ok view.$('div a').hasClass('dropdown-toggle'), 'dropdown-toggle classes gets applied'
  equal view.$('li').length, application.btnOptions.length, 'options rendered'  
  equal view.$('li').text().trim(), 'AddEditDelete' , 'options value rendered'
  ok view.$("a.btn-primary:contains('"+Tent.translate(view.get('label'))+"')").length > 0 , 'label rendered' 

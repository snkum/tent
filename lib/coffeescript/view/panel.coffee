#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Panel = Ember.View.extend
  layout: Ember.Handlebars.compile '{{#if view.name}}<h3>{{view.name}}</h3>{{/if}}{{yield}}'
  classNameBindings: ['spanClass']
  spanClass: (-> 'span' + @get('span') if @get('span')).property('span')

Tent.Form = Tent.Panel.extend
  tagName: 'form'
  classNameBindings: ['spanClass', 'formClasses']
  formClasses: (-> 'well form-horizontal').property()

Tent.Fieldset = Tent.Panel.extend
  layout: Ember.Handlebars.compile '{{#if view.name}}<legend>{{view.name}}</legend>{{/if}}{{yield}}'
  tagName: 'fieldset'

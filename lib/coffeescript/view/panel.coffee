#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require './span_support'

Tent.Panel = Ember.View.extend Tent.SpanSupport,
  layout: Ember.Handlebars.compile '{{#if view.name}}<h3>{{view.name}}</h3>{{/if}}{{yield}}'
  classNameBindings: ['spanClass']

Tent.Form = Tent.Panel.extend
  tagName: 'form'
  staticClasses: 'well'
  classNameBindings: ['spanClass', 'staticClasses', 'formClass']
  formStyle: 'horizontal'
  formClass: (-> 'form-' + @get('formStyle')).property('formStyle')


Tent.Fieldset = Tent.Panel.extend
  layout: Ember.Handlebars.compile '{{#if view.name}}<legend>{{view.name}}</legend>{{/if}}{{yield}}'
  tagName: 'fieldset'

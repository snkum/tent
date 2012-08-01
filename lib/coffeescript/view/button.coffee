#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Button = Ember.View.extend Ember.TargetActionSupport,
  classNames : ['btn']
  tagName : 'button'
  template: Ember.Handlebars.compile '{{view.label}}'

  init: ->
    @_super()
    type = @get('type')
    classNames = @get('classNames')
    classNames.push('btn-' + type) if type  

  click:(event)->
    @triggerAction()

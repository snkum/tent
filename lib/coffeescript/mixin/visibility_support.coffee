#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../util/translation_support'

Tent.VisibilitySupport = Ember.Mixin.create 
  isVisible: true
  _widgetShowing: true
  isVisibleAsBoolean: Tent.computed.boolCoerceGently 'isVisible'
  isHidden: Ember.computed.not 'isVisibleAsBoolean'

  observesVisibility: (->
    if (@get('isVisibleAsBoolean'))
      @$().show() unless @get('_widgetShowing')
      @set('_widgetShowing', true)
    else
      @$().hide() if @get('_widgetShowing')
      @set('_widgetShowing', false)
  ).observes('isVisible')

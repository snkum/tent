#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

SCi.Button = Ember.View.extend
  classNames: ['btn-group']
  
  translatedLabel: SCi.translate 'label'
  
  hasOptions: (->
    @get('options') != undefined
  ).property('options')

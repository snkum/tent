#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.Button = Ember.View.extend
  classNames: ['btn-group']
  
  hasOptions: (->
    @get('options') != undefined
  ).property('options')

#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/table'

Tent.Table = Ember.View.extend
  classNames: ['table', 'table-striped', 'table-bordered', 'table-condensed']
  tagName: 'table'
  templateName: 'table'
  value: [
    Ember.Object.create({name: 'Matt', age: 22}),
    Ember.Object.create({name: 'Raghu', age: 1000})
  ]

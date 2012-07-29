#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.ProgressBar = Ember.View.extend
  classNames: ['tent-progress-bar', 'progress']
  classNameBindings: ['isStriped:progress-striped', 'isAnimated:active']
  template: Ember.Handlebars.compile '<div class="bar" {{bindAttr style="view.style"}}></div>' 
  isAnimated: false
  isStriped: false
  progress: 0    

  style: Ember.computed(->
    "width:" + @get('progress') + "%;"
  ).property('progress')  
#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/nav_bar'
require '../template/nav'

Tent.NavBar = Ember.View.extend
  templateName: 'nav'
  classNames:['tent-menu-container']
  oldLabel: 'tent'
  dummy: [Ember.Object.create({Name:'Favourites', One: 'News feed', Two:'Home', Three:''})
        Ember.Object.create({Name:'Interests', One: 'Lan Games', Two:'Movies', Three:'Cards'})
        Ember.Object.create({Name:'Groups', One: 'Eceans', Two:'Soccer', Three:''})]
  
  
Tent.NavList = Ember.View.extend
  tagName: 'ul'
  classNames: ['nav']
  templateName: 'nav_bar'
  init: ->
    @_super()
    @set('_list', @get('list'))
    @set('_list.selected',null)
    @set('selection',null)
    
  select: (tmp) ->
    @set('_list.selected', tmp)
  
  selectionDidChange: (->
    @set('selection', @get('_list.selected'))
  ).observes('_list.selected')
  
  isCellSelected: (cell) ->
    if (selElements = @get('_list').get('selected')) isnt null
      #for the time when page first renders or when nothing is selected
      selElements is cell.get('content')
    else
        false 
      
Tent.NavCell = Ember.View.extend
  tagName: 'li'
  defaultTemplate: Ember.Handlebars.compile('{{view Tent.NavLink cellBinding="view.content"}}')
  classNameBindings: ['isSelected']
  
  init: ->
    @_super()
    @set('val', @get('content'))
      
  parentList: (-> @get('parentView.parentView')).property()
  
  isSelected: (->
    'active' if @get('parentList').isCellSelected(this)
  ).property('parentList.selection')
  
  mouseUp: ->
    @get('parentList').select(@get('content')) 
      
  
  
Tent.NavLink = Ember.View.extend
  tagName: 'a'
  defaultTemplate: Ember.Handlebars.compile('{{view.value}}')
  
  value: (->
    if @cell then @cell['Name'] else ''
  ).property('cell')
  

Tent.ButtonIconned = Ember.View.extend
  tagName: 'button'
  count: 0
     
  click: ->
    console.log @label
    if @label is 'mov'
      @count = @count+1   
      if @count%2 is 1
        if @count is 1
          @get('parentView').$('.navbar-container').addClass('tent-slidein')
          $('.list-container').css 'display', 'block'
        else 
          @get('parentView').$('.navbar-container').removeClass('tent-slideout').addClass('tent-slidein')
      else
        @get('parentView').$('.navbar-container').removeClass('tent-slidein').addClass('tent-slideout')
        
    else
      console.log @label
      console.log @get('parentView').get('oldLabel')
      if @get('parentView').get('oldLabel') isnt @label
        $('.'+@get('parentView').get('oldLabel')+'-menu-container').addClass(@label+'-menu-container').removeClass(@get('parentView').get('oldLabel')+'-menu-container')
        @set('parentView.oldLabel',@label)
        console.log "Done"
        console.log @label
        console.log @get('parentView').get('oldLabel')
      
    
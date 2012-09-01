Tent.MainView = Ember.View.create
    defaultTemplate: Ember.Handlebars.compile('{{view Tent.Menu setObjBinding="display" dummyBinding="dummy"}}')
    display: [ Ember.Object.create({Name: 'One'})
                Ember.Object.create({Name: 'Two'})
                Ember.Object.create({Name: 'Three'})
                Ember.Object.create({Name: 'Four'})
                Ember.Object.create({Name: 'Five'})]
                
    dummy: [ Ember.Object.create({Name:'Favourites',iconName:'/images/icon.jpg', One: 'News feed', iconOne:'/images/icon.jpg', Two:'Home', iconTwo:'/images/icon.jpg', Three:''}),
        Ember.Object.create({Name:'Interests', iconName:'/images/icon.jpg', One: 'Lan Games', iconOne:'/images/icon.jpg', Two:'Movies', iconTwo:'/images/icon.jpg',Three:'Cards', iconThree:'/images/icon.jpg',})
        Ember.Object.create({Name:'Groups', iconName:'/images/icon.jpg', One: 'Eceans', iconOne:'/images/icon.jpg', Two:'Soccer', iconTwo:'/images/icon.jpg', Three:''})]
  
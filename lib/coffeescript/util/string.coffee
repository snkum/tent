SCi.DEFAULT_STRING_TRUNCATION_LENGTH = 30

Ember.mixin String.prototype, 
  truncate: (maxLength) ->
    length = Ember.none(maxLength) ? DEFAULT_STRING_TRUNCATION_LENGTH : maxLength
    if (@length <= length)
      @toString()
    else
      @substr(0, length) + '...'

  isBlank: ->
    @trim().length == 0


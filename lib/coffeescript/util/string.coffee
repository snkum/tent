Tent.DEFAULT_STRING_TRUNCATION_LENGTH = 30

Ember.mixin String.prototype, 
  truncate: (maxLength) ->
    length = if Ember.none(maxLength) then Tent.DEFAULT_STRING_TRUNCATION_LENGTH else maxLength
    if (@length <= length)
      @toString()
    else
      @substr(0, length) + '...'

  camelToWords: ->
    spaced = @replace(/([A-Z])/g, " $1")
    spaced[0].toUpperCase() + spaced.substring(1)

  isBlank: ->
    @trim().length == 0

  toBoolean: ->
    @toLowerCase() == 'true' 

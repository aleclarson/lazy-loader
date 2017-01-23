
ReactiveVar = require "ReactiveVar"
Promise = require "Promise"
Loader = require "loader"
isType = require "isType"
Type = require "Type"

type = Type "LazyLoader"

type.inherits Loader

type.defineValues ->

  _value: ReactiveVar()

type.defineGetters

  value: -> @_value.get()

  isLoaded: -> @_value.get() isnt undefined

type.defineMethods

  get: (key) ->
    value = @_value.get()
    if value isnt undefined
    then value[key]
    else null

type.overrideMethods

  load: ->
    value = @_value.get()
    if value isnt undefined
    then Promise value
    else @__super arguments

  __onLoad: (value) ->
    @_value.set value
    return value

  __onUnload: ->
    value = @_value.get()
    value.unload() if value and isType value.unload, Function
    @_value.set undefined
    return

module.exports = type.build()

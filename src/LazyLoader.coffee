
Promise = require "Promise"
Loader = require "loader"
isType = require "isType"
Type = require "Type"

type = Type "LazyLoader"

type.inherits Loader

type.defineProperties

  loaded:
    value: undefined
    reactive: yes

type.overrideMethods

  load: ->

    if @loaded isnt undefined
      return Promise @loaded

    @__super arguments

  __onLoad: (result) ->

    @loaded = result

    return result

  __onUnload: ->

    result = @loaded

    if result and isType result.unload, Function
      result.unload()

    @loaded = undefined

module.exports = type.build()

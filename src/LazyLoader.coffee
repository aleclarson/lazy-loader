
{ isKind } = require "type-utils"

Loader = require "loader"
Type = require "Type"
Q = require "q"

type = Type "LazyLoader"

type.inherits Loader

type.defineProperties

  loaded:
    value: undefined
    reactive: yes

type.overrideMethods

  load: ->

    if @loaded isnt undefined
      return Q.fulfill @loaded

    @__super arguments

  __onLoad: (result) ->

    @loaded = result

    return result

  __onUnload: ->

    result = @loaded

    if (isKind result, Object) and (isKind result.unload, Function)
      result.unload()

    @loaded = undefined

module.exports = type.build()

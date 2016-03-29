
{ isKind } = require "type-utils"

Factory = require "factory"
Loader = require "loader"
Q = require "q"

module.exports = Factory "LazyLoader",

  kind: Loader

  customValues:

    loaded:
      value: undefined
      reactive: yes

  load: ->
    return Q.fulfill @loaded if @loaded isnt undefined
    Loader::load.apply this, arguments

  _onLoad: (result) ->
    @loaded = result
    result

  _onUnload: ->
    result = @loaded
    result.unload() if (isKind result, Object) and (isKind result.unload, Function)
    @loaded = undefined

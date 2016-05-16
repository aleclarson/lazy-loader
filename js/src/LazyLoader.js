var Loader, Q, Type, isType, type;

Loader = require("loader");

isType = require("isType");

Type = require("Type");

Q = require("q");

type = Type("LazyLoader");

type.inherits(Loader);

type.defineProperties({
  loaded: {
    value: void 0,
    reactive: true
  }
});

type.overrideMethods({
  load: function() {
    if (this.loaded !== void 0) {
      return Q.fulfill(this.loaded);
    }
    return this.__super(arguments);
  },
  __onLoad: function(result) {
    this.loaded = result;
    return result;
  },
  __onUnload: function() {
    var result;
    result = this.loaded;
    if (result && isType(result.unload, Function)) {
      result.unload();
    }
    return this.loaded = void 0;
  }
});

module.exports = type.build();

//# sourceMappingURL=../../map/src/LazyLoader.map

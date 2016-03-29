var Factory, Loader, Q, isKind;

isKind = require("type-utils").isKind;

Factory = require("factory");

Loader = require("loader");

Q = require("q");

module.exports = Factory("LazyLoader", {
  kind: Loader,
  customValues: {
    loaded: {
      value: void 0,
      reactive: true
    }
  },
  load: function() {
    if (this.loaded !== void 0) {
      return Q.fulfill(this.loaded);
    }
    return Loader.prototype.load.apply(this, arguments);
  },
  _onLoad: function(result) {
    this.loaded = result;
    return result;
  },
  _onUnload: function() {
    var result;
    result = this.loaded;
    if ((isKind(result, Object)) && (isKind(result.unload, Function))) {
      result.unload();
    }
    return this.loaded = void 0;
  }
});

//# sourceMappingURL=../../map/src/LazyLoader.map

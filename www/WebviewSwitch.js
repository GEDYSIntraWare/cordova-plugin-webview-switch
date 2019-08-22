/* global cordova */

function WebviewSwitch() {
}

WebviewSwitch.prototype.load = function (name, successCallback, errorCallback) {
  cordova.exec(
    successCallback,
    errorCallback,
    "WebviewSwitch",
    "load",
    [name]
  );
};

WebviewSwitch.prototype.setHostname = function (name, successCallback, errorCallback) {
  cordova.exec(
    successCallback,
    errorCallback,
    "WebviewSwitch",
    "setHostname",
    [name]
  );
};

module.exports = new WebviewSwitch();
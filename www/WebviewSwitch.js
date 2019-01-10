/* global cordova */

function WebviewSwitch() {
}

WebviewSwitch.prototype.load = function (name, successCallback, errorCallback) {
  cordova.exec(
    successCallback,
    errorCallback,
    "WebviewSwitch",
    "load",
    name
  );
};

module.exports = new WebviewSwitch();
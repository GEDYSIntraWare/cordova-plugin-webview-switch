# cordova-plugin-webview-switch

>Experimental plugin to switch the webview at runtime. Please read [warning](attention) before trying.

:warning:
# Attention

Only load webviews installed like WKWebView or Ionic WKWebView. App crashes and incompatabilities with Cordova updates may occurr.
If callbacks from plugins fire after reloading the app will crash.

**Use with caution!**

**After calling `load()` the main view in the app will restart!**

## Usage

> iOS only now

**WebViews must be installed as plugins such as:**

Install WKWebview plugin(s) and [configure](https://github.com/apache/cordova-plugin-wkwebview-engine#required-permissions) it as default in config.xml:

````xml
<feature name="CDVWKWebViewEngine">
  <param name="ios-package" value="CDVWKWebViewEngine" />
</feature>

<preference name="CordovaWebViewEngine" value="CDVWKWebViewEngine" />
````

This plugin creates the global Javascript object `WebviewSwitch` which has the funtion `load()`to switch.

Examples:
* Switch to default Cordova UIWebview at runtime: `WebviewSwitch.load('CDVUIWebViewEngine')`
* Switch to WKWebview at runtime: `WebviewSwitch.load('CDVWKWebViewEngine')`
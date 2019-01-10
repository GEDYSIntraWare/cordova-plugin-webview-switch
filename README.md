# cordova-plugin-webview-switch

>Experimental plugin to switch the webview at runtime. Please read [warning](attention) before trying.

* Install WKWebview plugin and configure it as default
* Switch to default UIWebview at runtime: `WebviewSwitch.load('CDVUIWebViewEngine')`

# Attention

Only load webviews installed like WKWebView or Ionic WKWebView. App crashes and incompatabilities with Cordova updates may occurr.
If callbacks from plugins fire after reloading the app will crash.

**After calling `load()` the main view in the app will restart!**
# cordova-plugin-webview-switch

## Experimental plugin to switch the webview and origin at runtime.

> Please read warning and do not use it in production apps.

# Attention :warning:

This plugin only loads webviews, installed as plugins, like [WKWebView](https://github.com/apache/cordova-plugin-wkwebview-engine) or [Ionic WKWebView](https://github.com/ionic-team/cordova-plugin-ionic-webview). App crashes and incompatibilities with Cordova updates may occurr.

If callbacks from plugins fire after reloading the webview, the app will crash.

## Use with caution!

**After calling `load()` the main view in the app will restart!**

## Webview switching

> iOS only now

**WebViews must be installed as plugins such as:**

Install WKWebview plugin(s) and [configure](https://github.com/apache/cordova-plugin-wkwebview-engine#required-permissions) it as default in config.xml:

* [Apache WKWebView](https://github.com/apache/cordova-plugin-wkwebview-engine)
* [Ionic WKWebView](https://github.com/ionic-team/cordova-plugin-ionic-webview)

````xml
<feature name="CDVWKWebViewEngine">
  <param name="ios-package" value="CDVWKWebViewEngine" />
</feature>

<preference name="CordovaWebViewEngine" value="CDVWKWebViewEngine" />
````

This plugin creates the global Javascript object `WebviewSwitch` which has the funtion `load()`to switch the Cordova webview (plugin).

Examples:
* Switch to default Cordova UIWebview at runtime: `WebviewSwitch.load('CDVUIWebViewEngine')`
* Switch to WKWebview at runtime: `WebviewSwitch.load('CDVWKWebViewEngine')`
* The In-App-Browser plugin works too and shares the session. But don´t forget to set `usewkwebview` to the correct value if you need a shared session.

## Hostname switching

> iOS only now

**:warning: This is just useful as a workaround for a webkit bug and may break anytime!**

You should avoid this method, since it reloads the webview as well. But it can be a workaround for this [webkit bug](https://bugs.webkit.org/show_bug.cgi?id=200857), which prevents apps running in Ionic webview from using cookies. Handle with care since it might affect your applications security and stability.

The [Ionic webview plugin](https://github.com/ionic-team/cordova-plugin-ionic-webview) runs on a custom scheme. The default scheme is `ionic://localhost`, which can be changed at buildtime by setting `<preference name="Hostname" value="app" />` in config.xml.

If you need to change the hostname at runtime (for example for CORS issues for domains that can be configured in the app), this plugins offers the `setHostname(name)` method.

If you change the hostname like this `WebviewSwitch.setHostname('myserver.com')`, the app will reload and run with the origin `ionic://myserver.com`. This will treat HTTP requests to `myserver.com` as same-origin in current iOS.

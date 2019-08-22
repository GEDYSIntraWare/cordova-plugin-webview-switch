#import <Cordova/CDV.h>
#import <Cordova/NSDictionary+CordovaPreferences.h>
#import <objc/runtime.h>

@interface CDVViewController()
- (void)createGapView; //Internal funtion in Cordova controller which creates app view with webview
@end

@interface WebviewSwitch : CDVPlugin {

}

@property (nonnull,retain) CDVViewController* mainview;
@end

@implementation WebviewSwitch

- (void) reloadWebview{
        [self.mainview.webView removeFromSuperview];
        @try {
            [self.mainview createGapView];
            [self.mainview viewDidLoad];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
        }
        @finally {
            [self.mainview.view bringSubviewToFront:self.mainview.webView];
        }
}

- (void) pluginInitialize {
    self.mainview = (CDVViewController*)self.viewController;
    
    //TODO check available webviews?
}

- (void) load:(CDVInvokedUrlCommand*)command {
    NSString *value = [command argumentAtIndex:0
                                   withDefault:@"CDVUIWebViewEngine"
                                      andClass:[NSString class]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Switching webview!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [self.mainview.settings setCordovaSetting:value forKey:@"CordovaWebViewEngine"];
    [self reloadWebview];
}

- (void) setHostname:(CDVInvokedUrlCommand*)command {
    NSString *value = [command argumentAtIndex:0
                                   withDefault:@"localhost"
                                      andClass:[NSString class]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Switching webview!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [self.mainview.settings setCordovaSetting:value forKey:@"Hostname"];
    [self reloadWebview];
}
@end

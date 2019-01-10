#import <Cordova/CDV.h>
#import <Cordova/NSDictionary+CordovaPreferences.h>
#import <objc/runtime.h>

@interface CDVViewController()
- (void)createGapView;
@end

@interface WebviewSwitch : CDVPlugin {

}

@property (nonnull,retain) CDVViewController* mainview;
@end

@implementation WebviewSwitch

- (void) loadWebview:(NSString*)name{
        [self.mainview.settings setCordovaSetting:name forKey:@"CordovaWebViewEngine"];
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
    
    // TODO check available webviews?
}

// Load data from URL
- (void) load:(CDVInvokedUrlCommand*)command {
    NSString *value = [command argumentAtIndex:0
                                   withDefault:@"CDVUIWebViewEngine"
                                      andClass:[NSString class]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Switching webview!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [self loadWebview:value];
}
@end

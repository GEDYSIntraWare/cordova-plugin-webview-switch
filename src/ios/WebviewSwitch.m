#import <Cordova/CDV.h>
#import <Cordova/NSDictionary+CordovaPreferences.h>
#import <objc/runtime.h>

@interface CDVViewController()
- (void)createGapView;
@end

@interface WebviewSwitch : CDVPlugin {

}

@property (nonatomic,retain) NSUserDefaults *userDefaults;
@end

@implementation WebviewSwitch

@synthesize userDefaults = _userDefaults;

- (void) loadWebview:(NSString*)name{
        CDVViewController* mainview = (CDVViewController*)self.viewController;
        [mainview.settings setCordovaSetting:name forKey:@"CordovaWebViewEngine"];
        [mainview.webView removeFromSuperview];
        //mainview.webViewEngine = nil;
        @try {
            [mainview createGapView];
            [mainview viewDidLoad];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
        }
        @finally {
            [mainview.view bringSubviewToFront:mainview.webView];
        }
}

- (void) pluginInitialize {
    // TODO check webviews?
    // TODO load saved, latest
    self.userDefaults = [[NSUserDefaults alloc] init];
}

// Load data from URL
- (void) load:(CDVInvokedUrlCommand*)command {
    NSString *value = [command argumentAtIndex:0
                                   withDefault:@"CDVUIWebViewEngine"
                                      andClass:[NSString class]];
    [self.userDefaults setValue:value forKey:@"WebViewSwitch"];
    [self.userDefaults synchronize];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Switching webview!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [self loadWebview:value];
}
@end

#import <Cordova/CDV.h>
#import <Cordova/NSDictionary+CordovaPreferences.h>
#import <objc/runtime.h>

@interface CDVViewController()
- (void)createGapView;
@end

@interface WebviewSwitch : CDVPlugin {

}

@property (nonatomic,retain) NSUserDefaults *userDefaults;
@property (nonnull,retain) CDVViewController* mainview;
@end

@implementation WebviewSwitch

@synthesize userDefaults = _userDefaults;

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

- (void) loadDefaultWebview {
    NSString *defaultWebview = [self.userDefaults stringForKey:@"WebViewSwitch"];
    NSLog(@"WebviewSwitch: Load default webview %@", defaultWebview);
    if (NSClassFromString(defaultWebview) &&
        ![self.webViewEngine isKindOfClass: NSClassFromString(defaultWebview)]) {
        [self loadWebview:defaultWebview];
    }
}

- (void) pluginInitialize {
    self.mainview = (CDVViewController*)self.viewController;
    self.userDefaults = [[NSUserDefaults alloc] init];
    
    // load saved
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDefaultWebview) name:CDVPageDidLoadNotification object:nil];
    
    // TODO check available webviews?
}

// Load data from URL
- (void) load:(CDVInvokedUrlCommand*)command {
    NSString *value = [command argumentAtIndex:0
                                   withDefault:@"CDVUIWebViewEngine"
                                      andClass:[NSString class]];
    //TODO add option to disable save
    [self.userDefaults setValue:value forKey:@"WebViewSwitch"];
    [self.userDefaults synchronize];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Switching webview!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [self loadWebview:value];
}
@end

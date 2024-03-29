#import "AppDelegate.h"

#import "BBPreloader.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "BBAddressService.h"
#import "BBServerService.h"
#import "BBUserService.h"

@import GoogleMaps;

@interface AppDelegate ()

@property (strong, nonatomic) BBPreloader *preloader;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  self.window.backgroundColor = [UIColor whiteColor];
  self.preloader = [[BBPreloader alloc] initWithWindow:self.window];

  [Fabric with:@[[Crashlytics class]]];

  [GMSServices provideAPIKey:[[BBAddressService sharedService] currentApiKeyMap]];

  return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
  NSString *tokenUser = [[BBUserService sharedService] tokenUser];
  if (tokenUser) {
    [[BBServerService sharedService] updateDeviceTokenWithApiToken:tokenUser deviceToken:devToken completion:^(BBServerResponse *response, NSError *error) {
    }];
  }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

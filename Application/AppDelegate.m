//
//  AppDelegate.m
//  JustForYou
//
//  Created by Антон on 19.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

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
    
    if ([[BBUserService sharedService] currentUser]) {
        [self _addPushNotification];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    self.preloader = [[BBPreloader alloc] initWithWindow:self.window];
    
    [Fabric with:@[[Crashlytics class]]];
    
    [GMSServices provideAPIKey:[[BBAddressService sharedService] currentApiKeyMap]];
    
    return YES;
}

- (void)_addPushNotification {
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];

    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    const void *devTokenBytes = [devToken bytes];
    NSString *token = [NSString stringWithUTF8String:devTokenBytes];
    [[BBServerService sharedService] updateDeviceTokenWithApiToken:[[BBUserService sharedService] tokenUser] deviceToken:token completion:^(BBServerResponse *response, NSError *error) {
        NSLog(@"Response token = %lu", (unsigned long)response.responseCode);
    }];

}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
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

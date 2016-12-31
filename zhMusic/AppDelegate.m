//
//  AppDelegate.m
//  zhMusic
//
//  Created by 张淏 on 16/12/19.
//  Copyright © 2016年 张淏. All rights reserved.
//

#import "AppDelegate.h"
#import <JPFPSStatus.h>
#import "ZHTabBarVC.h"
#import "ZHMiniPlayView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [ZHTabBarVC new];
    [self.window makeKeyAndVisible];
    
    [self addWallpaper];
    [self addMiniPlay];
    
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
    
    return YES;
}
- (void)addWallpaper {
    UIImageView *wallpaper = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"62BC0675B3DBFAE88F630BA0B82F25D8.jpg"]];
    [self.window addSubview:wallpaper];
    [self.window sendSubviewToBack:wallpaper];
}
- (void)addMiniPlay {
    ZHMiniPlayView *view = [ZHMiniPlayView defaultView];
    [self.window addSubview:view];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

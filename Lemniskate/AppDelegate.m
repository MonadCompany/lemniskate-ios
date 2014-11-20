//
//  AppDelegate.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MenadCompany. All rights reserved.
//

#import "AppDelegate.h"
#import "WordCollectionsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[WordCollectionsViewController new]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

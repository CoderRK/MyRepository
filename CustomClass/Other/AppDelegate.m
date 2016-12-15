//
//  AppDelegate.m
//  CustomClass
//
//  Created by 任奎 on 15/4/15.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "AppDelegate.h"
#import "RKMainController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RKMainController *mainCtr = [[RKMainController alloc] init];
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:mainCtr];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    _window.rootViewController = navCtr;
    [_window makeKeyAndVisible];
    return YES;
}
@end

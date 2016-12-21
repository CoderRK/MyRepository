//
//  AppDelegate.m
//  CustomClass
//
//  Created by RK on 15/4/15.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "AppDelegate.h"
#import "RKMainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    RKMainViewController *mainCtr = [[RKMainViewController alloc] init];
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:mainCtr];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:0x1a2933 alpha:0.8]];
    navCtr.navigationBar.tintColor = [UIColor whiteColor];
    [navCtr.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:21],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    _window.rootViewController = navCtr;
    [_window makeKeyAndVisible];
    return YES;
}
@end

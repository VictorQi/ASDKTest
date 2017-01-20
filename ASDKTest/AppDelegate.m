//
//  AppDelegate.m
//  ASDKTest
//
//  Created by v.q on 2017/1/11.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WindowWithStatusBarUnderlay.h"
#import "Utilities.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[WindowWithStatusBarUnderlay alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *mainViewController = [[ViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mainViewController];
    navi.hidesBarsOnSwipe = YES;
    
    UITabBarController *tabbarController = [[UITabBarController alloc]init];
    [tabbarController setViewControllers:@[navi] animated:YES];
    [[UITabBar appearance] setTintColor:[UIColor darkBlueColor]];
    
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor darkBlueColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init]];

    return YES;
}

@end

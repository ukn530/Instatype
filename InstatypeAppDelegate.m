//
//  InstatypeAppDelegate.m
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "InstatypeAppDelegate.h"


@implementation InstatypeAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    _home = [[HomeViewController alloc] init];
    _explore = [[ExploreViewController alloc] init];
    _post = [[PostViewController alloc] init];
    _activity = [[ActivityViewController alloc] init];
    _profile = [[ProfileViewController alloc] init];
    
    [_home.tabBarItem setSelectedImage:[[UIImage imageNamed:@"navi_icon_home_a.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_home.tabBarItem setImage:[[UIImage imageNamed:@"navi_icon_home_g.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_explore.tabBarItem setSelectedImage:[[UIImage imageNamed:@"navi_icon_exp_a.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_explore.tabBarItem setImage:[[UIImage imageNamed:@"navi_icon_exp_g.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_post.tabBarItem setImage:[[UIImage imageNamed:@"navi_icon_post.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_activity.tabBarItem setSelectedImage:[[UIImage imageNamed:@"navi_icon_not_a.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_activity.tabBarItem setImage:[[UIImage imageNamed:@"navi_icon_not_g.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_profile.tabBarItem setSelectedImage:[[UIImage imageNamed:@"navi_icon_me_a.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [_profile.tabBarItem setImage:[[UIImage imageNamed:@"navi_icon_me_g.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [_home.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    [_explore.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    [_post.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    [_activity.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    [_profile.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    
    
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:_home];
    UINavigationController *navExplore = [[UINavigationController alloc] initWithRootViewController:_explore];
    UINavigationController *navPost = [[UINavigationController alloc] initWithRootViewController:_post];
    UINavigationController *navActivity = [[UINavigationController alloc] initWithRootViewController:_activity];
    UINavigationController *navProfile = [[UINavigationController alloc]initWithRootViewController:_profile];

    _tabBarController = [[UITabBarController alloc] init];
    
    [_tabBarController setDelegate:self];
    [_tabBarController.tabBar setFrame:CGRectMake(_tabBarController.tabBar.frame.origin.x, _tabBarController.view.frame.size.height-44, _tabBarController.tabBar.frame.size.width, 44)];
    [_tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:0.275 green:0.275 blue:0.275 alpha:1.0]];
    [_tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"navi_selectedimg.png"]];
    
    [_tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, 20)];
    
    _controllersArray = [NSArray arrayWithObjects:navHome, navExplore, navPost, navActivity, navProfile, nil];
    [_tabBarController setViewControllers:_controllersArray];
    _tabBarController.selectedIndex = 0;
    //tabBarController.tabBar.hidden = YES;
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Futura-Medium" size:18.0], NSFontAttributeName,nil]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.viewController = [[InstatypeViewController alloc] init];
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark UITabBarControllerDelegate Methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == [_controllersArray objectAtIndex:2]) {
        PostViewController *postViewController = [[PostViewController alloc] init];
        [postViewController setDelegate:self];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:postViewController];
        
        [navigationController setModalPresentationStyle:UIModalPresentationFullScreen];
        [navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [viewController presentViewController:navigationController animated:YES completion:NULL];
        
        return NO;
    }
    
    return YES;
}

- (void)closeModalView
{
    _tabBarController.selectedIndex = 0;
    [_home closeModalView];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

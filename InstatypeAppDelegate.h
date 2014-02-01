//
//  InstatypeAppDelegate.h
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostViewController.h"
#import "HomeViewController.h"
#import "ExploreViewController.h"
#import "ActivityViewController.h"
#import "ProfileViewController.h"

@class InstatypeViewController;

@interface InstatypeAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, postViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) InstatypeViewController *viewController;

@property HomeViewController *home;
@property ExploreViewController *explore;
@property PostViewController *post;
@property ActivityViewController *activity;
@property ProfileViewController *profile;

@property NSArray *controllersArray;
@property UITabBarController *tabBarController;

@end

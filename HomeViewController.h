//
//  HomeViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFeedView.h"
#import "JSONParser.h"
#import "PostViewController.h"
#import "UserDataManager.h"


@interface HomeViewController : UIViewController<postViewControllerDelegate, UIActionSheetDelegate>

@property UIScrollView *scrollView;

@property JSONParser *jsonParser;

@property int actionPostNumber;

- (void)closeModalView;

@end

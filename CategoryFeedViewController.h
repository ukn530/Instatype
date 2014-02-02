//
//  CategoryFeedViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 12/7/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFeedView.h"
#import "JSONParser.h"
#import "PostViewController.h"
#import "UserDataManager.h"


@interface CategoryFeedViewController : UIViewController<postViewControllerDelegate, UIActionSheetDelegate>

@property NSString *categoryName;

@property UIScrollView *scrollView;

@property JSONParser *jsonParser;

@property int actionPostNumber;

- (void)closeModalView;

@end
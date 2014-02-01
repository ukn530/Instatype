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


@interface HomeViewController : UIViewController<postViewControllerDelegate>

@property UIScrollView *scrollView;

@property JSONParser *jsonParser;

- (void)closeModalView;

@end

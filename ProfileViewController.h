//
//  ProfileViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONParser.h"
#import "MainFeedView.h"
#import "PostViewController.h"

@interface ProfileViewController : UIViewController<UIActionSheetDelegate>

@property UIScrollView *profScrollView;
@property JSONParser *jsonParser;
@property int actionPostNumber;
@property int postHeight;


@end

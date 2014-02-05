//
//  FollowListViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 2/5/14.
//  Copyright (c) 2014 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONParser.h"
#import "CustomUITableViewCell.h"

@interface FollowListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property JSONParser *jsonParser;
@property NSMutableArray *activityArray;

@property NSMutableDictionary *cellSizeDictionary;

@end

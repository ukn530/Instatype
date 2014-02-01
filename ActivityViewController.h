//
//  ActivityViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONParser.h"
//#import "CellActivityView.h"

@interface ActivityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property JSONParser *jsonParser;
@property NSMutableArray *activityArray;

@property NSMutableDictionary *cellSizeDictionary;

@end

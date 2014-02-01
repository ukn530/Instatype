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


@interface CategoryFeedViewController : UIViewController

@property NSString *categoryName;
@property UIScrollView *scrollView;

@property JSONParser *jsonParser;



@end
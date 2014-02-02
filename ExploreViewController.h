//
//  ExploreViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryFeedViewController.h"
#import "CustomUITableViewCell.h"

@interface ExploreViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property NSArray *sectionNameArray;
@property NSArray *categoryNameArray;
@property NSArray *hashtagsNameArray;

@property UISearchBar *searchBar;

@end

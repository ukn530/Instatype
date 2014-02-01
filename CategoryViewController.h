//
//  CategoryViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 12/2/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CategoryViewControllerDelegate <NSObject>
-(void)tapCellWithCategory:(NSString*)category;
@end

@interface CategoryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property id delegate;
@property NSString *activeCategory;

@end

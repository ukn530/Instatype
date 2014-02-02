//
//  ShareViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 11/17/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "CategoryViewController.h"
#import "UserDataManager.h"


@protocol shareViewControllerDelegate <NSObject>
-(void)closeModalView;
@end


@interface ShareViewController : UIViewController <UITextViewDelegate, CategoryViewControllerDelegate, UIActionSheetDelegate>

@property UIImage *image;
@property id delegate;

@property UIImageView *categoryIconImageView;
@property UILabel *categoryLabel;

@property NSMutableArray *snsIconArray;
@property NSMutableArray *snsLabelArray;
@property NSMutableArray *activeSNSArray;

@end

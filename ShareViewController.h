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


@protocol shareViewControllerDelegate <NSObject>
-(void)closeModalView;
@end


@interface ShareViewController : UIViewController <UITextViewDelegate, CategoryViewControllerDelegate>

@property UIImage *image;
@property id delegate;

@property UILabel *categoryLabel;

@end

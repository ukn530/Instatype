//
//  PostViewController.h
//  Instatype
//
//  Created by Uchida Tatsuya on 9/28/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingPostView.h"
#import "ToolScrollView.h"
#import "ShareViewController.h"


//Delegate for close modal
@protocol postViewControllerDelegate <NSObject>

-(void)closeModalView;

@end


@interface PostViewController : UIViewController<shareViewControllerDelegate>

@property EditingPostView *editingPostView;
@property ToolScrollView *toolScrollView;

@property NSArray *fontsArray;
@property NSMutableArray *brushColorArray;
@property NSMutableArray *bgColorArray;

@property UIImageView *iconArrowDownImageView;
@property UIImageView *BGToolImageView;//view on Tool button of BG

@property UIColor *mixedColor;



@property id delegate;



- (void)closeBtnAction:(UIButton*)sender;


@end

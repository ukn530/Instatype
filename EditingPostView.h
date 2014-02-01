//
//  EditingPostView.h
//  Instatype
//
//  Created by Uchida Tatsuya on 10/13/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditingPostView : NSObject <UITextViewDelegate>

@property UIImageView *imageView;


@property NSMutableArray *textViewArray;
@property int activeTextViewNum;

@property UIView *textToolView;
@property UIButton *textEditDoneButton;

@property UIButton *undoButton;

@property UIView *accesaryView;

@property UIButton *editButton;
@property UIButton *deleteButton;
@property UIButton *addtypeButton;

@property float scaleBefore;
@property CGPoint touchPoint;

@property NSString *selectedTool;

@property UIImageView *brushImageView;
@property NSMutableArray *brushViewArray;
@property UIColor *brushColor;


- (void)drawPartsWithView:(UIView*)view;

- (void)fontChange;
- (void)hideAllFunction;
- (void)addTextView;


@end

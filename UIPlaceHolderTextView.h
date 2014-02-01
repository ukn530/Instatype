//
//  UIPlaceHolderTextView.h
//  Instatype
//
//  Created by Uchida Tatsuya on 10/13/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
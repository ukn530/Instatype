//
//  MainFeedView.h
//  Instatype
//
//  Created by Uchida Tatsuya on 9/15/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainFeedView : NSObject

@property UIView *mainView;
@property UIViewController *vc;
//it will be a ScrollView of Feed

@property CGRect postRect;
@property int postNumber;

@property NSString *mainImageData;
@property UIImage *mainImage;
@property NSString *authorImageData;

@property NSString *authorName;
@property NSString *retypedName;
@property NSString *replyedName;
@property NSString *postTime;
@property NSMutableArray *likeNameArray;
@property NSMutableArray *retypeNameArray;
@property NSMutableArray *commentNameArray;
@property NSMutableArray *commentContentArray;


- (id)initWithView:(UIView*)view;
- (void)drawContents:(CGPoint)postPoint;

@end

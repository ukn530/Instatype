//
//  JASONParser.h
//  Instatype
//
//  Created by Uchida Tatsuya on 9/19/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataManager.h"

@interface JSONParser : NSObject

@property NSArray *feedArray;

@property NSString *authorName;
@property NSString *retypedName;
@property NSString *replyedName;
@property NSMutableArray *likeNameArray;
@property NSMutableArray *retypeNameArray;
@property NSMutableArray *commentNameArray;
@property NSMutableArray *commentContentArray;


- (void)parseJSONWithURL:(NSString*)path;

@end

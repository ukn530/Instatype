//
//  JASONParser.m
//  Instatype
//
//  Created by Uchida Tatsuya on 9/19/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser
- (id)init
{
    self = [super init];
    if (self) {
        _authorName = @"ukn";
        _retypedName = @"niiino";
        _replyedName = @"niiino";
        _likeNameArray = [[NSMutableArray alloc] init];
        _retypeNameArray = [[NSMutableArray alloc] init];
        _commentNameArray = [[NSMutableArray alloc] init];
        _commentContentArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)parseJSONWithURL:(NSString*)path{
    NSData *json_data = [NSData dataWithContentsOfFile:path];
    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:json_data options:0 error:nil];
    //_feedArray = [feedDictionary objectForKey:@"entry"];
    [[UserDataManager sharedManager] setFeedArray:[feedDictionary objectForKey:@"entry"]];
    
    if ([[[UserDataManager sharedManager] postedImageArray] count]==0) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            [array addObject:[UIImage imageNamed:@"post01.png"]];
        }
        [[UserDataManager sharedManager] setPostedImageArray:array];
        
    }
}


@end

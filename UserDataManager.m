//
//  UserDataManager.m
//  Instatype
//
//  Created by Uchida Tatsuya on 2/2/14.
//  Copyright (c) 2014 Uchida Tatsuya. All rights reserved.
//

#import "UserDataManager.h"

@implementation UserDataManager



+ (UserDataManager*)sharedManager {
    
    static UserDataManager *sharedSingleton = nil;
    if (sharedSingleton == nil) {
        sharedSingleton = [[UserDataManager alloc] initSharedInstance];
    }
    
    return sharedSingleton;
}


- (id)initSharedInstance {
    self = [super init];
    if (self) {
        //NSMutableArray *array = [NSMutableArray array];
        
        
    }
    return self;
}


- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    
    
    return nil;
}



@end

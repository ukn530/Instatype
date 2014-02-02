//
//  UserDataManager.h
//  Instatype
//
//  Created by Uchida Tatsuya on 2/2/14.
//  Copyright (c) 2014 Uchida Tatsuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataManager : NSObject


+ (UserDataManager*)sharedManager;


@property NSMutableArray *feedArray;

@property NSMutableArray *postedImageArray;

@end

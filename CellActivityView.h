//
//  CellActivityView.h
//  Instatype
//
//  Created by Uchida Tatsuya on 12/8/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellActivityView : NSObject

@property UIView *view;
@property int cellHight;

- (id)initWithView:(UIView*)view;

- (void)drawCellView;

@end

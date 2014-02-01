//
//  toolScrollView.h
//  Instatype
//
//  Created by Uchida Tatsuya on 11/9/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ToolScrollView : NSObject <UIScrollViewDelegate, UIAlertViewDelegate>

@property id vc;
@property UIView *view;
@property CGRect scrollViewRect;

@property UIScrollView *fontScrollView;
@property UIPageControl *fontPageControl;

@property NSArray *fontsArray;
@property NSMutableArray *fontLabelArray;
@property NSMutableArray *fontNameLabelArray;

@property UIScrollView *BGScrollView;
@property UIPageControl *BGPageControl;
@property NSMutableArray *bgColorArray;
@property NSMutableArray *bgButtonArray;


@property UIScrollView *brushScrollView;
@property UIPageControl *brushPageControl;
@property NSMutableArray *brushColorArray;
@property NSMutableArray *brushButtonArray;


@property NSMutableArray *sliderArray;
@property UIView *colorMixerView;

@property int currentBGPage;

@property NSMutableArray *gestureArray;
@property int BGColorButtonFlag;



- (void)drawFontScrollView;
- (void)drawBGScrollView;
- (void)drawBrushScrollView;
- (void)drawColorMixer;

@end

//
//  toolScrollView.m
//  Instatype
//
//  Created by Uchida Tatsuya on 11/9/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "ToolScrollView.h"

@implementation ToolScrollView

- (id)init
{
    self = [super init];
    if (self) {
        _currentBGPage = 0;
        
        _fontLabelArray = [NSMutableArray array];
        _fontNameLabelArray = [NSMutableArray array];
        
        _gestureArray = [NSMutableArray array];
    }
    return self;
}


- (void)drawFontScrollView
{
    //show scrollView
    _fontScrollView = [[UIScrollView alloc] initWithFrame:_scrollViewRect];
    [_fontScrollView setContentSize:CGSizeMake(([_fontsArray count]/6) * _scrollViewRect.size.width, _scrollViewRect.size.height)];
    [_fontScrollView setBackgroundColor:[UIColor colorWithRed:0.133 green:0.133 blue:0.133 alpha:1.0]];
    [_fontScrollView setShowsHorizontalScrollIndicator:NO];
    [_fontScrollView setPagingEnabled:YES];
    [_fontScrollView setDelegate:self];
    
    [_view addSubview:_fontScrollView];
    
    
    
    int horizontalNumOfFont = 3;
    int verticalNumOfFont = 2;
    int numOfFont = 0;
    int pageSize = [_fontsArray count]/(horizontalNumOfFont*verticalNumOfFont);
    //Draw Font Button and Font Label
    for (int i = 0; i < pageSize; i++) {
        for (int j = 0; j < verticalNumOfFont; j++) {
            for (int k = 0; k < horizontalNumOfFont; k++) {
                
                //Font Button
                UIButton *fontButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [fontButton setFrame:CGRectMake(i * _scrollViewRect.size.width + k * _scrollViewRect.size.width / horizontalNumOfFont, j * (_scrollViewRect.size.height - 22 ) / verticalNumOfFont, _scrollViewRect.size.width / horizontalNumOfFont, (_scrollViewRect.size.height - 22 ) / verticalNumOfFont)];
                [fontButton setTag:numOfFont];
                [fontButton addTarget:_vc action:@selector(tapFontButton:) forControlEvents:UIControlEventTouchUpInside];
                [_fontScrollView addSubview:fontButton];
                
                
                //Font Label
                NSString *fontName = @"Helvetica";
                NSString *fontNamePS = [_fontsArray objectAtIndex:numOfFont];
                int fontSize = 50;
                float baseline = 0;
                
                switch (numOfFont) {
                    case 0:
                        fontName = @"Amatic";
                        fontSize = 50;
                        baseline = -5;
                        break;
                    case 1:
                        fontName = @"Bellerose";
                        fontSize = 50;
                        baseline = -10;
                        break;
                    case 2:
                        fontName = @"helsinki";
                        fontNamePS = @"helsinki";
                        fontSize = 46;
                        baseline = 1;
                        break;
                    case 3:
                        fontName = @"Jennifer Lynne";
                        fontSize = 44;
                        baseline = 4;
                        break;
                    case 4:
                        fontName = @"Liberator";
                        fontSize = 44;
                        baseline = 4;
                        break;
                    case 5:
                        fontName = @"Wisdom Script";
                        fontSize = 42;
                        baseline = 4;
                        break;
                    case 6:
                        fontName = @"orange juice";
                        fontSize = 46;
                        baseline = 4;
                        break;
                    case 7:
                        fontName = @"Lobster";
                        fontSize = 46;
                        baseline = -2;
                        break;
                    case 8:
                        fontName = @"3dumb";
                        fontSize = 42;
                        baseline = 3;
                        break;
                    case 9:
                        fontName = @"Blackout";
                        fontSize = 40;
                        baseline = 6;
                        break;
                    case 10:
                        fontName = @"Comic Zine OT";
                        fontSize = 46;
                        baseline = 3;
                        break;
                    case 11:
                        fontName = @"Double Feature";
                        fontSize = 40;
                        baseline = 2;
                        break;
                }
                
                
                UILabel *fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * _scrollViewRect.size.width + k * _scrollViewRect.size.width / horizontalNumOfFont, j * (_scrollViewRect.size.height - 22 ) / verticalNumOfFont  + baseline, _scrollViewRect.size.width / horizontalNumOfFont, (_scrollViewRect.size.height - 33 ) / verticalNumOfFont)];
                [fontLabel setText:@"Aa"];
                [fontLabel setTextAlignment:NSTextAlignmentCenter];
                [fontLabel setFont:[UIFont fontWithName:fontNamePS size:fontSize]];
                [fontLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
                [_fontScrollView addSubview:fontLabel];
                
                
                UILabel *fontNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * _scrollViewRect.size.width + k * _scrollViewRect.size.width / horizontalNumOfFont, j * (_scrollViewRect.size.height - 22 ) / verticalNumOfFont   + 56, _scrollViewRect.size.width / horizontalNumOfFont, 22)];
                [fontNameLabel setText:fontName];
                [fontNameLabel setTextAlignment:NSTextAlignmentCenter];
                [fontNameLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:11]];
                [fontNameLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
                [_fontScrollView addSubview:fontNameLabel];
                
                
                
                [_fontLabelArray addObject:fontLabel];
                [_fontNameLabelArray addObject:fontNameLabel];
                
                numOfFont++;
            }
        }
    }
    
    //Page Control
    _fontPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollViewRect.origin.y + _scrollViewRect.size.height - 22, 320, 22)];
    [_fontPageControl setNumberOfPages:pageSize];
    [_fontPageControl setCurrentPage:0];
    [_fontPageControl setUserInteractionEnabled:YES];
    //[_fontPageControl addTarget:self action:@selector(pageControl_Tapped:) forControlEvents:UIControlEventValueChanged];
    
    [_view addSubview:_fontPageControl];
}




- (void)drawBGScrollView
{
    
    [_bgButtonArray removeAllObjects];
    [_gestureArray removeAllObjects];
    [_BGScrollView removeFromSuperview];
    [_BGPageControl removeFromSuperview];
    
    int horizontalNumOfColor = 4;
    int verticalNumOfColor = 2;
    int numOfColor = 0;
    int pageSizeOfBG = [_bgColorArray count] / 8 + 1;
    
    
    _BGScrollView = [[UIScrollView alloc] initWithFrame:_scrollViewRect];
    [_BGScrollView setBackgroundColor:[UIColor colorWithRed:0.133 green:0.133 blue:0.133 alpha:1.0]];
    [_BGScrollView setPagingEnabled:YES];
    [_BGScrollView setShowsHorizontalScrollIndicator:NO];
    [_BGScrollView setShowsVerticalScrollIndicator:NO];
    [_BGScrollView setContentSize:CGSizeMake(pageSizeOfBG * _scrollViewRect.size.width, _scrollViewRect.size.height)];
    [_BGScrollView setContentOffset:CGPointMake(_scrollViewRect.size.width*_currentBGPage, 0)];
    [_BGScrollView setDelegate:self];
    [_view addSubview:_BGScrollView];
    
    _bgButtonArray = [NSMutableArray array];

    for (int i = 0; i<pageSizeOfBG; i++) {
        for (int j = 0; j < horizontalNumOfColor; j++) {
            for (int k = 0; k < verticalNumOfColor; k++) {
                
                if (numOfColor<[_bgColorArray count]) {
                    
                    //setting of ImageView
                    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    int marginLeft;
                    if (k%2==0) {
                        marginLeft = 8;
                    } else {
                        marginLeft = 44;
                    }
                    [imageButton setFrame:CGRectMake(i * _scrollViewRect.size.width + j * (_scrollViewRect.size.width - 36) / horizontalNumOfColor + marginLeft, 21 + k * 65, 54, 54)];
                    [imageButton.layer setCornerRadius:27];
                    [imageButton setTag:numOfColor];
                    [imageButton addTarget:_vc action:@selector(tapBGButton:) forControlEvents:UIControlEventTouchUpInside];
                    [imageButton setBackgroundColor:[_bgColorArray objectAtIndex:numOfColor]];
                    [imageButton setBackgroundImage:[UIImage imageNamed:@"button_color_touch.png"] forState:UIControlStateHighlighted];
                    
                    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedHandler:)];
                    [imageButton addGestureRecognizer:gestureRecognizer];
                    [_gestureArray addObject:gestureRecognizer];
                    
                    [_BGScrollView addSubview:imageButton];
                    [_bgButtonArray addObject:imageButton];
                    
                } else if (numOfColor == [_bgColorArray count]) {
                    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    int marginLeft;
                    if (k%2==0) {
                        marginLeft = 8;
                    } else {
                        marginLeft = 44;
                    }
                    [imageButton setFrame:CGRectMake(i * _scrollViewRect.size.width + j * (_scrollViewRect.size.width - 36) / horizontalNumOfColor + marginLeft, 21 + k * 65, 54, 54)];
                    [imageButton.layer setCornerRadius:27];
                    [imageButton setTag:numOfColor];
                    [imageButton addTarget:_vc action:@selector(tapBGColorMakeButton:) forControlEvents:UIControlEventTouchUpInside];
                    [imageButton.layer setBorderWidth:1];
                    [imageButton.layer setBorderColor:[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] CGColor]];
                    [_BGScrollView addSubview:imageButton];
                    [_bgButtonArray addObject:imageButton];
                }
                
                numOfColor++;
            }
        }
    }
    
    
    //Page Control
    _BGPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollViewRect.origin.y + _scrollViewRect.size.height - 22, 320, 22)];
    
    [_BGPageControl setNumberOfPages:pageSizeOfBG];
    [_BGPageControl setCurrentPage:_currentBGPage];
    [_BGPageControl setUserInteractionEnabled:YES];
    
    [_view addSubview:_BGPageControl];
}




- (void)drawBrushScrollView
{
    
    [_brushButtonArray removeAllObjects];
    [_gestureArray removeAllObjects];
    [_brushScrollView removeFromSuperview];
    [_brushPageControl removeFromSuperview];
    
    int horizontalNumOfColor = 4;
    int verticalNumOfColor = 2;
    int numOfColor = 0;
    int pageSizeOfBG = [_brushColorArray count] / 8 + 1;
    
    
    _brushScrollView = [[UIScrollView alloc] initWithFrame:_scrollViewRect];
    [_brushScrollView setBackgroundColor:[UIColor colorWithRed:0.133 green:0.133 blue:0.133 alpha:1.0]];
    [_brushScrollView setPagingEnabled:YES];
    [_brushScrollView setShowsHorizontalScrollIndicator:NO];
    [_brushScrollView setShowsVerticalScrollIndicator:NO];
    [_brushScrollView setContentSize:CGSizeMake(pageSizeOfBG * _scrollViewRect.size.width, _scrollViewRect.size.height)];
    [_brushScrollView setContentOffset:CGPointMake(_scrollViewRect.size.width*_currentBGPage, 0)];
    [_brushScrollView setDelegate:self];
    [_view addSubview:_brushScrollView];
    
    _brushButtonArray = [NSMutableArray array];
    
    for (int i = 0; i<pageSizeOfBG; i++) {
        for (int j = 0; j < horizontalNumOfColor; j++) {
            for (int k = 0; k < verticalNumOfColor; k++) {
                
                if (numOfColor<[_brushColorArray count]) {
                    
                    //setting of ImageView
                    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    int marginLeft;
                    if (k%2==0) {
                        marginLeft = 8;
                    } else {
                        marginLeft = 44;
                    }
                    [imageButton setFrame:CGRectMake(i * _scrollViewRect.size.width + j * (_scrollViewRect.size.width - 36) / horizontalNumOfColor + marginLeft, 21 + k * 65, 54, 54)];
                    [imageButton.layer setCornerRadius:27];
                    [imageButton setTag:numOfColor];
                    [imageButton addTarget:_vc action:@selector(tapBrushButton:) forControlEvents:UIControlEventTouchUpInside];
                    [imageButton setBackgroundColor:[_brushColorArray objectAtIndex:numOfColor]];
                    [imageButton setBackgroundImage:[UIImage imageNamed:@"button_color_touch.png"] forState:UIControlStateHighlighted];
                    
                    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedHandler:)];
                    [imageButton addGestureRecognizer:gestureRecognizer];
                    [_gestureArray addObject:gestureRecognizer];
                    
                    [_brushScrollView addSubview:imageButton];
                    [_brushButtonArray addObject:imageButton];
                    
                } else if (numOfColor == [_brushColorArray count]) {
                    
                    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    int marginLeft;
                    if (k%2==0) {
                        marginLeft = 8;
                    } else {
                        marginLeft = 44;
                    }
                    [imageButton setFrame:CGRectMake(i * _scrollViewRect.size.width + j * (_scrollViewRect.size.width - 36) / horizontalNumOfColor + marginLeft, 21 + k * 65, 54, 54)];
                    [imageButton.layer setCornerRadius:27];
                    [imageButton setTag:numOfColor];
                    [imageButton addTarget:_vc action:@selector(tapBGColorMakeButton:) forControlEvents:UIControlEventTouchUpInside];
                    [imageButton.layer setBorderWidth:1];
                    [imageButton.layer setBorderColor:[[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] CGColor]];
                    [_brushScrollView addSubview:imageButton];
                    [_brushButtonArray addObject:imageButton];
                }
                
                numOfColor++;
            }
        }
    }
    
    
    //Page Control
    _brushPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollViewRect.origin.y + _scrollViewRect.size.height - 22, 320, 22)];
    
    [_brushPageControl setNumberOfPages:pageSizeOfBG];
    [_brushPageControl setCurrentPage:_currentBGPage];
    [_brushPageControl setUserInteractionEnabled:YES];
    
    [_view addSubview:_brushPageControl];
}




- (void)drawColorMixer
{
    
    //BGColorMixier
    _colorMixerView = [[UIView alloc] initWithFrame:CGRectMake(6, _scrollViewRect.origin.y + 6, _scrollViewRect.size.width - 12, _scrollViewRect.size.height - 12)];
    [_colorMixerView.layer setCornerRadius:4];
    [_colorMixerView setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
    [_view addSubview:_colorMixerView];
    [_colorMixerView setHidden:YES];
    
    //Slider Setting
    _sliderArray = [NSMutableArray array];
    
    for (int i = 0; i < 3 ; i++) {
        
        UISlider *colorSlider = [[UISlider alloc] initWithFrame:CGRectMake(14, 20 + 42 * i, 283, 10)];
        CAGradientLayer *pageGradient = [CAGradientLayer layer];
        pageGradient.frame = CGRectMake(2, -1, colorSlider.frame.size.width - 4, colorSlider.frame.size.height);
        
        switch (i) {
            case 0:
                [colorSlider setValue:0];
                pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor, nil];
                break;
                
            case 1:
                [colorSlider setValue:0];
                pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor, nil];
                break;
                
            case 2:
                [colorSlider setValue:1];
                pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor, nil];
                break;
        }
        
        [pageGradient setCornerRadius:5];
        [pageGradient setStartPoint:CGPointMake(0.0, 0.0)];
        [pageGradient setEndPoint:CGPointMake(1.0, 0.0)];
        [colorSlider.layer addSublayer:pageGradient];
        
        [colorSlider setMinimumTrackTintColor:[UIColor clearColor]];
        [colorSlider setMaximumTrackTintColor:[UIColor clearColor]];
        [colorSlider setTag:i];
        [colorSlider setMinimumValue:0];
        [colorSlider setMaximumValue:1];
        [colorSlider addTarget:_vc action:@selector(changeSliderValue:) forControlEvents:UIControlEventValueChanged];
        [_colorMixerView addSubview:colorSlider];
        
        [_sliderArray addObject:colorSlider];
    }
    
    UIImage *closeSmallImage = [UIImage imageNamed:@"icon_close_small.png"];
    UIButton *closeSmallButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeSmallButton setImage:closeSmallImage forState:UIControlStateNormal];
    [closeSmallButton setFrame:CGRectMake(102, 120, closeSmallImage.size.width, closeSmallImage.size.height)];
    [closeSmallButton addTarget:_vc action:@selector(tapCloseMixierButton:) forControlEvents:UIControlEventTouchUpInside];
    [_colorMixerView addSubview:closeSmallButton];
    
    
    UIImage *checkSmallImage = [UIImage imageNamed:@"icon_check_small.png"];
    UIButton *checkSmallButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkSmallButton setImage:checkSmallImage forState:UIControlStateNormal];
    [checkSmallButton setFrame:CGRectMake(171, 120, checkSmallImage.size.width, checkSmallImage.size.height)];
    [checkSmallButton addTarget:_vc action:@selector(tapCheckMixierButton:) forControlEvents:UIControlEventTouchUpInside];
    [_colorMixerView addSubview:checkSmallButton];
}








//change marker of PageControll when scrolled
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0&&scrollView == _fontScrollView) {
        _fontPageControl.currentPage = scrollView.contentOffset.x / pageWidth;
    }
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0&&scrollView == _BGScrollView) {
        _BGPageControl.currentPage = scrollView.contentOffset.x / pageWidth;
        _currentBGPage = _BGPageControl.currentPage;
    }
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0&&scrollView == _brushScrollView) {
        _BGPageControl.currentPage = scrollView.contentOffset.x / pageWidth;
        _currentBGPage = _BGPageControl.currentPage;
    }
}






//Delete Color when long pressed
- (void)longPressedHandler:(UIGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        for (int i = 0; i < [_gestureArray count]; i++) {
            if ([_gestureArray objectAtIndex:i] == sender) {
                _BGColorButtonFlag = i;
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Caution" message:@"Delete this color?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        [alert show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        UIButton *button = [_bgButtonArray objectAtIndex:_BGColorButtonFlag];
        [button removeFromSuperview];
        if (!_BGScrollView.hidden) {
            [_bgColorArray removeObjectAtIndex:_BGColorButtonFlag];
        } else if (!_brushScrollView.hidden) {
            [_brushColorArray removeObjectAtIndex:_BGColorButtonFlag];
        }
        
        UIButton *beforeButton = [_bgButtonArray objectAtIndex:_BGColorButtonFlag];
        
        CGRect beforeRect = beforeButton.frame;
        for (int i = _BGColorButtonFlag + 1; i < [_bgButtonArray count]; i++) {
            
            UIButton *movableButton = [_bgButtonArray objectAtIndex:i];
            CGRect movableRect = movableButton.frame;
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                [movableButton setFrame:beforeRect];
                
                
            } completion:^(BOOL finished){
                if (!_BGScrollView.hidden) {
                    [self drawBGScrollView];
                } else if (!_brushScrollView.hidden) {
                    [self drawBrushScrollView];
                }
            }];
            
            beforeRect = movableRect;
        }
        
    }
}

@end

//
//  PostViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 9/28/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "PostViewController.h"


@implementation PostViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        //number of fonts
        
        _fontsArray = [NSArray arrayWithObjects:
                       @"Amatic-Bold",
                       @"Bellerose",
                       @"helsinki",
                       @"Jennifer Lynne",
                       @"Liberator",
                       @"WisdomScriptAI",
                       @"orangejuice",
                       @"Lobster1.4",
                       @"3Dumb",
                       @"Blackout-2AM",
                       @"ComicZineOT",
                       @"DoubleFeature",
                       nil];
        
        _bgColorArray = [NSMutableArray arrayWithObjects:
                         [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1.0],
                         [UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0],
                         [UIColor colorWithRed:0.337 green:0.416 blue:0.702 alpha:1.0],
                         [UIColor colorWithRed:0.471 green:0.635 blue:0.18 alpha:1.0],
                         [UIColor colorWithRed:0.984 green:0.702 blue:0.098 alpha:1.0],
                         [UIColor colorWithRed:0.878 green:0.29 blue:0.173 alpha:1.0],
                         [UIColor colorWithRed:0.98 green:0.808 blue:0.773 alpha:1.0],
                         [UIColor colorWithRed:0.549 green:0.549 blue:0.549 alpha:1.0],
                         [UIColor colorWithRed:0.98 green:0.808 blue:0.773 alpha:1.0],
                         nil];
        
        _brushColorArray = [NSMutableArray arrayWithObjects:
                         [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1.0],
                         [UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0],
                         [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0],
                         [UIColor colorWithRed:0 green:0 blue:1 alpha:1.0],
                         [UIColor colorWithRed:1 green:0 blue:0 alpha:1.0],
                         [UIColor colorWithRed:1 green:1 blue:0 alpha:1.0],
                         [UIColor colorWithRed:1 green:0 blue:1 alpha:1.0],
                         [UIColor colorWithRed:0 green:1 blue:0 alpha:1.0],
                         [UIColor colorWithRed:0.98 green:0.808 blue:0.773 alpha:1.0],
                         nil];
        
        _mixedColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //VIEW SETTING OF POST VIEW
    //setting for Navigation Bar
    [self setTitle:@"Edit"];
    [self setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.0]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setClipsToBounds:YES];//to delete line of navigation bar
    
    UIImage *closeBtnImage = [[UIImage imageNamed:@"header_icon_close_w.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                    initWithImage:closeBtnImage style:UIBarButtonItemStyleDone
                            target:self action:@selector(closeBtnAction:)];
    
    UIImage *nextBarBtnImage = [[UIImage imageNamed:@"header_icon_arrow_right_w.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithImage:nextBarBtnImage style:UIBarButtonItemStylePlain target:self action:@selector(nextBtnAction:)];
    
    //fix crazy position of bar buttons
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, closeButton, nil] animated:NO];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, nextButton, nil] animated:NO];
    
    
    //statue bar
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES
              withAnimation:UIStatusBarAnimationFade];
    
    //background color
    [self.view setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
    
    
    
    
    
    //Draw editing post view and textview
    _editingPostView = [[EditingPostView alloc] init];
    [_editingPostView drawPartsWithView:self.view];
    if (_defaultImage) {
        [[_editingPostView imageView] setImage:_defaultImage];
    }
    
    
    //touch gesture
    UITapGestureRecognizer *gestureTap = [[UITapGestureRecognizer alloc] initWithTarget:_editingPostView action:@selector(tapTextView:)];
    UIPanGestureRecognizer *gesturePan = [[UIPanGestureRecognizer alloc] initWithTarget:_editingPostView action:@selector(panTextView:)];
    UIPinchGestureRecognizer *gesturePinch = [[UIPinchGestureRecognizer alloc] initWithTarget:_editingPostView action:@selector(pinchTextView:)];
    [[_editingPostView imageView] addGestureRecognizer:gestureTap];
    [[_editingPostView imageView] addGestureRecognizer:gesturePinch];
    [[_editingPostView imageView] addGestureRecognizer:gesturePan];
    
    
    
    

    
    //Draw tool bar
    //fundermental position of tool bar
    int numberOfTools = 3;
    int intervalTools = ([[_editingPostView imageView] frame].size.width-60) / (numberOfTools * 2);
    //left top corner of tool bar
    CGPoint toolBarPoint = CGPointMake([[_editingPostView imageView] frame].origin.x+30, [[_editingPostView imageView] frame].size.height );
    
    /*
    UIImage *addTypeButtonImage = [UIImage imageNamed:@"tool_icon_addtext.png"];
    UIButton *addTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(toolBarPoint.x + intervalTools - 22, toolBarPoint.y, 44, 44)];
    [addTypeButton setImage:addTypeButtonImage forState:UIControlStateNormal];
    [addTypeButton addTarget:self action:@selector(tapAddTypeToolButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addTypeButton];
    */
    UIImage *fontMenuButtonImage = [UIImage imageNamed:@"tool_icon_font.png"];
    UIButton *fontMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(toolBarPoint.x + intervalTools*1 - 22, toolBarPoint.y, 44, 44)];
    [fontMenuButton setImage:fontMenuButtonImage forState:UIControlStateNormal];
    [fontMenuButton addTarget:self action:@selector(tapFontToolButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fontMenuButton];
    
    UIImage *brushButtonImage = [UIImage imageNamed:@"tool_icon_brush.png"];
    UIButton *brushButton = [[UIButton alloc] initWithFrame:CGRectMake(toolBarPoint.x + intervalTools*3 - 22, toolBarPoint.y, 44, 44)];
    [brushButton setImage:brushButtonImage forState:UIControlStateNormal];
    [brushButton addTarget:self action:@selector(tapBrushToolButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:brushButton];
    
    UIButton *BGMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(toolBarPoint.x + intervalTools*5 - 22, toolBarPoint.y, 44, 44)];
    _BGToolImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    [_BGToolImageView setBackgroundColor:[_editingPostView imageView].backgroundColor];
    [_BGToolImageView setUserInteractionEnabled:NO];
    [BGMenuButton addSubview:_BGToolImageView];
    [BGMenuButton addTarget:self action:@selector(tapBGToolButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BGMenuButton];
    
    UIImage *iconArrowDownImage = [UIImage imageNamed:@"icon_triangle.png"];
    _iconArrowDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake(toolBarPoint.x + intervalTools * 1 - iconArrowDownImage.size.width/2, toolBarPoint.y + 44 - iconArrowDownImage.size.height, iconArrowDownImage.size.width, iconArrowDownImage.size.height)];
    [_iconArrowDownImageView setImage:iconArrowDownImage];
    [self.view addSubview:_iconArrowDownImageView];
    
    
    
    
    
    
    //Draw scrollView
    _toolScrollView = [[ToolScrollView alloc] init];
    [_toolScrollView setVc:self];
    [_toolScrollView setView:self.view];
    [_toolScrollView setScrollViewRect:CGRectMake(0, toolBarPoint.y + 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-toolBarPoint.y - 88)];
    
    [_toolScrollView setFontsArray:_fontsArray];
    [_toolScrollView setBrushColorArray:_brushColorArray];
    [_toolScrollView setBgColorArray:_bgColorArray];
    
    [_toolScrollView drawFontScrollView];
    
    
    [_toolScrollView drawBrushScrollView];
    [[_toolScrollView brushScrollView] setHidden:YES];
    
    [_toolScrollView drawBGScrollView];
    [[_toolScrollView BGScrollView] setHidden:YES];
    [[_toolScrollView BGPageControl] setHidden:YES];
    
    [_toolScrollView drawColorMixer];
    
}





//Show TextBox After Draw Views
- (void)viewDidAppear:(BOOL)animated{
    
    [_editingPostView addTextView];
}





//Make Text Box When Tap AddType Button
- (void)tapAddTypeToolButton:(UIButton*)sender
{
    [_editingPostView addTextView];
}



//Change Tool Scroll View
- (void)tapFontToolButton:(UIButton*)sender
{
    //Arrow
    [_iconArrowDownImageView setFrame:CGRectMake(sender.frame.origin.x + sender.frame.size.width/2 -_iconArrowDownImageView.frame.size.width/2, _iconArrowDownImageView.frame.origin.y, _iconArrowDownImageView.frame.size.width, _iconArrowDownImageView.frame.size.height)];
    
    [[_toolScrollView fontScrollView] setHidden:NO];
    [[_toolScrollView BGScrollView] setHidden:YES];
    [[_toolScrollView brushScrollView] setHidden:YES];
    [[_toolScrollView fontPageControl] setHidden:NO];
    [[_toolScrollView BGPageControl] setHidden:YES];
    [[_toolScrollView brushPageControl] setHidden:YES];
    
    //you can move textview if chose "type"
    [_editingPostView setSelectedTool:@"type"];
    
    [[_editingPostView undoButton] setHidden:YES];
}



//Change Tool Scroll View
- (void)tapBrushToolButton:(UIButton*)sender
{
    //Arrow
    [_iconArrowDownImageView setFrame:CGRectMake(sender.frame.origin.x + sender.frame.size.width/2 -_iconArrowDownImageView.frame.size.width/2, _iconArrowDownImageView.frame.origin.y, _iconArrowDownImageView.frame.size.width, _iconArrowDownImageView.frame.size.height)];
    
    [[_toolScrollView fontScrollView] setHidden:YES];
    [[_toolScrollView brushScrollView] setHidden:NO];
    [[_toolScrollView BGScrollView] setHidden:YES];
    [[_toolScrollView fontPageControl] setHidden:YES];
    [[_toolScrollView BGPageControl] setHidden:YES];
    [[_toolScrollView brushPageControl] setHidden:NO];
    
    //you can draw lines if chose "brush"
    [_editingPostView setSelectedTool:@"brush"];
    [[_editingPostView undoButton] setHidden:NO];
    
}



//Change Tool Scroll View
- (void)tapBGToolButton:(UIButton*)sender
{
    //Arrow
    [_iconArrowDownImageView setFrame:CGRectMake(sender.frame.origin.x + sender.frame.size.width/2 -_iconArrowDownImageView.frame.size.width/2, _iconArrowDownImageView.frame.origin.y, _iconArrowDownImageView.frame.size.width, _iconArrowDownImageView.frame.size.height)];
    
    [[_toolScrollView fontScrollView] setHidden:YES];
    [[_toolScrollView brushScrollView] setHidden:YES];
    [[_toolScrollView BGScrollView] setHidden:NO];
    [[_toolScrollView brushScrollView] setHidden:YES];
    [[_toolScrollView fontPageControl] setHidden:YES];
    [[_toolScrollView BGPageControl] setHidden:NO];
    [[_toolScrollView brushPageControl] setHidden:YES];
    
    
    [_editingPostView setSelectedTool:@"type"];
    [[_editingPostView undoButton] setHidden:YES];
    
}







//change Font when tap each fonts buttons
- (void)tapFontButton:(UIButton*)sender
{
    for (int i = 0; i<[[_toolScrollView fontLabelArray] count]; i++) {
        [[[_toolScrollView fontLabelArray] objectAtIndex:i] setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
        [[[_toolScrollView fontNameLabelArray] objectAtIndex:i] setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    }
    
    [[[_toolScrollView fontLabelArray] objectAtIndex:sender.tag] setTextColor:[UIColor whiteColor]];
    [[[_toolScrollView fontNameLabelArray] objectAtIndex:sender.tag] setTextColor:[UIColor whiteColor]];
    
    
    if ([_editingPostView activeTextViewNum]>=0) {
        UITextView *textView = [[_editingPostView textViewArray] objectAtIndex:[_editingPostView activeTextViewNum]];
        [textView setFont:[UIFont fontWithName:[_fontsArray objectAtIndex:sender.tag] size:textView.font.pointSize]];
        [_editingPostView fontChange];
    }
}


//change Brush Color when tap each BrushColor Buttons
- (void)tapBrushButton:(UIButton*)sender{
    
    for (int i = 0; i<[[_toolScrollView brushButtonArray] count] - 1; i++) {
        [[[[_toolScrollView brushButtonArray] objectAtIndex:i] layer] setBorderColor:[[UIColor clearColor] CGColor]];
    }
    
    [sender.layer setBorderWidth:2];
    [sender.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [[_editingPostView undoButton] setTintColor:sender.backgroundColor];
    [_editingPostView setBrushColor:sender.backgroundColor];
    
    _mixedColor = sender.backgroundColor;
}



//change BG Color when tap each BGColor Buttons
- (void)tapBGButton:(UIButton*)sender{
    
    for (int i = 0; i<[[_toolScrollView bgButtonArray] count] - 1; i++) {
        [[[[_toolScrollView bgButtonArray] objectAtIndex:i] layer] setBorderColor:[[UIColor clearColor] CGColor]];
    }
    
    [sender.layer setBorderWidth:2];
    [sender.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [[_editingPostView imageView] setImage:nil];
    [[_editingPostView imageView] setBackgroundColor:sender.backgroundColor];
    [_BGToolImageView setImage:Nil];
    [_BGToolImageView setBackgroundColor:sender.backgroundColor];
    
    
    
    //set tect color in text field
    [self changeTextColor];
    
    _mixedColor = sender.backgroundColor;
}





//Show Color Mixer
- (void)tapBGColorMakeButton:(UIButton*)sender
{
    [[_toolScrollView colorMixerView] setHidden:NO];
    [_toolScrollView setBGColorButtonFlag:sender.tag];
    [self.view bringSubviewToFront:[_toolScrollView colorMixerView]];
}

//Close Color Mixer
- (void)tapCloseMixierButton:(UIButton*)sender
{
    [[_toolScrollView colorMixerView] setHidden:YES];
}

//Done Color Mixer
- (void)tapCheckMixierButton:(UIButton*)sender
{
    
    [[_toolScrollView colorMixerView] setHidden:YES];
    if (![_toolScrollView BGScrollView].hidden) {
        [[_toolScrollView bgColorArray] addObject:_mixedColor];
        [_toolScrollView drawBGScrollView];
    }
    
    if (![_toolScrollView brushScrollView].hidden) {
        [[_toolScrollView brushColorArray] addObject:_mixedColor];
        [_toolScrollView drawBrushScrollView];
    }
    
    
}


//Change BGColor when moving slider
- (void)changeSliderValue:(id)sender
{
    UISlider *hueSlider = [[_toolScrollView sliderArray] objectAtIndex:0];
    UISlider *sarSlider = [[_toolScrollView sliderArray] objectAtIndex:1];
    UISlider *briSlider = [[_toolScrollView sliderArray] objectAtIndex:2];
    
    float hueValue = [hueSlider value];
    float sarValue = [sarSlider value];
    float briValue = [briSlider value];
    
    CAGradientLayer *pageGradient = [[sarSlider.layer sublayers] objectAtIndex:0];
    CAGradientLayer *briGradient = [[briSlider.layer sublayers] objectAtIndex:0];
    
    if (0 <= hueValue && hueValue < 0.166) {
        pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:briValue green:briValue blue:briValue alpha:1.0].CGColor, (id)[UIColor colorWithRed:briValue green:hueValue * 6 * briValue blue:0.0 alpha:1.0].CGColor, nil];
        briGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1 green:(1-(hueValue-0) * 6)*(1-sarValue)+(hueValue-0)*6 blue:1 - sarValue alpha:1.0].CGColor, nil];
    } else if (0.166 <= hueValue && hueValue < 0.333) {
        pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:briValue green:briValue blue:briValue alpha:1.0].CGColor, (id)[UIColor colorWithRed:1 * briValue - (hueValue - 0.166) * 6 green:briValue blue:0.0 alpha:1.0].CGColor, nil];
        briGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1 - (hueValue - 0.166) * 6+(hueValue - 0.166) * 6 * (1-sarValue) green:1 blue:1 - sarValue alpha:1.0].CGColor, nil];
    } else if (0.333 <= hueValue && hueValue < 0.5) {
        pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:briValue green:briValue blue:briValue alpha:1.0].CGColor, (id)[UIColor colorWithRed:0 green:briValue blue:(hueValue - 0.333) * 6 * briValue alpha:1.0].CGColor, nil];
        briGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1 - sarValue green:1 blue:(1-(hueValue-0.333) * 6)*(1-sarValue)+(hueValue-0.333)*6 alpha:1.0].CGColor, nil];
    } else if (0.5 <= hueValue && hueValue < 0.666) {
        pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:briValue green:briValue blue:briValue alpha:1.0].CGColor, (id)[UIColor colorWithRed:0 green:1 * briValue - (hueValue - 0.5) * 6 blue:briValue alpha:1.0].CGColor, nil];
        briGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1 - sarValue green:1 - (hueValue - 0.5) * 6+(hueValue - 0.5) * 6 * (1-sarValue) blue:1 alpha:1.0].CGColor, nil];
    } else if (0.666 <= hueValue && hueValue < 0.833) {
        pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:briValue green:briValue blue:briValue alpha:1.0].CGColor, (id)[UIColor colorWithRed:(hueValue - 0.666) * 6 * briValue green:0 blue:briValue alpha:1.0].CGColor, nil];
        briGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:(1-(hueValue-0.666) * 6)*(1-sarValue)+(hueValue-0.666)*6 green:1 - sarValue blue:1 alpha:1.0].CGColor, nil];
    } else if (0.833 <= hueValue && hueValue <= 1) {
        pageGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:briValue green:briValue blue:briValue alpha:1.0].CGColor, (id)[UIColor colorWithRed:briValue green:0 blue:1 * briValue - (hueValue - 0.833) * 6 alpha:1.0].CGColor, nil];
        briGradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:1 green:1 - sarValue blue:1 - (hueValue - 0.833) * 6+(hueValue - 0.833) * 6 * (1-sarValue) alpha:1.0].CGColor, nil];
    }
    
    //convert CGColor to UIColor
    CGColorRef color = (__bridge CGColorRef)([briGradient.colors objectAtIndex:1]);
    int numComponents = CGColorGetNumberOfComponents(color);
    
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        CGFloat alpha = components[3];
        
        _mixedColor = [UIColor colorWithRed:red*briValue green:green*briValue blue:blue*briValue alpha:alpha];
    }
    if (![_toolScrollView BGScrollView].hidden) {
        [[_editingPostView imageView] setImage:nil];
        [[_editingPostView imageView] setBackgroundColor:_mixedColor];
    }
    
    if (![_toolScrollView brushScrollView].hidden) {
        [[_editingPostView undoButton] setTintColor:_mixedColor];
        [_editingPostView setBrushColor:_mixedColor];
    }
    
    [self changeTextColor];
}



- (void)changeTextColor
{
    UIColor *color = [[_editingPostView imageView] backgroundColor];
    
    int numComponents = CGColorGetNumberOfComponents(color.CGColor);
    int grayLevel = 0;
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        grayLevel = red + green + blue;
        
    }
    
    UIColor *textColor = [UIColor blackColor];
    if (grayLevel > 1) {
        textColor = [UIColor blackColor];
    } else {
        textColor = [UIColor whiteColor];
    }
    
    for (int i = 0; i < [[_editingPostView textViewArray] count]; i++) {
        [[[_editingPostView textViewArray] objectAtIndex:i] setTextColor:textColor];
    }
}



//To UIImage from UIView
- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}





- (void)nextBtnAction:(UIButton*)sender
{
    [_editingPostView hideAllFunction];
    
    //Next ViewController
    ShareViewController *shareViewController = [[ShareViewController alloc] init];
    [shareViewController setImage:[self imageWithView:[_editingPostView imageView]]];
    [shareViewController setDelegate:self];
    
    [self.navigationController pushViewController:shareViewController animated:YES];
}


- (void)closeBtnAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO
              withAnimation:UIStatusBarAnimationFade];
}

- (void)closeModalView
{
    [_delegate closeModalView];
    
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:NO
              withAnimation:UIStatusBarAnimationFade];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

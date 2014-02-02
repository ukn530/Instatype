//
//  ShareViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 11/17/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        _snsIconArray = [NSMutableArray array];
        _snsLabelArray = [NSMutableArray array];
        _activeSNSArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //VIEW SETTING OF POST VIEW
    //setting for Navigation Bar
    [self setTitle:@"Share"];
    [self setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setClipsToBounds:YES];//to delete line of navigation bar
    
    UIImage *closeBtnImage = [[UIImage imageNamed:@"header_icon_arrow_left_w.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                    initWithImage:closeBtnImage style:UIBarButtonItemStyleDone
                                    target:self action:@selector(tapBackBtn:)];
    
    //fix crazy position of bar buttons
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, closeButton, nil] animated:NO];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.0]];
    
    
    //setting comment form
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(-1, 10, 322, 136)];
    [commentView setBackgroundColor:[UIColor whiteColor]];
    [commentView.layer setBorderColor:[[UIColor colorWithRed:0.863 green:0.863 blue:0.863 alpha:1.0] CGColor]];
    [commentView.layer setBorderWidth:1.0];
    [self.view addSubview:commentView];
    
    UIPlaceHolderTextView *commentTextView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(6, 20, 164, 116)];
    [commentTextView setPlaceholder:@"#HashTags"];
    [commentTextView setFont:[UIFont systemFontOfSize:16]];
    [commentTextView setKeyboardType:UIKeyboardTypeDefault];
    [commentTextView setReturnKeyType:UIReturnKeyDone];
    [commentTextView setDelegate:self];
    [self.view addSubview:commentTextView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(194, 10, 116, 116)];
    [imageView setImage:_image];
    [commentView addSubview:imageView];
    
    
    //setting category button
    UIButton *categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryButton setFrame:CGRectMake(-1, commentView.frame.origin.y + commentView.frame.size.height + 10, 322, 44)];
    [categoryButton.layer setBorderColor:[[UIColor colorWithRed:0.863 green:0.863 blue:0.863 alpha:1.0] CGColor]];
    [categoryButton.layer setBorderWidth:1.0];
    [categoryButton setBackgroundColor:[UIColor whiteColor]];
    [categoryButton addTarget:self action:@selector(tapCategoryButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *categoryIconImage = [UIImage imageNamed:@"icon_category.png"];
    _categoryIconImageView = [[UIImageView alloc] initWithImage:categoryIconImage];
    [categoryButton addSubview:_categoryIconImageView];
    UIImage *arrowRightIconImage = [UIImage imageNamed:@"icon_arrow_button.png"];
    UIImageView *arrowRightIconImageView = [[UIImageView alloc] initWithImage:arrowRightIconImage];
    [arrowRightIconImageView setFrame:CGRectMake(categoryButton.frame.size.width-arrowRightIconImage.size.width, 0, arrowRightIconImage.size.width, arrowRightIconImage.size.height)];
    [categoryButton addSubview:arrowRightIconImageView];
    
    _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 1, 200, 43)];
    [_categoryLabel setText:@"Add a category"];
    [_categoryLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:14]];
    [_categoryLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    [_categoryLabel setBackgroundColor:[UIColor clearColor]];
    [categoryButton addSubview:_categoryLabel];

    [self.view addSubview:categoryButton];
    
    
    //setting sns button
    int tag = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 2; j++) {
            UIButton *snsButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [snsButton setFrame:CGRectMake(-1 + 160 * j, categoryButton.frame.origin.y + categoryButton.frame.size.height + 10 + 44 * i, 161, 45)];
            [snsButton.layer setBorderColor:[[UIColor colorWithRed:0.863 green:0.863 blue:0.863 alpha:1.0] CGColor]];
            [snsButton.layer setBorderWidth:1.0];
            [snsButton setBackgroundColor:[UIColor whiteColor]];
            [snsButton setTag:tag];
            [snsButton addTarget:self action:@selector(tapSNSButton:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *iconString;
            NSString *labelString;
            switch (tag) {
                case 0:
                    iconString = @"icon_twitter.png";
                    labelString = @"Twitter";
                    break;
                case 1:
                    iconString = @"icon_facebook.png";
                    labelString = @"Facebook";
                    break;
                case 2:
                    iconString = @"icon_tumblr.png";
                    labelString = @"Tumblr";
                    break;
                case 3:
                    iconString = @"icon_instagram.png";
                    labelString = @"Instagram";
                    break;
                case 4:
                    iconString = @"icon_library.png";
                    labelString = @"Camera Roll";
                    break;
            }
            
            tag++;
            
            UIImage *snsIconImage = [UIImage imageNamed:iconString];
            UIImageView *snsIconImageView = [[UIImageView alloc] initWithImage:snsIconImage];
            [snsIconImageView setUserInteractionEnabled:NO];
            [snsButton addSubview:snsIconImageView];
            [_snsIconArray addObject:snsIconImageView];
            
            UILabel *snsLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 100, 44)];
            [snsLabel setText:labelString];
            [snsLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:14]];
            [snsLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
            [snsLabel setBackgroundColor:[UIColor clearColor]];
            [snsLabel setUserInteractionEnabled:NO];
            [snsButton addSubview:snsLabel];
            [_snsLabelArray addObject:snsLabel];
            
            [self.view addSubview:snsButton];
            NSNumber *active = [NSNumber numberWithBool:NO];
            [_activeSNSArray addObject:active];
        }
    }
    
    UIImage *doneImage = [UIImage imageNamed:@"button_done.png"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    [doneButton setFrame:CGRectMake(11, categoryButton.frame.origin.y + 198, doneImage.size.width, doneImage.size.height)];
    [doneButton addTarget:self action:@selector(tapPostBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange) range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        textView.text = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        [textView resignFirstResponder];
    }
    
    return YES;
}


- (void)tapCategoryButton:(UIButton*)sender
{
    if ([_categoryLabel.text isEqualToString:@"Add a category"]) {
        [self addCategory];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
        [actionSheet setDelegate:self];
        [actionSheet addButtonWithTitle:@"Remove category"];
        [actionSheet addButtonWithTitle:@"Select new category"];
        [actionSheet addButtonWithTitle:@"Cancel"];
        [actionSheet setCancelButtonIndex:2];
        [actionSheet setDestructiveButtonIndex:0];
        [actionSheet showInView:self.view.window];
    }
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [_categoryLabel setText:@"Add a category"];
            [_categoryLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
            [_categoryIconImageView setImage:[UIImage imageNamed:@"icon_category.png"]];
            break;
        case 1:
            [self addCategory];
            break;
        case 2:
            break;
    }
    
}

- (void)addCategory
{
    //Next ViewController
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
    [categoryViewController setDelegate:self];
    [categoryViewController setActiveCategory:_categoryLabel.text];
    [self.navigationController pushViewController:categoryViewController animated:YES];
    
}

- (void)tapCellWithCategory:(NSString *)category
{
    [_categoryLabel setText:category];
    [_categoryLabel setTextColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    [_categoryIconImageView setImage:[UIImage imageNamed:@"icon_category_on.png"]];
}

- (void)tapSNSButton:(UIButton*)sender
{
    
    UIImageView *imageView = [_snsIconArray objectAtIndex:sender.tag];
    UILabel *label = [_snsLabelArray objectAtIndex:sender.tag];
    NSNumber *active = [_activeSNSArray objectAtIndex:sender.tag];
    
    NSString *iconString;
    UIColor *color;
    
    if (active.boolValue) {
        switch (sender.tag) {
            case 0:
                iconString = @"icon_twitter.png";
                break;
            case 1:
                iconString = @"icon_facebook.png";
                break;
            case 2:
                iconString = @"icon_tumblr.png";
                break;
            case 3:
                iconString = @"icon_instagram.png";
                break;
            case 4:
                iconString = @"icon_library.png";
                break;
        }
        color = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        [_activeSNSArray replaceObjectAtIndex:sender.tag withObject:[NSNumber numberWithBool:NO]];
    } else {
        switch (sender.tag) {
            case 0:
                iconString = @"icon_twitter_on.png";
                break;
            case 1:
                iconString = @"icon_facebook_on.png";
                break;
            case 2:
                iconString = @"icon_tumblr_on.png";
                break;
            case 3:
                iconString = @"icon_instagram_on.png";
                break;
            case 4:
                iconString = @"icon_library_on.png";
                break;
        }
        color = [UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0];
        [_activeSNSArray replaceObjectAtIndex:sender.tag withObject:[NSNumber numberWithBool:YES]];
    }
    
    [imageView setImage:[UIImage imageNamed:iconString]];
    [label setTextColor:color];
    
}

- (void)tapPostBtn:(UIButton*)sender
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sample@2x" ofType:@"png"];
    NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(_image)];
    [imageData writeToFile:path atomically:YES];
    
    NSMutableArray *imageArray = [[UserDataManager sharedManager] postedImageArray];
    [imageArray insertObject:_image atIndex:0];
    [[UserDataManager sharedManager] setPostedImageArray:imageArray];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    [_delegate closeModalView];
}

- (void)tapBackBtn:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

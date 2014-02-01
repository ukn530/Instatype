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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setting for Navigation Bar
    self.title = @"Share";
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(tapPostBtn:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.0]];
    
    
    //setting comment form
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(-1, 62, 322, 150)];
    [commentView setBackgroundColor:[UIColor whiteColor]];
    [commentView.layer setBorderColor:[[UIColor colorWithRed:0.863 green:0.863 blue:0.863 alpha:1.0] CGColor]];
    [commentView.layer setBorderWidth:1.0];
    [self.view addSubview:commentView];
    
    UIPlaceHolderTextView *commentTextView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(8, 72, 164, 116)];
    [commentTextView setPlaceholder:@"Add a caption"];
    [commentTextView setFont:[UIFont systemFontOfSize:16]];
    [commentTextView setKeyboardType:UIKeyboardTypeDefault];
    [commentTextView setReturnKeyType:UIReturnKeyDone];
    [commentTextView setDelegate:self];
    [self.view addSubview:commentTextView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(188, 18, 116, 116)];
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
    UIImageView *categoryIconImageView = [[UIImageView alloc] initWithImage:categoryIconImage];
    [categoryButton addSubview:categoryIconImageView];
    UIImage *arrowRightIconImage = [UIImage imageNamed:@"icon_arrow_right.png"];
    UIImageView *arrowRightIconImageView = [[UIImageView alloc] initWithImage:arrowRightIconImage];
    [arrowRightIconImageView setFrame:CGRectMake(categoryButton.frame.size.width-arrowRightIconImage.size.width, 0, arrowRightIconImage.size.width, arrowRightIconImage.size.height)];
    [categoryButton addSubview:arrowRightIconImageView];
    
    _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(categoryIconImageView.frame.size.width, 1, 200, 43)];
    [_categoryLabel setText:@"Add a category"];
    [_categoryLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
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
                    iconString = @"icon_cameraroll.png";
                    labelString = @"Camera Roll";
                    break;
            }
            
            tag++;
            
            UIImage *snsIconImage = [UIImage imageNamed:iconString];
            UIImageView *snsIconImageView = [[UIImageView alloc] initWithImage:snsIconImage];
            [snsButton addSubview:snsIconImageView];
            
            UILabel *snsLabel = [[UILabel alloc] initWithFrame:CGRectMake(snsIconImageView.frame.size.width, 0, 100, 44)];
            [snsLabel setText:labelString];
            [snsLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
            [snsLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
            [snsLabel setBackgroundColor:[UIColor clearColor]];
            [snsButton addSubview:snsLabel];
            
            [self.view addSubview:snsButton];
        }
    }
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
    
    //Next ViewController
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
    [categoryViewController setDelegate:self];
    [self.navigationController pushViewController:categoryViewController animated:YES];
}

- (void)tapCellWithCategory:(NSString *)category
{
    [_categoryLabel setText:category];
}

- (void)tapSNSButton:(UIButton*)sender
{
    NSLog(@"tapSNSButton");
}

- (void)tapPostBtn:(UIButton*)sender
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sample@2x" ofType:@"png"];
    NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(_image)];
    [imageData writeToFile:path atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    [_delegate closeModalView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  CategoryViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 12/2/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

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
    [self setTitle:@"Category"];
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
    
    
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.0]];
    CGRect screen = [[UIScreen mainScreen] bounds];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setRowHeight:44];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomUITableViewCell *cell = [[CustomUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    [cell.textLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:14]];
    [cell setTintColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"Feeling"];
            [cell.imageView setImage:[UIImage imageNamed:@"icon_category_feeling.png"]];
            break;
        case 1:
            [cell.textLabel setText:@"Question"];
            [cell.imageView setImage:[UIImage imageNamed:@"icon_category_question.png"]];
            break;
        case 2:
            [cell.textLabel setText:@"Joke"];
            [cell.imageView setImage:[UIImage imageNamed:@"icon_category_joke.png"]];
            break;
        case 3:
            [cell.textLabel setText:@"Poem"];
            [cell.imageView setImage:[UIImage imageNamed:@"icon_category_poem.png"]];
            break;
        case 4:
            [cell.textLabel setText:@"Quote"];
            [cell.imageView setImage:[UIImage imageNamed:@"icon_category_quote.png"]];
            break;
        case 5:
            [cell.textLabel setText:@"Other"];
            [cell.imageView setImage:[UIImage imageNamed:@"icon_category_other.png"]];
            break;
    }
    
    if ([cell.textLabel.text isEqualToString:_activeCategory]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [cell.textLabel setTextColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self popVCwithCategory:@"Feeling"];
            break;
        case 1:
            [self popVCwithCategory:@"Question"];
            break;
        case 2:
            [self popVCwithCategory:@"Joke"];
            break;
        case 3:
            [self popVCwithCategory:@"Poem"];
            break;
        case 4:
            [self popVCwithCategory:@"Quote"];
            break;
        case 5:
            [self popVCwithCategory:@"Other"];
            break;
    }
}


- (void)popVCwithCategory:(NSString*)string
{
    [self.navigationController popViewControllerAnimated:YES];
    [_delegate tapCellWithCategory:string];
}


- (void)tapBackBtn:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

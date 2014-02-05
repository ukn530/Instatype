//
//  FollowListViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 2/5/14.
//  Copyright (c) 2014 Uchida Tatsuya. All rights reserved.
//

#import "FollowListViewController.h"

@interface FollowListViewController ()

@end

@implementation FollowListViewController


- (id)init
{
    if(( self = [super init] )){
		self.title = @"Followers";
        
        _cellSizeDictionary = [NSMutableDictionary dictionary];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    
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
    
    /*
     _jsonParser = [[JSONParser alloc] init];
     
     NSString *path = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"txt"];
     [_jsonParser parseJSONWithURL:path];
     */
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setRowHeight:44];
    [tableView setAllowsSelection:NO];
    
    [self.view addSubview:tableView];
}

//Number of Row in Each Section.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


//Name of Row
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"Cell";
    CustomUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[CustomUITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        //[cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 45, 0, 0)];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"icon_user.png"]];
    
    [cell.textLabel setText:@"niiino"];
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(214, 5, 100, 33)];
    [button setImage:[UIImage imageNamed:@"button_follow_small.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapFollowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    
    
    return cell;
}


- (void)tapFollowBtn:(UIButton*)sender
{
    [sender setImage:[UIImage imageNamed:@"button_following_small.png"] forState:UIControlStateNormal];
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

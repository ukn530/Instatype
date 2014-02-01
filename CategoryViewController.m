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
    self.title = @"Category";
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.0]];
    CGRect screen = [[UIScreen mainScreen] bounds];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setRowHeight:44];
    [self.view addSubview:tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"Poem"];
            break;
        case 1:
            [cell.textLabel setText:@"Life"];
            break;
        case 2:
            [cell.textLabel setText:@"Quote"];
            break;
        case 3:
            [cell.textLabel setText:@"Love"];
            break;
        case 4:
            [cell.textLabel setText:@"Fun"];
            break;
        case 5:
            [cell.textLabel setText:@"Other"];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self popVCwithCategory:@"Poem"];
            break;
        case 1:
            [self popVCwithCategory:@"Life"];
            break;
        case 2:
            [self popVCwithCategory:@"Quote"];
            break;
        case 3:
            [self popVCwithCategory:@"Love"];
            break;
        case 4:
            [self popVCwithCategory:@"Fun"];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

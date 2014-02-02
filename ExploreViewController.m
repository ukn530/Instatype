//
//  ExploreViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "ExploreViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ExploreViewController ()

@end

@implementation ExploreViewController

- (id)init
{
    if(( self = [super init] )){
        
        //Names of Sections
        _sectionNameArray = [NSArray arrayWithObjects:@"CATEGORIES", @"HASH TAGS", nil];
        _categoryNameArray = [NSArray arrayWithObjects:@"Feeling", @"Question", @"Joke", @"Poem", @"Quote", @"Other", nil];
        _hashtagsNameArray = [NSArray arrayWithObjects:@"#Swim", @"#Saying", @"#IWanna", @"#Hot", @"#YouKnow", @"#WTF", nil];
	}
    
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self setTitle:@"Explore"];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height) style:UITableViewStyleGrouped];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setBackgroundColor:[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.0]];
    [tableView setRowHeight:44];
    
    _searchBar = [[UISearchBar alloc] init];
    [_searchBar setDelegate:self];
    [_searchBar setBarTintColor:[UIColor clearColor]];
    [_searchBar setPlaceholder:@"User Name or Hash tag"];
    [self.navigationItem setTitleView:_searchBar];
    
    self.view = tableView;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *myLabel = [[UILabel alloc] init];
    if (section==0) {
        [myLabel setFrame:CGRectMake(6, 34, 320, 20)];
    } else {
        [myLabel setFrame:CGRectMake(6, 14, 320, 20)];
        
    }
    [myLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:14]];
    [myLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    [myLabel setText:[self tableView:tableView titleForHeaderInSection:section]];
    [myLabel sizeToFit];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

//Number of Section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_sectionNameArray count];
}


//Name of Section
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [_sectionNameArray objectAtIndex:section];
}


//Number of Row in Each Section.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_categoryNameArray count];
    } else {
        return 3;
    }
}


//Name of Row
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"Cell";
    CustomUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[CustomUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //[cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if (indexPath.section == 0) {
        [[cell textLabel] setText:[_categoryNameArray objectAtIndex:indexPath.row]];
        [[cell textLabel] setFont:[UIFont fontWithName:@"Futura-Medium" size:14]];
        [[cell textLabel] setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
        switch (indexPath.row) {
            case 0:
                [cell.imageView setImage:[UIImage imageNamed:@"icon_category_feeling.png"]];
                break;
            case 1:
                [cell.imageView setImage:[UIImage imageNamed:@"icon_category_question.png"]];
                break;
            case 2:
                [cell.imageView setImage:[UIImage imageNamed:@"icon_category_joke.png"]];
                break;
            case 3:
                [cell.imageView setImage:[UIImage imageNamed:@"icon_category_poem.png"]];
                break;
            case 4:
                [cell.imageView setImage:[UIImage imageNamed:@"icon_category_quote.png"]];
                break;
            case 5:
                [cell.imageView setImage:[UIImage imageNamed:@"icon_category_other.png"]];
                break;
        }
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 45, 0, 0)];
    } else {
        UIButton *tagButtonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagButtonLeft setFrame:CGRectMake(0, 0, 160, 44)];
        [tagButtonLeft setTitle:[_hashtagsNameArray objectAtIndex:indexPath.row*2] forState:UIControlStateNormal];
        [tagButtonLeft setTag:indexPath.row*2];
        [tagButtonLeft setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:UIControlStateNormal];
        [tagButtonLeft setTitleColor:[UIColor colorWithRed:0.2 green:0.4 blue:0.4 alpha:1.0] forState:UIControlStateHighlighted];
        [tagButtonLeft.titleLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:14]];
        [tagButtonLeft addTarget:self action:@selector(tapTagButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:tagButtonLeft];
        
        UIButton *tagButtonRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagButtonRight setFrame:CGRectMake(160, 0, 160, 44)];
        [tagButtonRight setTitle:[_hashtagsNameArray objectAtIndex:indexPath.row*2+1] forState:UIControlStateNormal];
        [tagButtonRight setTag:indexPath.row*2+1];
        [tagButtonRight setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:UIControlStateNormal];
        [tagButtonRight setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:UIControlStateHighlighted];
        [tagButtonRight.titleLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:14]];
        [tagButtonRight addTarget:self action:@selector(tapTagButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:tagButtonRight];
        
        //border left
        CALayer *leftBorder = [CALayer layer];
        leftBorder.frame = CGRectMake(0, 0, 0.5, tagButtonRight.frame.size.height);
        leftBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                         alpha:1.0f].CGColor;
        [tagButtonRight.layer addSublayer:leftBorder];
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    return cell;
}

//When tap a row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self pushVCWithCategory:[_categoryNameArray objectAtIndex:indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

- (void)tapTagButton:(UIButton*)sender
{
    int tag = [sender tag];
    [self pushVCWithCategory:[_hashtagsNameArray objectAtIndex:tag]];
}

- (void)pushVCWithCategory:(NSString*)categoryName
{
    
    [_searchBar resignFirstResponder];
    [_searchBar setShowsCancelButton:NO];
    
    
    
    CategoryFeedViewController *categoryFeedViewController = [[CategoryFeedViewController alloc] init];
    [categoryFeedViewController setCategoryName:categoryName];
    [self.navigationController pushViewController:categoryFeedViewController animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    [searchBar setShowsCancelButton:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end

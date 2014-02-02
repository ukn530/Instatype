//
//  ActivityViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (id)init
{
    if(( self = [super init] )){
		self.title = @"Activity";
        
        _cellSizeDictionary = [NSMutableDictionary dictionary];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    /*
    _jsonParser = [[JSONParser alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"txt"];
    [_jsonParser parseJSONWithURL:path];
    */
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setRowHeight:52];
    
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
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"icon_user.png"]];
    
    NSDictionary *stringAttributes1 = @{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:14] };
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"ukn" attributes:stringAttributes1];
    NSDictionary *stringAttributes2 = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0f] };
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@" liked your post" attributes:stringAttributes2];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    [mutableAttributedString appendAttributedString:string1];
    [mutableAttributedString appendAttributedString:string2];
    [cell.textLabel setAttributedText:mutableAttributedString];
    
    //[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    [cell.detailTextLabel setText:@"1 day ago"];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width-44, 0, 44, 44)];
    [imageView setImage:[UIImage imageNamed:@"post01.png"]];
    [cell addSubview:imageView];
    
    //CellActivityView *cellActivityView = [[CellActivityView alloc] initWithView:cell];
    //[cellActivityView drawCellView];
    
    
    //NSNumber *height = [NSNumber numberWithInt:[cellActivityView cellHight]];
    //NSNumber *key = [NSNumber numberWithInt:indexPath.row];
    //[_cellSizeDictionary setObject:height forKey:key];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *contentsString = [@"ukn" stringByAppendingString:@" liked your type"];
    
    CGRect textViewRect = [contentsString boundingRectWithSize:CGSizeMake(200, 200)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:12]}
                                               context:nil];
    CGSize contentsSize = textViewRect.size;
    
    int height = 44;
    if (contentsSize.height + 28 > height) {
        height = contentsSize.height + 28;
    }
    
    return height;
}


//When tap a row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    /*
    if (indexPath.section == 0) {
        [self pushVCWithCategory:[_categoryNameArray objectAtIndex:indexPath.row]];
    }
     */
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
     
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

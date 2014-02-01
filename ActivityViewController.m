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
    
    _jsonParser = [[JSONParser alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"txt"];
    [_jsonParser parseJSONWithURL:path];
    
    
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
    return [[_jsonParser feedArray] count];
}


//Name of Row
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    //CellActivityView *cellActivityView = [[CellActivityView alloc] initWithView:cell];
    //[cellActivityView drawCellView];
    
    
    //NSNumber *height = [NSNumber numberWithInt:[cellActivityView cellHight]];
    //NSNumber *key = [NSNumber numberWithInt:indexPath.row];
    //[_cellSizeDictionary setObject:height forKey:key];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *contentsString = [@"ukn" stringByAppendingString:@"liked your type"];
    
    CGRect textViewRect = [contentsString boundingRectWithSize:CGSizeMake(200, 200)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:12]}
                                               context:nil];
    CGSize contentsSize = textViewRect.size;
    
    int height = 52;
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

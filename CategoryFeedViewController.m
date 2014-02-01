//
//  CategoryFeedViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 12/7/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "CategoryFeedViewController.h"

@interface CategoryFeedViewController ()

@end

@implementation CategoryFeedViewController

- (id)init
{
    self = [super init];
    if (self) {
        _jsonParser = [[JSONParser alloc] init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _categoryName;
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    
    CGRect screen = [[self view] bounds];
    
    //ScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:screen];
    [_scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]]];
    self.view = _scrollView;
    
    [self loadFeed];
}

- (void)loadFeed
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"txt"];
    [_jsonParser parseJSONWithURL:path];
    
    CGRect screen = [[self view] bounds];
    int postHeight =44;
    
    //show latest or popular button
    NSArray *arr = [NSArray arrayWithObjects:@"Latest", @"Popular", nil];
    UISegmentedControl *arrangeButton = [[UISegmentedControl alloc] initWithItems:arr];
    [arrangeButton setFrame:CGRectMake(7, 7, 306, 30)];
    //[arrangeButton setSegmentedControlStyle:UISegmentedControlStyleBezeled];
    [arrangeButton setSelectedSegmentIndex:0];
    [arrangeButton setTintColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    //[arrangeButton addTarget:self action:@selector(tapController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:arrangeButton];
    
    //take JSON data to HomeFeedView
    for (int i = 0; i < [[_jsonParser feedArray] count]; i++) {
        id feedContent = [[_jsonParser feedArray] objectAtIndex:i];
        
        //get JSON data from _jasonParser
        NSString *mainImageData = [feedContent objectForKey:@"typeImage"];
        NSString *authorImageData = [[feedContent objectForKey:@"author"] objectForKey:@"authorImage"];
        NSString *authorName = [[feedContent objectForKey:@"author"] objectForKey:@"authorName"];
        NSString *retypedName = [[feedContent objectForKey:@"retyped"] objectForKey:@"retypedName"];
        NSMutableArray *likeNameArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < [[feedContent objectForKey:@"like"] count]; j++) {
            [likeNameArray addObject:[[[feedContent objectForKey:@"like"] objectAtIndex:j] objectForKey:@"likeName"]];
        }
        NSMutableArray *retypeNameArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < [[feedContent objectForKey:@"retype"] count]; j++) {
            [retypeNameArray addObject:[[[feedContent objectForKey:@"retype"] objectAtIndex:j] objectForKey:@"retypeName"]];
        }
        NSMutableArray *commentNameArray = [[NSMutableArray alloc] init];
        NSMutableArray *commentContentArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < [[feedContent objectForKey:@"comment"] count]; j++) {
            [commentNameArray addObject:[[[feedContent objectForKey:@"comment"] objectAtIndex:j] objectForKey:@"commentName"]];
            [commentContentArray addObject:[[[feedContent objectForKey:@"comment"] objectAtIndex:j] objectForKey:@"commentContent"]];
        }
        
        CGPoint postPoint = CGPointMake(0, postHeight);
        
        MainFeedView *mainFeedView = [[MainFeedView alloc] initWithView:_scrollView];
        [mainFeedView setMainImageData:mainImageData];
        [mainFeedView setAuthorName:authorName];
        [mainFeedView setAuthorImageData:authorImageData];
        [mainFeedView setRetypedName:retypedName];
        [mainFeedView setLikeNameArray:likeNameArray];
        [mainFeedView setRetypeNameArray:retypeNameArray];
        [mainFeedView setCommentNameArray:commentNameArray];
        [mainFeedView setCommentContentArray:commentContentArray];
        
        [mainFeedView drawContents:postPoint];
        postHeight += [mainFeedView postRect].size.height;
        
        [likeNameArray removeAllObjects];
        [retypeNameArray removeAllObjects];
        [commentNameArray removeAllObjects];
        [commentContentArray removeAllObjects];
    }
    //Extend ScrollView
    _scrollView.contentSize = CGSizeMake(screen.size.width, postHeight);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

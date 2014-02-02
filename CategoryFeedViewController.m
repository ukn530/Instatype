//
//  CategoryFeedViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 12/7/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "CategoryFeedViewController.h"

@implementation CategoryFeedViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _categoryName;
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    
    
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
    
    
    
    CGRect screen = [[self view] bounds];
    
    //ScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:screen];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    self.view = _scrollView;
    
    [self loadFeed];
}

- (void)loadFeed
{
    
    
    CGRect screen = [[self view] bounds];
    int postHeight =44;
    
    //show latest or popular button
    NSArray *arr = [NSArray arrayWithObjects:@"Latest", @"Popular", nil];
    UISegmentedControl *arrangeButton = [[UISegmentedControl alloc] initWithItems:arr];
    [arrangeButton setFrame:CGRectMake(7, 7, 306, 30)];
    [arrangeButton setSelectedSegmentIndex:0];
    [arrangeButton setTintColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    //[arrangeButton addTarget:self action:@selector(tapController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:arrangeButton];
    
    
    _jsonParser = [[JSONParser alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"txt"];
    [_jsonParser parseJSONWithURL:path];
    
    
    //take JSON data to HomeFeedView
    for (int i = 0; i < [[[UserDataManager sharedManager] feedArray] count]; i++) {
        id feedContent = [[[UserDataManager sharedManager] feedArray] objectAtIndex:i];
        
        //get JSON data from _jasonParser
        NSString *mainImageData = [feedContent objectForKey:@"typeImage"];
        NSString *authorImageData = [[feedContent objectForKey:@"author"] objectForKey:@"authorImage"];
        NSString *authorName = [[feedContent objectForKey:@"author"] objectForKey:@"authorName"];
        NSString *retypedName = [[feedContent objectForKey:@"retyped"] objectForKey:@"retypedName"];
        NSString *replyedName = [[feedContent objectForKey:@"replyed"] objectForKey:@"replyedName"];
        NSString *postTime = [feedContent objectForKey:@"postDate"];
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
        
        CGPoint postPoint = CGPointMake(6, postHeight);
        
        MainFeedView *mainFeedView = [[MainFeedView alloc] initWithView:_scrollView];
        [mainFeedView setVc:self];
        [mainFeedView setMainImageData:mainImageData];
        
        //This is for user test
        [mainFeedView setMainImage:[[[UserDataManager sharedManager] postedImageArray] objectAtIndex:i]];
        
        [mainFeedView setAuthorName:authorName];
        [mainFeedView setAuthorImageData:authorImageData];
        [mainFeedView setRetypedName:retypedName];
        [mainFeedView setReplyedName:replyedName];
        [mainFeedView setPostTime:postTime];
        [mainFeedView setLikeNameArray:likeNameArray];
        [mainFeedView setRetypeNameArray:retypeNameArray];
        [mainFeedView setCommentNameArray:commentNameArray];
        [mainFeedView setCommentContentArray:commentContentArray];
        [mainFeedView setPostNumber:i];
        
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



- (void)tapReplyBtn:(UIButton*)sender
{
    _actionPostNumber = sender.tag;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setDelegate:self];
    [actionSheet addButtonWithTitle:@"Reply on this image"];
    [actionSheet addButtonWithTitle:@"Reply on a new image"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:2];
    [actionSheet showInView:self.view.window];
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self openPostModal:[[[UserDataManager sharedManager] postedImageArray] objectAtIndex:_actionPostNumber]];
            break;
        case 1:
            [self openPostModal];
            break;
        case 2:
            break;
    }
    
}

- (void)tapRetweetBtn:(UIButton*)sender
{
    [sender setImage:[UIImage imageNamed:@"action_icon_retweet_a.png"] forState:UIControlStateNormal];
}

- (void)tapLikeBtn:(UIButton*)sender
{
    [sender setImage:[UIImage imageNamed:@"action_icon_like_a.png"] forState:UIControlStateNormal];
    
}

-(void)tapOtherBtn:(UIButton*)sender
{
    
}


- (void)openPostModal:(UIImage*)image
{
    PostViewController *postViewController = [[PostViewController alloc] init];
    [postViewController setDelegate:self];
    [postViewController setDefaultImage:image];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:postViewController];
    
    [navigationController setModalPresentationStyle:UIModalPresentationFullScreen];
    [navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)openPostModal
{
    PostViewController *postViewController = [[PostViewController alloc] init];
    [postViewController setDelegate:self];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:postViewController];
    
    [navigationController setModalPresentationStyle:UIModalPresentationFullScreen];
    [navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)closeModalView
{
    for (UIView* subview in self.view.subviews) {
        [subview removeFromSuperview];
    }
    
    [self loadFeed];
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

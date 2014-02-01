//
//  HomeViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "HomeViewController.h"
#define NumberOfContents 10


@implementation HomeViewController

- (id)init
{
    if( self = [super init] ){
        
        
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //NavigationBar
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_logo.png"]];
    self.navigationItem.titleView = titleImageView;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0];
    /*
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    */
    //status bar
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarStyle:UIStatusBarStyleLightContent];
    
    

    CGRect screen = [[self view] bounds];
    
    //ScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:screen];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    self.view = _scrollView;
    
    [self loadFeed];
}

- (void)loadFeed
{
    
    _jsonParser = [[JSONParser alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"txt"];
    [_jsonParser parseJSONWithURL:path];
    
    
    CGRect screen = [[self view] bounds];
    int postHeight = 6;
    
    //take JSON data to HomeFeedView
    for (int i = 0; i < [[_jsonParser feedArray] count]; i++) {
        id feedContent = [[_jsonParser feedArray] objectAtIndex:i];
        
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
        [mainFeedView setMainImageData:mainImageData];
        [mainFeedView setAuthorName:authorName];
        [mainFeedView setAuthorImageData:authorImageData];
        [mainFeedView setRetypedName:retypedName];
        [mainFeedView setReplyedName:replyedName];
        [mainFeedView setPostTime:postTime];
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


//Open ModalView:PostViewController
- (void)btnAction:(UIButton*)sender
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
    
    NSLog(@"viewDidLoad HomeViewController");
    [self loadFeed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

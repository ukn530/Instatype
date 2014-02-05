//
//  ProfileViewController.m
//  Instatype
//
//  Created by Uchida Tatsuya on 8/18/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)init
{
    if(( self = [super init] )){
		self.title = @"Profile";
        _leftTabActive = YES;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.388 green:0.741 blue:0.447 alpha:1.0]];
    
    UIImage *settingBarBtnImage = [[UIImage imageNamed:@"header_icon_setting.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithImage:settingBarBtnImage style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnAction:)];
    //fix crazy position of bar buttons
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, settingButton, nil] animated:NO];
    
    
    _profScrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_profScrollView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
    [_profScrollView setContentSize:CGSizeMake(320, 1000)];
    self.view = _profScrollView;
    
    
    
    UIImage *iconProfBigImage = [UIImage imageNamed:@"icon_prof_big.png"];
    UIImageView *iconProfBigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 16, 67, 67)];
    [iconProfBigImageView setImage:iconProfBigImage];
    [_profScrollView addSubview:iconProfBigImageView];
    
    UIImage *lineProfImage = [UIImage imageNamed:@"line_prof.png"];
    UIImageView *lineProfImageView = [[UIImageView alloc] initWithFrame:CGRectMake(93, 24, 1, 50)];
    [lineProfImageView setImage:lineProfImage];
    [_profScrollView addSubview:lineProfImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(106, 16, 214, 20)];
    [nameLabel setText:@"TatsuyaUchida"];
    [nameLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [_profScrollView addSubview:nameLabel];
    
    UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(106, 38, 214, 20)];
    [placeLabel setText:@"Tokyo"];
    [placeLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    [placeLabel setFont:[UIFont systemFontOfSize:12]];
    [_profScrollView addSubview:placeLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(106, 60, 204, 20)];
    [descriptionLabel setText:@"I'm a web designer in Japan."];
    [descriptionLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    [descriptionLabel setFont:[UIFont systemFontOfSize:12]];
    [descriptionLabel setNumberOfLines:0];
    [descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [descriptionLabel sizeToFit];
    [_profScrollView addSubview:descriptionLabel];
    
    
    NSString *numberString;
    NSString *followString;
    for (int i = 0; i < 2; i++) {
        if (i==0) {
            numberString = @"524";
            followString = @" Followers";
        } else {
            numberString = @"245";
            followString = @" Following";
        }
        NSDictionary *stringAttributes1 = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13] };
        NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:numberString attributes:stringAttributes1];
        NSDictionary *stringAttributes2 = @{NSFontAttributeName : [UIFont fontWithName:@"Futura-Medium" size:11] };
        NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:followString attributes:stringAttributes2];
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
        [mutableAttributedString appendAttributedString:string1];
        [mutableAttributedString appendAttributedString:string2];
        
        
        UILabel *followLabel = [[UILabel alloc] initWithFrame:CGRectMake(106 + 100 * i, descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + 2, 100, 20)];
        [followLabel setAttributedText:mutableAttributedString];
        [followLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
        [followLabel setUserInteractionEnabled:YES];
        [_profScrollView addSubview:followLabel];
        
        if (i==0) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFollowersBtn:)];
            [followLabel addGestureRecognizer:tap];
        } else {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFollowingBtn:)];
            [followLabel addGestureRecognizer:tap];
        }
    }
    
    
    
    
    UIImage *followButtonImage = [UIImage imageNamed:@"button_follow_big.png"];
    UIButton *followButton = [[UIButton alloc] initWithFrame:CGRectMake(12, descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + 34, 296, 36)];
    [followButton setImage:followButtonImage forState:UIControlStateNormal];
    [followButton addTarget:self action:@selector(tapFollowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_profScrollView addSubview:followButton];
    
    
    
    
    
    _tabLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, followButton.frame.origin.y + followButton.frame.size.height + 16, 155, 34)];
    [_tabLeft setImage:[UIImage imageNamed:@"button_tab_w.png"] forState:UIControlStateNormal];
    [_tabLeft addTarget:self action:@selector(tapLeftTab:) forControlEvents:UIControlEventTouchUpInside];
    [_profScrollView addSubview:_tabLeft];
    
    _tabRight = [[UIButton alloc] initWithFrame:CGRectMake(165, followButton.frame.origin.y + followButton.frame.size.height + 16, 155, 34)];
    [_tabRight setImage:[UIImage imageNamed:@"button_tab_g.png"] forState:UIControlStateNormal];
    [_tabRight addTarget:self action:@selector(tapRightTab:) forControlEvents:UIControlEventTouchUpInside];
    [_profScrollView addSubview:_tabRight];
    
    
    for (int i = 0; i < 2; i++) {
        if (i==0) {
            numberString = @"234";
            followString = @" POSTS";
        } else {
            numberString = @"6350";
            followString = @" LIKES";
        }
        NSDictionary *stringAttributes1 = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:14] };
        NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:numberString attributes:stringAttributes1];
        NSDictionary *stringAttributes2 = @{NSFontAttributeName : [UIFont fontWithName:@"Futura-Medium" size:10] };
        NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:followString attributes:stringAttributes2];
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
        [mutableAttributedString appendAttributedString:string1];
        [mutableAttributedString appendAttributedString:string2];
        
        UILabel *tabLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 + 165 * i, _tabLeft.frame.origin.y + 7, 155, 20)];
        [tabLabel setAttributedText:mutableAttributedString];
        [tabLabel setTextAlignment:NSTextAlignmentCenter];
        [tabLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
        [_profScrollView addSubview:tabLabel];
    }
    
    
    _postHeight = _tabRight.frame.origin.y + _tabRight.frame.size.height;
    [self loadFeed];
}



- (void)loadFeed
{
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _postHeight, 320, _profScrollView.contentSize.height - _postHeight)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [_profScrollView addSubview:bgView];
    
    CGRect screen = [[self view] bounds];
    
    
    _jsonParser = [[JSONParser alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feed" ofType:@"txt"];
    [_jsonParser parseJSONWithURL:path];
    
    _postHeight += 6;
    
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
        
        CGPoint postPoint = CGPointMake(6, _postHeight);
        
        MainFeedView *mainFeedView = [[MainFeedView alloc] initWithView:_profScrollView];
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
        _postHeight += [mainFeedView postRect].size.height;
        
        [likeNameArray removeAllObjects];
        [retypeNameArray removeAllObjects];
        [commentNameArray removeAllObjects];
        [commentContentArray removeAllObjects];
    }
    //Extend ScrollView
    _profScrollView.contentSize = CGSizeMake(screen.size.width, _postHeight);
    [bgView setFrame:CGRectMake(0, bgView.frame.origin.y, 320, _postHeight)];
}



- (void)tapReplyBtn:(UIButton*)sender
{
    _actionPostNumber = sender.tag;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setTag:0];
    [actionSheet setDelegate:self];
    [actionSheet addButtonWithTitle:@"Reply on this image"];
    [actionSheet addButtonWithTitle:@"Reply on a new image"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:2];
    [actionSheet showInView:self.view.window];
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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setTag:1];
    [actionSheet setDelegate:self];
    [actionSheet addButtonWithTitle:@"Report this post"];
    [actionSheet addButtonWithTitle:@"Share this post"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet setCancelButtonIndex:2];
    [actionSheet showInView:self.view.window];
}


-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 0) {
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
    } else if(actionSheet.tag == 1) {
        UIAlertView *reportAlert = [[UIAlertView alloc] init];
        [reportAlert setMessage:@"Are your sure you want to report this post?"];
        [reportAlert setCancelButtonIndex:0];
        [reportAlert addButtonWithTitle:@"Cancel"];
        [reportAlert addButtonWithTitle:@"Report"];
        
        
        UIActionSheet *shareActionSheet = [[UIActionSheet alloc] init];
        [shareActionSheet setTag:2];
        [shareActionSheet setDelegate:self];
        [shareActionSheet addButtonWithTitle:@"Share on Twitter"];
        [shareActionSheet addButtonWithTitle:@"Share on Facebook"];
        [shareActionSheet addButtonWithTitle:@"Share on Tumblr"];
        [shareActionSheet addButtonWithTitle:@"Share on Instagram"];
        [shareActionSheet addButtonWithTitle:@"Cancel"];
        [shareActionSheet setCancelButtonIndex:4];
        
        switch (buttonIndex) {
            case 0:
                [reportAlert show];
                break;
            case 1:
                [shareActionSheet showInView:self.view.window];
                break;
            case 2:
                break;
        }
    }
    
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





- (void)tapLeftTab:(UIButton*)sender
{
    if (!_leftTabActive) {
        [sender setImage:[UIImage imageNamed:@"button_tab_w.png"] forState:UIControlStateNormal];
        [_tabRight setImage:[UIImage imageNamed:@"button_tab_g.png"] forState:UIControlStateNormal];
        _leftTabActive = YES;
    }
}

- (void)tapRightTab:(UIButton*)sender
{
    if (_leftTabActive) {
        [sender setImage:[UIImage imageNamed:@"button_tab_w.png"] forState:UIControlStateNormal];
        [_tabLeft setImage:[UIImage imageNamed:@"button_tab_g.png"] forState:UIControlStateNormal];
        _leftTabActive = NO;
    }
}


- (void)tapFollowersBtn:(UIGestureRecognizer*)sender
{
    FollowListViewController *followListViewController = [[FollowListViewController alloc] init];
    [self.navigationController pushViewController:followListViewController animated:YES];
}

- (void)tapFollowingBtn:(UIGestureRecognizer*)sender
{
    FollowListViewController *followListViewController = [[FollowListViewController alloc] init];
    [self.navigationController pushViewController:followListViewController animated:YES];
}


- (void)settingBtnAction:(UIButton*)sender
{
    
}

- (void)tapFollowBtn:(UIButton*)sender
{
    UIImage *followingButtonImage = [UIImage imageNamed:@"button_following_big.png"];
    [sender setImage:followingButtonImage forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

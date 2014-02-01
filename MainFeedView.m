//
//  MainFeedView.m
//  Instatype
//
//  Created by Uchida Tatsuya on 9/15/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "MainFeedView.h"

@implementation MainFeedView

- (id)initWithView:(UIView*)view
{
    self = [super init];
    if (self) {
        _mainView = view;
    }
    return self;
}




- (void)drawContents:(CGPoint)postPoint
{
    
    CGRect screen = [_mainView bounds];
    
    //Profile Icon
    CGRect profIconRect = CGRectMake(postPoint.x+2, postPoint.y, 32, 32);
    UIImage *profImage = [UIImage imageNamed:_authorImageData];
    UIImageView *profImageView = [[UIImageView alloc] initWithImage:profImage];
    [profImageView setFrame:profIconRect];
    [_mainView addSubview:profImageView];
    
    //Main Image
    CGRect rect = CGRectMake(postPoint.x, profIconRect.origin.y + profImageView.frame.size.height+6, screen.size.width-12, screen.size.width-12);
    UIImage *mainImage = [UIImage imageNamed:_mainImageData];
    UIImageView *mainImageView = [[UIImageView alloc] initWithImage:mainImage];
    [mainImageView setFrame:rect];
    [_mainView addSubview:mainImageView];
    
    
    //Author Name and getting that size
    CGRect nameRect = [self drawName:_authorName x:46 y:profIconRect.origin.y+11];
    
    //If this post is what author retyped, this show name and retype icon.
    if ([_retypedName length]>0) {
        //Retype Icon
        [self drawIcon:3 x:50 + nameRect.size.width y:profIconRect.origin.y+10];
        //Name retyped by
        [self drawName:_retypedName x:68 + nameRect.size.width y:profIconRect.origin.y+11];
    } else if([_replyedName length]>0) {
        //Retype Icon
        [self drawIcon:4 x:50 + nameRect.size.width y:profIconRect.origin.y+10];
        //Name retyped by
        [self drawName:_replyedName x:68 + nameRect.size.width y:profIconRect.origin.y+11];
    }
    
    //time
    UILabel *timeLabel = [[UILabel alloc] init];
    [timeLabel setText:@"3m"];
    [timeLabel setTextAlignment:NSTextAlignmentRight];
    [timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [timeLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    [timeLabel sizeToFit];
    [timeLabel setFrame:CGRectMake(rect.origin.x + rect.size.width - timeLabel.frame.size.width, profIconRect.origin.y + 10, timeLabel.frame.size.width, timeLabel.frame.size.height)];
    [_mainView addSubview:timeLabel];
    
    
    //note
    UIImage *noteImage = [UIImage imageNamed:@"icon_note.png"];
    UIImageView *noteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(postPoint.x, rect.origin.y + rect.size.height, noteImage.size.width, noteImage.size.height)];
    [noteImageView setImage:noteImage];
    [_mainView addSubview:noteImageView];
    
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(noteImageView.frame.origin.x + noteImageView.frame.size.width + 2, noteImageView.frame.origin.y + 6, 0, 0)];
    [noteLabel setText:@"24"];
    [noteLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [noteLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    [noteLabel sizeToFit];
    [_mainView addSubview:noteLabel];
    
    
    //button
    UIImage *replyImage = [UIImage imageNamed:@"action_icon_reply.png"];
    UIButton *replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [replyButton setFrame:CGRectMake(rect.origin.x + rect.size.width - replyImage.size.width * 4, rect.origin.y + rect.size.height, replyImage.size.width, replyImage.size.height)];
    [replyButton setImage:replyImage forState:UIControlStateNormal];
    [_mainView addSubview:replyButton];
    
    
    UIImage *retweetImage = [UIImage imageNamed:@"action_icon_retweet.png"];
    UIImage *retweetImageA = [UIImage imageNamed:@"action_icon_retweet_a.png"];
    UIButton *retweetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [retweetButton setFrame:CGRectMake(rect.origin.x + rect.size.width - retweetImage.size.width * 3, rect.origin.y + rect.size.height, retweetImage.size.width, retweetImage.size.height)];
    [retweetButton setImage:retweetImage forState:UIControlStateNormal];
    [retweetButton setImage:retweetImageA forState:UIControlStateSelected];
    [_mainView addSubview:retweetButton];
    
    
    UIImage *likeImage = [UIImage imageNamed:@"action_icon_like.png"];
    UIImage *likeImageA = [UIImage imageNamed:@"action_icon_like_a.png"];
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton setFrame:CGRectMake(rect.origin.x + rect.size.width - likeImage.size.width * 2, rect.origin.y + rect.size.height, likeImage.size.width, likeImage.size.height)];
    [likeButton setImage:likeImage forState:UIControlStateNormal];
    [likeButton setImage:likeImageA forState:UIControlStateSelected];
    [_mainView addSubview:likeButton];
    
    
    UIImage *otherImage = [UIImage imageNamed:@"action_icon_setting.png"];
    UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherButton setFrame:CGRectMake(rect.origin.x + rect.size.width - otherImage.size.width, rect.origin.y + rect.size.height, otherImage.size.width, otherImage.size.height)];
    [otherButton setImage:otherImage forState:UIControlStateNormal];
    [_mainView addSubview:otherButton];

    
    
    /*
    
    //fundamental position of Like, Retype or Comment
    CGPoint activityPoint = CGPointMake(6, profIconRect.origin.y+rect.size.height+6);
    
    
    
    int likeLabelHeight = 0;
    if ([_likeNameArray count]>0) {
        //like icon
        [self drawIcon:0 x:activityPoint.x y:activityPoint.y];
        //like name
        NSMutableString *likeName = [[NSMutableString alloc] initWithString:@""];
        for (int i = 0;i<[_likeNameArray count] ; i++) {
            if (i>0) {
                [likeName appendString:@", "];
            }
            [likeName appendString:[_likeNameArray objectAtIndex:i]];
            
        }
        likeLabelHeight = [self drawName:likeName x:26 y:activityPoint.y].size.height;
    }
    
    int retypeLabelHeight = 0;
    if ([_retypeNameArray count]>0) {
        //Retype icon
        [self drawIcon:1 x:activityPoint.x y:activityPoint.y+likeLabelHeight];
        //Retype name
        NSMutableString *retypeName = [[NSMutableString alloc] initWithString:@""];
        for (int i = 0;i<[_retypeNameArray count] ; i++) {
            if (i>0) {
                [retypeName appendString:@", "];
            }
            [retypeName appendString:[_retypeNameArray objectAtIndex:i]];
            
        }
        retypeLabelHeight = [self drawName:retypeName x:26 y:activityPoint.y+likeLabelHeight].size.height;
    }
    
    int commentLabelHeight = 0;
    if ([_commentNameArray count]>0) {
        //Comment icon
        [self drawIcon:2 x:activityPoint.x y:activityPoint.y+likeLabelHeight+retypeLabelHeight];
        for (int i = 0; i < [_commentNameArray count]; i++) {
            //Comment name and content
            commentLabelHeight += [self drawCommentWithName:[_commentNameArray objectAtIndex:i] comment:[_commentContentArray objectAtIndex:i] x:26 y:activityPoint.y+likeLabelHeight+retypeLabelHeight+commentLabelHeight];
        }
    }
     
    
    //Retype Button
    [self drawButton:0 x:activityPoint.x y:activityPoint.y+likeLabelHeight+retypeLabelHeight+commentLabelHeight];
    [self drawButton:1 x:activityPoint.x+69 y:activityPoint.y+likeLabelHeight+retypeLabelHeight+commentLabelHeight];
    [self drawButton:2 x:activityPoint.x+147 y:activityPoint.y+likeLabelHeight+retypeLabelHeight+commentLabelHeight];
     
     */
    _postRect = CGRectMake(postPoint.x, postPoint.y, 320, 400);
     
    
}





//to draw an icon like, retype, comment
- (void)drawIcon:(int)iconNum x:(int)x y:(int)y
{
    UIImage *iconImage;
    
    switch (iconNum) {
        case 0:
            iconImage = [UIImage imageNamed:@"icon_like.png"];
            break;
        case 1:
            iconImage = [UIImage imageNamed:@"icon_retype.png"];
            break;
        case 2:
            iconImage = [UIImage imageNamed:@"icon_comment.png"];
            break;
        case 3:
            iconImage = [UIImage imageNamed:@"icon_retweet_small.png"];
            break;
        case 4:
            iconImage = [UIImage imageNamed:@"icon_reply_small.png"];
            break;
        default:
            break;
    }
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
    CGRect iconRect = CGRectMake(x+7-iconImage.size.width/2, y+(14-iconImage.size.height)/2, iconImage.size.width, iconImage.size.height);
    
    [iconImageView setFrame:iconRect];
    [_mainView addSubview:iconImageView];
}





//to draw name
- (CGRect)drawName:(NSString*)string x:(int)x y:(int)y
{
    CGRect nameRect = CGRectMake(x, y-1, _mainView.frame.size.width-x-7, 0);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameRect];
    [nameLabel setText:string];
    [nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [nameLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    [nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [nameLabel setNumberOfLines:0];
    [nameLabel sizeToFit];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [_mainView addSubview:nameLabel];
    
    //nameRect = nameLabel.frame;
    nameRect = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, nameLabel.frame.size.width, nameLabel.frame.size.height+4);
    
    return nameRect;
}





//to draw comment
- (int)drawCommentWithName:(NSString*)name comment:(NSString*)comment x:(int)x y:(int)y
{
    //To Change a Font of _commentName in string
    name = [name stringByAppendingString:@" "];
    NSDictionary *stringAttributes1 = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:12.f]};
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:name attributes:stringAttributes1];
    
    NSDictionary *stringAttributes2 = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:12.f]};
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:comment attributes:stringAttributes2];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    [mutableAttributedString appendAttributedString:string1];
    [mutableAttributedString appendAttributedString:string2];
    
    CGRect commentRect = CGRectMake(x, y-1, _mainView.frame.size.width-x-7, 0);
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:commentRect];
    [commentLabel setAttributedText:mutableAttributedString];
    [commentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [commentLabel setNumberOfLines:0];
    [commentLabel sizeToFit];
    [commentLabel setBackgroundColor:[UIColor clearColor]];
    
    [_mainView addSubview:commentLabel];
    
    int height = commentLabel.frame.size.height+4;
    
    return height;
}




//to draw button of like, retype, comment
- (void)drawButton:(int)buttonNum x:(int)x y:(int)y
{
    UIImage *activityButtonImage;
    UIImage *activityButtonBackgroundImage;
    NSString *activityTitle;
    
    switch (buttonNum) {
        case 0:
            activityButtonImage = [UIImage imageNamed:@"icon_like_gray.png"];
            activityButtonBackgroundImage = [UIImage imageNamed:@"button_like.png"];
            activityTitle = @"Like";
            break;
        case 1:
            activityButtonImage = [UIImage imageNamed:@"icon_retype_gray.png"];
            activityButtonBackgroundImage = [UIImage imageNamed:@"button_retype.png"];
            activityTitle = @"Retype";
            break;
        case 2:
            activityButtonImage = [UIImage imageNamed:@"icon_comment_gray.png"];
            activityButtonBackgroundImage = [UIImage imageNamed:@"button_comment.png"];
            activityTitle = @"Comment";
            break;
        default:
            break;
    }
    
    UIButton *activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [activityButton setBackgroundImage:activityButtonBackgroundImage forState:UIControlStateNormal];
    [activityButton setFrame:CGRectMake(x, y+8, activityButtonBackgroundImage.size.width, activityButtonBackgroundImage.size.height)];
    [activityButton setTitle:activityTitle forState:UIControlStateNormal];
    [activityButton setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] forState:UIControlStateNormal];
    [activityButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
    [activityButton setImage:activityButtonImage forState:UIControlStateNormal];
    [_mainView addSubview:activityButton];
}

@end

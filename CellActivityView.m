//
//  CellActivityView.m
//  Instatype
//
//  Created by Uchida Tatsuya on 12/8/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "CellActivityView.h"

@implementation CellActivityView

- (id)initWithView:(UIView*)view
{
    self = [super init];
    if (self) {
        
        _view = view;
        
    }
    return self;
}


- (void)drawCellView
{
    
    
    UIImage *profImage = [UIImage imageNamed:@"sampleProfIcon.png"];
    UIImageView *profImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 38, 38)];
    [profImageView setImage:profImage];
    [_view addSubview:profImageView];
    
    UIImage *typeImage = [UIImage imageNamed:@"sample.png"];
    UIImageView *typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_view.frame.size.width - 52, 0, 52, 52)];
    [typeImageView setImage:typeImage];
    [_view addSubview:typeImageView];
    
    _cellHight = [self drawCommentWithName:@"ukn" comment:@"liked your type" x:profImageView.frame.origin.x + profImageView.frame.size.width + 7 y:7];
    
    UILabel *pastTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(profImageView.frame.origin.x + profImageView.frame.size.width + 7, 9 + _cellHight, 200, 20)];
    [pastTimeLabel setText:@"2 hours ago"];
    [pastTimeLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.f]];
    [pastTimeLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
    [pastTimeLabel sizeToFit];
    [_view addSubview:pastTimeLabel];
    
    
    _cellHight += pastTimeLabel.frame.size.height;
    
    if (_cellHight < 52) {
        _cellHight = 52;
    }
}


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
    
    CGRect commentRect = CGRectMake(x, y, 200, 0);
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:commentRect];
    [commentLabel setAttributedText:mutableAttributedString];
    [commentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [commentLabel setNumberOfLines:0];
    [commentLabel sizeToFit];
    [commentLabel setBackgroundColor:[UIColor clearColor]];
    
    [_view addSubview:commentLabel];
    
    int height = commentLabel.frame.size.height;
    
    return height;
}


@end

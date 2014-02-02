//
//  CustomUITableViewCell.m
//  Instatype
//
//  Created by Uchida Tatsuya on 2/2/14.
//  Copyright (c) 2014 Uchida Tatsuya. All rights reserved.
//

#import "CustomUITableViewCell.h"

@implementation CustomUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect tmpFrame = self.imageView.frame;
    tmpFrame.origin.x = 6;
    self.imageView.frame = tmpFrame;
    
    tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 45;
    self.textLabel.frame = tmpFrame;
    
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = 45;
    self.detailTextLabel.frame = tmpFrame;
}


@end

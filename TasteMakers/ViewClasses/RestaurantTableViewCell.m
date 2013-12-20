//
//  RestaurantTableViewCell.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "RestaurantTableViewCell.h"

@implementation RestaurantTableViewCell
@synthesize titleLabel, descriptionLabel;
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

- (void) setTitle:(NSString *)title  andSubTitle:(NSString *)subTitle {
    titleLabel.text = title;
    descriptionLabel.text = subTitle;
    
    [descriptionLabel sizeToFit];
}

@end

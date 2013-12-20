//
//  ReviewTableViewCell.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "ReviewTableViewCell.h"

@implementation ReviewTableViewCell
@synthesize descriptionTextField, dateLabel;

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

-(void) initWithReview:(Review *)review {
    [descriptionTextField setText:review.content];
    [dateLabel setText:@"20 december 2013"];
    
}

- (CGFloat) calculateHeight {
    CGFloat numLines = descriptionTextField.contentSize.height;
    
    return numLines;
}

@end

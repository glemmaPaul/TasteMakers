//
//  ReviewTableViewCell.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface ReviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
-(void)initWithReview:(Review *) review;
-(CGFloat) calculateHeight;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

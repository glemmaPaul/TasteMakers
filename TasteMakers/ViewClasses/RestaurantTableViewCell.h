//
//  RestaurantTableViewCell.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

-(void) setTitle:(NSString *) title andSubTitle:(NSString *) subTitle;
@end

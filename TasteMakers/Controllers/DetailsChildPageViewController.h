//
//  DetailsChildPageViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface DetailsChildPageViewController : UIViewController
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) Restaurant *restaurant;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *tasteByTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *filtersTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageLabel;

@end

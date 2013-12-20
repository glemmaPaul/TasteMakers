//
//  FilterViewCell.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "FilterViewCell.h"

@interface FilterViewCell () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation FilterViewCell
@synthesize greenView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"ELO MOTO");
        [self initializer];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    
    [super setSelected:selected animated:YES];
    // Configure the view for the selected state
}

- (void)initializer {
    // create an view that is hidden on the left. its green by the way
    greenView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    greenView.backgroundColor = [[UIColor alloc] initWithRed:0 green:255 blue:0 alpha:1];
    [self insertSubview:greenView belowSubview:self.contentView];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    [_panGestureRecognizer setDelegate:self];

}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gesture {
    
    UIGestureRecognizerState state = [gesture state];
    CGPoint gestureInTableCell = [gesture translationInView:self];
// get the real center of the object that must be moved
    
    
    
        CGPoint center = {self.contentView.center.x + (gestureInTableCell.x /2), self.contentView.center.y};
        [self.contentView setCenter:center];
    
    
    if (state == UIGestureRecognizerStateEnded) {
        // check whether the greenview is crossed to the limit
        [self.contentView setCenter:self.center];
    }
}


@end

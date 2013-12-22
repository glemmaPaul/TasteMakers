//
//  ReviewsChildPageViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "ReviewsChildPageViewController.h"
#import "RestaurantDetailsManager.h"
#import "ReviewTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "CAKeyframeAnimation+AHEasing.h"
#import "UserPreferences.h"
#import "NotificationManager.h"

@interface ReviewsChildPageViewController ()

@end

@implementation ReviewsChildPageViewController
@synthesize restaurant, reviews, reviewsTableView, NewReviewOpen, TopBarViewNewReview, ViewNewReview, NewReviewTextView, animatedDistance, NewReviewSaveButton, firstReviewImage;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [reviewsTableView setDelegate:self];
    
    // get the reviews out of the restaurant object;
    restaurant = [[RestaurantDetailsManager sharedInstance] getRestaurant];
    reviews = restaurant.reviews;
    
    if ([reviews count] == 0) {
        [reviewsTableView setHidden:YES];
        [firstReviewImage setHidden:NO];
        // create a image that shows how to create a new review
        
    }
    else {
        [firstReviewImage setHidden:YES];
        [reviewsTableView setHidden:NO];
    }
    [NewReviewSaveButton setHidden:YES];
    [NewReviewSaveButton setEnabled:NO];
    
    [NewReviewTextView setDelegate:self];
    [reviewsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [reviews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReviewCell";
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Review *review = [self.reviews objectAtIndex:indexPath.row];

    [cell initWithReview:review];
    
    return cell;
}



- (IBAction)RightReviewClicked:(id)sender {
    
    CGPoint startingPoint = ViewNewReview.center;
    
    
    if (NewReviewOpen == YES) {
        [self closeNewReviewView:startingPoint];
        NewReviewOpen = NO;
    }
    else {
        [self openNewReviewView:startingPoint];
        NewReviewOpen = YES;
        
    }
}

- (void) closeNewReviewView: (CGPoint) startingPoint {
    // animate the review bar to the bottom
    
    CGPoint toTarget = ViewNewReview.center;
    toTarget.y = self.view.frame.size.height;
    toTarget.y += (ViewNewReview.frame.size.height /2);
    toTarget.y -= TopBarViewNewReview.frame.size.height;
    
    
    [self animateNewReview:startingPoint andEndPoint:toTarget];
    [self.view endEditing:YES];
    [NewReviewSaveButton setHidden:YES];

}

- (void) openNewReviewView: (CGPoint) startingPoint {
    CGPoint toTarget = ViewNewReview.center;
    
    // We have putted a 20 margin in so we can animate a snap back;
    toTarget.y = (self.view.frame.size.height - (ViewNewReview.frame.size.height /2)) + 20;
    
    [self animateNewReview:startingPoint andEndPoint:toTarget];
    [NewReviewTextView becomeFirstResponder];
    [NewReviewSaveButton setHidden:NO];
}

- (void) animateNewReview:(CGPoint) fromTarget andEndPoint:(CGPoint) toTarget {
    [CATransaction setValue:[NSNumber numberWithFloat:0.750] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *detailsViewAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                         function:ExponentialEaseOut
                                                                        fromPoint:fromTarget
                                                                          toPoint:toTarget];
    
    
    [CATransaction setCompletionBlock:^{
        //[self dismissViewControllerAnimated:YES completion:nil];
    }];
    [detailsViewAnimation setDelegate:self];
    CALayer *reviewLayer = [ViewNewReview layer];
    [reviewLayer addAnimation:detailsViewAnimation forKey:@"position"];
    
   
    [CATransaction commit];
    
    [ViewNewReview setCenter:toTarget];

}


- (IBAction)NewReviewViewPanned:(UIPanGestureRecognizer *)GesturePanRecognizer {
    // calculate the dirrefence in points between the finger and the center of the details bar
       CGPoint positionPan = [GesturePanRecognizer locationInView:self.view];
    
    if (GesturePanRecognizer.state == UIGestureRecognizerStateEnded) {
        
        
        
        
        positionPan.x = self.view.center.x;
        positionPan.y = positionPan.y + (ViewNewReview.frame.size.height / 2);
        
        
        [CATransaction begin];
        
        // calculate if the box must animate open or closed
        // wo can establish that with getting the center of the new review View
        // and check if it's lower than the height of the view
        if (ViewNewReview.center.y < self.view.frame.size.height) {
            [self openNewReviewView:positionPan];
        }
        else {
            [self closeNewReviewView:positionPan];
            
        }
        
    }
    else {
        
        //CGRect viewFrame = self.view.frame;
        CGFloat verticalPosition = positionPan.y + (TopBarViewNewReview.frame.size.height / 2) - (TopBarViewNewReview.frame.size.height /4);
        //if ((viewFrame.origin.y - positionPan.y) > (viewFrame.origin.y - (ViewNewReview.frame.origin.y - 20))) {
            // this is the snap back function
           // CGFloat verticalPosition = self.view.frame.size.height - ((ViewNewReview.frame.size.height - 20) + (20 * (viewFrame.size.height / ViewNewReview.frame.size.height)));
            
       // }
      //  else {
      //      CGFloat verticalPosition = positionPan.y;
     //   }
        
        ViewNewReview.frame = CGRectMake(self.view.frame.origin.x, verticalPosition, ViewNewReview.frame.size.width, ViewNewReview.frame.size.height);
    }
    

}
- (IBAction)saveButtonPressed:(id)sender {
    UserPreferences *_userPreferences = [UserPreferences alloc];
    Review *review = [Review alloc];
    review.content = NewReviewTextView.text;
    review.date = [NSDate date];
    review.restaurant_reference = self.restaurant.reference;
    [_userPreferences addReview:review];
    
    [self.reviews addObject:review];
    self.restaurant.reviews = self.reviews;
    [[RestaurantDetailsManager sharedInstance] setRestaurant:self.restaurant];
    
    [reviewsTableView setHidden:NO];
    [firstReviewImage setHidden:YES];
    [reviewsTableView reloadData];
    
    [self closeNewReviewView:ViewNewReview.center];
    
    // refresh the new review text view
    [NewReviewTextView setText:@""];
    
    [[NotificationManager alloc] showSuccessNotification:@"Review has been saved"];

}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect textFieldRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
    // for a strange reason the review box dissapears. Just show it again!
    [self openNewReviewView:ViewNewReview.center];
}

//Hersteld de scrollview naar originele positie
- (void)textViewDidEndEditing:(UITextView *)textView
{

    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if(NewReviewTextView.text.length > 10) {
        // to prevent from bashing and just filling up some reviews. I have added a constraint on the minimum of characters
        [NewReviewSaveButton setEnabled:YES];
    }
    else {
        [NewReviewSaveButton setEnabled:NO];
    }
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}




@end

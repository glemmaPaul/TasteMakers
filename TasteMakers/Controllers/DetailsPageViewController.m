//
//  DetailsPageViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "DetailsPageViewController.h"
#import "DetailsChildPageViewController.h"

@interface DetailsPageViewController ()

@end

@implementation DetailsPageViewController

@synthesize currentChildViews;

+ (id)sharedInstance {
    static id sharedInstance;
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[DetailsChildPageViewController alloc] init];
        return sharedInstance;
    }
}

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
	// Do any additional setup after loading the view.
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    DetailsChildPageViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [[self parentViewController] dismissViewControllerAnimated:YES completion:nil];
    
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(DetailsChildPageViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}
// its a fix that doesn't make my details page freeze.
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(DetailsChildPageViewController *)viewController index];
    
    
    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (void) animateToReviewPage {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsChildPageViewController *childPageViewController = (DetailsChildPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ReviewsView"];
    NSArray *toReviewArray = [NSArray arrayWithObjects:childPageViewController, nil];
    
    [self.pageController setViewControllers:toReviewArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}

- (DetailsChildPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    NSString *ViewIdentifier = [[NSString alloc] init];
    
    
    
    if (index == 1) {
        ViewIdentifier = @"ReviewsView";
    }
    else {
        ViewIdentifier = @"DescriptionView";
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailsChildPageViewController *childPageViewController = (DetailsChildPageViewController *)[storyboard instantiateViewControllerWithIdentifier:ViewIdentifier];
    
    
    
    
    
    
    childPageViewController.index = index;
    
    [self.currentChildViews addObject:childPageViewController];
    
    return childPageViewController;
    
}





-(void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

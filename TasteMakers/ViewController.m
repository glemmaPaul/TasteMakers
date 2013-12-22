//
//  IntroViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "ViewController.h"
#import "TasteApiCommunicator.h"
#import "RegisterUserManager.h"
#import "CAKeyframeAnimation+AHEasing.h"
#import "STTwitter.h"

@interface ViewController ()
@property (nonatomic, strong) STTwitterAPI *twitter;
@end

@implementation ViewController


@synthesize loginButton;
@synthesize friendsList;
@synthesize userPreferences, userManager, welcomeMessage, logoView, introImage;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self initAnimations];
        
    
    
	   
    [_twitter getSearchTweetsWithQuery:@"#tastemaker" geocode:nil lang:nil locale:nil resultType:nil count:@"500" until:nil sinceID:nil maxID:nil includeEntities:nil callback:nil successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
        NSLog(@"%@", statuses);
    } errorBlock:^(NSError *error) {
        //test
    }];
    
    // allocating userPreferences
    userPreferences = [[UserPreferences alloc] init];
    
    
    // setting up the user preferences class
    userManager = [[RegisterUserManager alloc] init];
    userManager.communicator = [[TasteApiCommunicator alloc] init];
    userManager.delegate = self;
    userManager.communicator.delegate = userManager;
    
    
    if (![userPreferences isUserLoggedIn]) {
        
        
        
        // show twitter button;
        [loginButton setHidden:NO];
        [welcomeMessage setHidden:YES];
        
    }
    else {
        [self performSelector:@selector(openTabBarController) withObject:nil afterDelay:2];
        
        [loginButton setHidden:YES];
        
        User *_user = [userPreferences getUserObject];
        [welcomeMessage setHidden:NO];
        [self setWelcomesMessage:_user.username];
    }
    
    
    
}

- (void) setWelcomesMessage:(NSString *) username {
    // just a fade in of the UITextLabel;
    NSString *welcomesString = [NSString stringWithFormat:@"Welcome back, \n@%@", username];
   // [ welcomesString stringByAppendingString:username];
    [welcomeMessage setText:welcomesString];
    
}

- (void) initAnimations {
    UIImage *_maskingImage = [UIImage imageNamed:@"Logo"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = logoView.bounds;
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [logoView.layer setMask:_maskingLayer];
    
    
    [logoView setCenter:CGPointMake(self.view.center.x, -logoView.frame.size.height /2)];
    
    
    [self performSelector:@selector(fillUpLogoView:) withObject:nil afterDelay:0.6f];
    
    CABasicAnimation* rotateImage =  [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    rotateImage.removedOnCompletion = FALSE;
    rotateImage.fillMode = kCAFillModeForwards;
    
    //Do a series of 5 quarter turns for a total of a 1.25 turns
    //(2PI is a full turn, so pi/2 is a quarter turn)
    [rotateImage setToValue: [NSNumber numberWithFloat: -M_PI / 2]];
    rotateImage.repeatCount = 11;
    
    rotateImage.duration = 10;
    rotateImage.beginTime = 0;
    rotateImage.cumulative = TRUE;
    rotateImage.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [introImage.layer addAnimation: rotateImage forKey: @"rotateAnimation"];
    
}

- (void) openTabBarController {
    // this functions will open the tabbarcontroller automatically
    NSLog(@"Animate");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarController = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"RootTabBar"];
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginWithTwitter:(id)sender {
      
    self.twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
    
       
    
    [loginButton  setTitle: @"myTitle" forState: UIControlStateDisabled];
    [_twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        
        [userManager registerUser:username];
        [self openTabBarController];
        
        
        
    } errorBlock:^(NSError *error) {
        
        // yes this is really rude, it's maybe not the best way to do it, but I couldn't find a better way
        self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"Sr4KF8OEnHel47Vub3T8kA"
                                                     consumerSecret:@"DsACEa8tR9qEml1HcAirCe7BmkjMVXWqktme6W3Vfhg"];
        
        
        [_twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
            NSLog(@"-- url: %@", url);
            NSLog(@"-- oauthToken: %@", oauthToken);
            
            [[UIApplication sharedApplication] openURL:url];
            
        } oauthCallback:@"tastemakers://twitter_access_tokens/"
                        errorBlock:^(NSError *error) {
                            NSLog(@"-- error: %@", error);
                           // _loginStatusLabel.text = [error localizedDescription];
            }];

    }];
    
    


    
}

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier {
    
    [_twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
        
        [userManager registerUser:screenName];
        
        [self openTabBarController];
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"-- %@", [error localizedDescription]);
    }];
}

- (void) fadeInUserName {
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void) errorDuringFetchingUser:(NSError *)error {
    NSLog(@"Error during fetching user %@", error);
}

- (void) goToMapView {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarController = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"TabBarView"];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:tabBarController animated:YES completion:nil];
    

}


- (void) fillUpLogoView:(id)itsNill {
    // create an view on the left side in the mask.. make it white
    UIView *whiteColoredView = [[UIView alloc] initWithFrame:logoView.bounds];
    whiteColoredView.backgroundColor = [[UIColor alloc] initWithRed:255 green:255 blue:255 alpha:1];
    
    CGPoint fromPoint = CGPointMake(-(logoView.frame.size.width / 2) , logoView.frame.size.height /2 );
    CGPoint toPoint = fromPoint;
    toPoint.x = logoView.frame.size.width /2;
    
    [logoView addSubview:whiteColoredView];
    
    CALayer *layer= [whiteColoredView layer];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.7f] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *whiteLogoAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                       function:ExponentialEaseInOut
                                                                      fromPoint:fromPoint
                                                                        toPoint:toPoint];
    
    [layer addAnimation:whiteLogoAnimation forKey:@"position"];
    
    [CATransaction commit];
    
    [whiteColoredView setCenter:toPoint];

}

- (void) didReceiveUser:(User *)userObject {
    [userPreferences rememberUser:userObject];
}

@end

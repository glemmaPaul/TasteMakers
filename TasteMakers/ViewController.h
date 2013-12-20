//
//  IntroViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "UserPreferences.h"
#import "RegisterUserDelegate.h"
#import "RegisterUserManager.h"
#import "UserPreferences.h"


@interface ViewController : UIViewController <RegisterUserDelegate>


@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property NSArray *friendsList;
@property (weak, nonatomic) IBOutlet UIButton *magicHappens;
@property RegisterUserManager *userManager;
@property UserPreferences *userPreferences;
@property (weak, nonatomic) IBOutlet UILabel *welcomeMessage;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIImageView *introImage;

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verfier;

@end

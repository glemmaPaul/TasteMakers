//
//  ViewAnimationDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewAnimationDelegate <NSObject>
-(void) animationOnModalViewController: (NSString *) idenitifier;
@end

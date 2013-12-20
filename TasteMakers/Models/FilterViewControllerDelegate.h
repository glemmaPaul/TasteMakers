//
//  FilterViewControllerDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 19-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FilterViewControllerDelegate <NSObject>

- (void) filterViewDismissedWithSelectedFilters:(NSMutableArray *)filters fromViewController:(UIViewController *)viewController;

@end

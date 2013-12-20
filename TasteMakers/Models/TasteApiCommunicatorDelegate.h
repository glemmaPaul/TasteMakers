//
//  TasteApiCommunicatorDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TasteApiCommunicatorDelegate <NSObject>

- (void)didReceiveData:(NSMutableDictionary *)jsonData;
- (void)fetchingError:(NSError *)error;

@end

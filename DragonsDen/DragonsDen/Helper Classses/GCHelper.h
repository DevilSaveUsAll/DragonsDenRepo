//
//  GCHelper.h
//  DragonsDen
//
//  Created by Danny on 1/8/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCHelper : NSObject {
  BOOL userAuthenticated;
}

@property (assign) BOOL gameCenterAvailable;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;

@end

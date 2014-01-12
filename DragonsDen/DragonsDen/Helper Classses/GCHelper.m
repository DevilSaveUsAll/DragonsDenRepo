//
//  GCHelper.m
//  DragonsDen
//
//  Created by Danny on 1/8/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "GCHelper.h"

@implementation GCHelper

#pragma mark Initialization

static GCHelper *sharedHelper = nil;
+ (GCHelper *) sharedInstance {
  if (!sharedHelper) {
    sharedHelper = [[GCHelper alloc] init];
  }
  return sharedHelper;
}

- (BOOL)isGameCenterAvailable {
  // check for presence of GKLocalPlayer API
  Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
  
  // check if the device is running iOS 4.1 or later
  NSString *reqSysVer = @"4.1";
  NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
  BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                         options:NSNumericSearch] != NSOrderedAscending);
  
  return (gcClass && osVersionSupported);
}

- (id)init {
  if ((self = [super init])) {
    self.gameCenterAvailable = [self isGameCenterAvailable];
    if (self.gameCenterAvailable) {
      NSNotificationCenter *nc =
      [NSNotificationCenter defaultCenter];
      [nc addObserver:self
             selector:@selector(authenticationChanged)
                 name:GKPlayerAuthenticationDidChangeNotificationName
               object:nil];
    }
  }
  return self;
}

- (void)authenticationChanged {
  
  if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
    NSLog(@"Authentication changed: player authenticated.");
    userAuthenticated = TRUE;
  } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
    NSLog(@"Authentication changed: player not authenticated");
    userAuthenticated = FALSE;
  }
}

#pragma mark User functions

- (void)authenticateLocalUser {
  
  if (!self.gameCenterAvailable) return;
  
  NSLog(@"Authenticating local user...");
  if ([GKLocalPlayer localPlayer].authenticated == NO) {
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
  } else {
    NSLog(@"Already authenticated!");
  }
  
  
}

@end
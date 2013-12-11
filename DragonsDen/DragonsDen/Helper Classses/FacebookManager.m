//
//  FacebookManager.m
//  Utopia
//
//  Created by Danny on 10/23/13.
//  Copyright (c) 2013 LVL6. All rights reserved.
//

#import "FacebookManager.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FacebookManager {
  BOOL postTowall;
}

- (void) login {
  NSArray *permissions = [NSArray arrayWithObjects:@"publish_stream", nil];
  [FBSession openActiveSessionWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:NO completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
    if (!error) {
      if (session) {
        //call some sucess method, like sending even to server
        //or updating label
        [self saveAccessToken];
        if ([self.delegate respondsToSelector:@selector(facebookLoginSucess)]) {
          [self.delegate facebookLoginSucess];
          if (postTowall) {
            [self postToWall];
          }
        }
      }
      else {
        if ([self.delegate respondsToSelector:@selector(facebookLoginFailed)]) {
          [self.delegate facebookLoginFailed];
        }
      }
    }
    else {
      NSLog(@"%@",error);
    }
  }];

}

- (void)logout {
  [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)postToWall {
  postTowall = YES;
  if (FBSession.activeSession.isOpen) {
    
  }
  else {
    [self login];
  }
}

- (void)like {
  
}

- (void)askForPermission:(NSArray *)permission {
  //if we want to ask for more permission
  [FBSession.activeSession requestNewReadPermissions:permission completionHandler:^(FBSession *session, NSError *error) {
    
    if (!error) {
      if ([self.delegate respondsToSelector:@selector(requestNewPermissionSucess)]) {
        [self.delegate requestNewPermissionSucess];
      }
    }
    else {
      if ([self.delegate respondsToSelector:@selector(requestNewPermissionSucess)]) {
        [self.delegate requestNewPermissionFailed];
      }
    }
  }];
}

- (void)saveAccessToken {
  NSString *accessToken = [[FBSession.activeSession accessTokenData] accessToken];
  NSDate *expirationDate = [[FBSession.activeSession accessTokenData] expirationDate];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:accessToken forKey:FACEBOOK_ACCESS_TOKEN];
  [defaults setObject:expirationDate forKey:FACEBOOK_EXPIRATION_DATE];
  [defaults synchronize];
}

@end

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
  [FBSession openActiveSessionWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
    if (!error) {
      if (session) {
        //call some sucess method, like sending even to server
        //or updating label
        [self saveAccessToken];
        if ([self.delegate respondsToSelector:@selector(facebookLoginSucess)]) {
          [self.delegate facebookLoginSucess];
          if (postTowall) {
            postTowall = NO;
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
  if (FBSession.activeSession.isOpen) {
    // Check if the Facebook app is installed and we can present the share dialog
    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    params.name = @"Sharing Tutorial";
    params.caption = @"Build great social apps and get more installs.";
    params.picture = [NSURL URLWithString:@"http://i.imgur.com/g3Qc1HN.png"];
    params.description = @"Allow your users to share stories on Facebook from your app using the iOS SDK.";
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
      [FBDialogs presentShareDialogWithLink:params.link
                                       name:params.name
                                    caption:params.caption
                                description:params.description
                                    picture:params.picture
                                clientState:nil
                                    handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                      if(error) {
                                        // An error occurred, we need to handle the error
                                      } else {
                                        // Success
                                        NSLog(@"result %@", results);
                                      }
                                    }];
    } else {
      // Present the feed dialog
    }
  }
  else {
    postTowall = YES;
    [self login];
  }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  
  BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                              sourceApplication:sourceApplication
                                fallbackHandler:^(FBAppCall *call) {
                                  NSLog(@"Unhandled deep link: %@", url);
                                  // Here goes the code to handle the links
                                  // Use the links to show a relevant view of your app to the user
                                }];
  
  return urlWasHandled;
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

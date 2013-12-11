//
//  FacebookManager.h
//  Utopia
//
//  Created by Danny on 10/23/13.
//  Copyright (c) 2013 LVL6. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FACEBOOK_ACCESS_TOKEN @"AcessToken"
#define FACEBOOK_EXPIRATION_DATE @"ExpiraionDate"

@protocol FBDelegate <NSObject>

@optional
- (void)facebookLoginSucess;
- (void)facebookLoginFailed;
- (void)requestNewPermissionSucess;
- (void)requestNewPermissionFailed;

@end

@interface FacebookManager : NSObject

@property (nonatomic, strong) id<FBDelegate> delegate;

- (void)login;
- (void)logout;
- (void)askForPermission:(NSArray *)permission;
- (void)postToWall;
- (void)like;
@end

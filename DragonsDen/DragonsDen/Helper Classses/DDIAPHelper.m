//
//  DDIAPHelper.m
//  DragonsDen
//
//  Created by Danny on 1/11/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "DDIAPHelper.h"

@implementation DDIAPHelper

+ (DDIAPHelper *)sharedInstance {
  static dispatch_once_t once;
  static DDIAPHelper * sharedInstance;
  dispatch_once(&once, ^{
    NSSet * productIdentifiers = [NSSet setWithObjects:
                                  @"com.ushigames.dragonsden.gold1",
                                  @"com.ushigames.dragonsden.gold2",
                                  @"com.ushigames.dragonsden.gold3",
                                  @"com.ushigames.dragonsden.gold4",
                                  @"com.ushigames.dragonsden.gold5",
                                  @"com.ushigames.dragonsden.gold6",
                                  @"com.ushigames.dragonsden.gold7",
                                  nil];
    sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
  });
  return sharedInstance;
}

@end

//
//  GameState.m
//  DragonsDen
//
//  Created by Danny on 11/15/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "GameState.h"

@implementation GameState

+ (GameState *)sharedGameState {
  static GameState *sharedSound = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedSound = [[self alloc] init];
  });
  return sharedSound;
}

- (id)init {
  if ((self = [super init])) {
    self.gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"Gold"];
    self.armorCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"Armor"];
    self.slowCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"Slow"];
    self.mayhemCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"Mayhem"];
  }
  return self;
}

@end

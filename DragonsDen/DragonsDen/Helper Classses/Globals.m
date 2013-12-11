//
//  Globals.m
//  DragonsDen
//
//  Created by Danny on 11/5/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Globals.h"
#import "GameState.h"

@implementation Globals

+ (Globals *)sharedGlobals {
  static id sharedGlobals = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedGlobals = [[self alloc] init];
  });
  return sharedGlobals;
}

- (NSString *)getAtlasNameWithState:(DragonState)dragonState {
  NSString *stateString;
  switch (dragonState) {
    case kNormalFlapping:
      stateString = @"NormalFlap";
      break;
      
    case kArmorFlapping:
      stateString = @"ArmoredFlap";
      break;
      
    case kMayhemFlapping:
      stateString = @"MayhemFlap";
      break;
      
    case kNormalGliding:
      stateString = @"NormalGlide";
      break;
      
    case kArmorGliding:
      stateString = @"ArmoredGlide";
      break;
      
    case kMayhemGliding:
      stateString = @"MayhemGlide";
      break;
      
    case kNormalSpeed:
      stateString = @"NormalGlide";
      break;
      
    case kArmorSpeed:
      stateString = @"ArmoredSpeed";
      break;
      
    case kMayhemSpeed:
      stateString = @"MayhemSpeed";
      break;
      
    case kDeath:
      stateString = @"Particles";
      break;
  }
  return stateString;
}

- (NSString *)getAtlasNameWithPowerUp:(PowerUpType)type {
  NSString *prefix = @"";
  switch (type) {
    case kTypeSlow:
      prefix = @"Slow";
      break;
      
    case kTypeArmor:
      prefix = @"Armor";
      break;
      
    case kTypeMayhem:
      prefix = @"Mayhem";
      break;
  }
  return prefix;
}

- (void)updateGold {
  GameState *gs = [GameState sharedGameState];
  [[NSUserDefaults standardUserDefaults] setInteger:gs.gold forKey:@"Gold"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)updateArmor {
  GameState *gs = [GameState sharedGameState];
  [[NSUserDefaults standardUserDefaults] setInteger:gs.armorCount forKey:@"Armor"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)updateSlow {
  GameState *gs = [GameState sharedGameState];
  [[NSUserDefaults standardUserDefaults] setInteger:gs.slowCount forKey:@"Slow"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)updateMayhem {
  GameState *gs = [GameState sharedGameState];
  [[NSUserDefaults standardUserDefaults] setInteger:gs.mayhemCount forKey:@"Mayhem"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

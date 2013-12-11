//
//  Globals.h
//  DragonsDen
//
//  Created by Danny on 11/5/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon.h"
#import "PowerUp.h"

@interface Globals : NSObject

+ (Globals *)sharedGlobals;
- (NSString *)getAtlasNameWithState:(DragonState)dragonState;
- (NSString *)getAtlasNameWithPowerUp:(PowerUpType)type;
- (void)updateGold;
- (void)updateArmor;
- (void)updateSlow;
- (void)updateMayhem;

@end

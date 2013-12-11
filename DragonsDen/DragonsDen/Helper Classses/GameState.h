//
//  GameState.h
//  DragonsDen
//
//  Created by Danny on 11/15/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject

@property (nonatomic) int gold;
@property (nonatomic) int armorCount;
@property (nonatomic) int slowCount;
@property (nonatomic) int mayhemCount;

+ (GameState *)sharedGameState;

@end

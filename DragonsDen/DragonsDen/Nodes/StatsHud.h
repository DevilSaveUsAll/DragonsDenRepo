//
//  StatsHud.h
//  DragonsDen
//
//  Created by Danny on 12/17/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKButton.h"
#import "Coin.h"

@protocol StatsDelegate <NSObject>

- (void)pause;

@end

@interface StatsHud : SKNode

@property (nonatomic, strong) SKLabelNode *distanceLabel;
@property (nonatomic, strong) SKLabelNode *goldLabel;
@property (nonatomic, strong) SKButton *musicButton;
@property (nonatomic) id<StatsDelegate> delegate;

- (void)updateDistance:(int)distance;
- (void)updateGold:(Coin *)gold;

@end

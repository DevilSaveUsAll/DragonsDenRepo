//
//  DeathScreen.h
//  DragonsDen
//
//  Created by Danny on 11/14/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol DeathDelegate <NSObject>

- (void)restart;
- (void)continueGame;
- (void)share;

@end

@interface DeathScreen : SKNode {
  NSMutableArray *clockFrames;
  NSMutableArray *clockGlowFrames;
  
  SKSpriteNode *clockSprite;
  SKSpriteNode *glowSprite;
}

@property (nonatomic, strong) SKLabelNode *distanceLabel;
@property (nonatomic, strong) SKLabelNode *goldLabel;
@property (nonatomic) id<DeathDelegate> delegate;

- (id)initWithDistance:(int)progress gold:(int)goldAmount;

@end

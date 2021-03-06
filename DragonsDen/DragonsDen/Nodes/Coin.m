
//
//  Coin.m
//  DragonsDen
//
//  Created by Danny on 11/11/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Coin.h"
#import "GameScene.h"

@implementation Coin

- (id)initWithCoinType:(CoinType)coinType andFrames:(NSMutableArray *)frames {
  if (self = [super init]) {
    self.coinType = coinType;
    coinFrames = [frames copy];
    [self setUpFrames];
  }
  return self;
}

- (void)setUpFrames {
  if (self.coinType == kTypeNormal) {
    self.coin = [SKSpriteNode spriteNodeWithTexture:coinFrames[0]];
    self.goldValue = NORMAL_VALUE;
    [self animateCoin];
  }
  else {
    self.coin = [SKSpriteNode spriteNodeWithImageNamed:@"potofgold.png"];
    self.goldValue = POT_VALUE;
  }
  [self addChild:self.coin];
  
  self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.coin.size.width-5];
  self.physicsBody.dynamic = NO;
  self.physicsBody.categoryBitMask = DDColliderTypeCoin;
  self.physicsBody.collisionBitMask = DDColliderTypeDragon;
  self.physicsBody.contactTestBitMask = DDColliderTypeDragon;
  
}

- (void)animateCoin {
  [self.coin runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:coinFrames timePerFrame:0.05f resize:NO restore:YES]] withKey:@"Coin"];
}

@end

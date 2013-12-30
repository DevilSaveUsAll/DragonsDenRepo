//
//  Bat.m
//  DragonsDen
//
//  Created by Danny on 11/12/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Bat.h"
#import "GameScene.h"

@implementation Bat

- (id)initWithBatFrames:(NSMutableArray *)frames deathFrames:(NSMutableArray *)dFrames {
  if ((self = [super init])) {
    batFrames = frames;
    deathFrames = dFrames;
    [self setUpFrames];
  }
  return self;
}

- (void)setUpFrames {
  self.batSprite = [SKSpriteNode spriteNodeWithTexture:batFrames[0]];
  [self addChild:self.batSprite];
  self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.batSprite.size.width/2];
  self.physicsBody.dynamic = NO;
  self.physicsBody.categoryBitMask = DDColliderTypeBat;
  self.physicsBody.collisionBitMask = DDColliderTypeDragon;
  self.physicsBody.contactTestBitMask = DDColliderTypeDragon;
  
  [self.batSprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:batFrames timePerFrame:0.03f resize:NO restore:YES]] withKey:@"batFlap"];
}

- (void)death {
  [self.batSprite runAction:[SKAction animateWithTextures:batFrames timePerFrame:0.05f] completion:^{
    [self removeFromParent];
  }];
}

@end

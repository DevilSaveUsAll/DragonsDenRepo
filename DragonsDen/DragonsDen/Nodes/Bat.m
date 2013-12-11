//
//  Bat.m
//  DragonsDen
//
//  Created by Danny on 11/12/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Bat.h"

@implementation Bat

- (id)init {
  if ((self = [super init])) {
    [self setUpFrames];
  }
  return self;
}

- (void)setUpFrames {
  batFrames = [NSArray array];
  deathFrames = [NSArray array];
 
  NSMutableArray *tempArray = [NSMutableArray array];
  
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"BatAnimation"];
  NSUInteger numImage = atlas.textureNames.count;
  for (int i = 0; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"bat%0.4d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [tempArray addObject:temp];
  }
  
  batFrames = [tempArray copy];
  
  atlas = [SKTextureAtlas atlasNamed:@"Smoke"];
  numImage = atlas.textureNames.count;
  
  tempArray = [NSMutableArray array];
  
  for (int i = 10; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"smoke%0.4d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [tempArray addObject:temp];
  }
  deathFrames = [tempArray copy];
  
  self.batSprite = [SKSpriteNode spriteNodeWithTexture:batFrames[0]];
  [self addChild:self.batSprite];
  
}

- (void)death {
  [self.batSprite runAction:[SKAction animateWithTextures:batFrames timePerFrame:0.05f] completion:^{
    [self removeFromParent];
  }];
}

@end

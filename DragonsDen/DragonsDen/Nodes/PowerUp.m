//
//  PowerUp.m
//  DragonsDen
//
//  Created by Danny on 11/9/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "PowerUp.h"
#import "Globals.h"

@implementation PowerUp

- (id)initWithType:(PowerUpType)type {
  if (self = [super init]) {
    self.powerUpType = type;
    [self setUpFrames];
    
    self.amountLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    self.amountLabel.text = [NSString stringWithFormat:@"1"];
    self.amountLabel.fontSize = 9;
    self.amountLabel.position = CGPointMake(self.amountLabel.position.x-9, self.amountLabel.position.y+8);
    [self addChild:self.amountLabel];
    
  }
  return self;
}

- (void)setUpFrames {
  powerUpFrame = [NSMutableArray array];
  glowFrame = [NSMutableArray array];
  
  NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithPowerUp:self.powerUpType];
  if (prefix != NULL) {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:prefix];
    NSUInteger numImage = atlas.textureNames.count;
    for (int i = 0; i < numImage; i++) {
      NSString *textureName = [NSString stringWithFormat:@"%@%0.2d",prefix,i];
      SKTexture *temp = [atlas textureNamed:textureName];
      [powerUpFrame addObject:temp];
    }
    
    prefix = [NSString stringWithFormat:@"%@Glow",prefix];
    atlas = [SKTextureAtlas atlasNamed:prefix];
    numImage = atlas.textureNames.count;
    for (int i = 0; i < numImage; i++) {
      NSString *textureName = [NSString stringWithFormat:@"%@%0.2d",prefix, i];
      SKTexture *temp = [atlas textureNamed:textureName];
      [glowFrame addObject:temp];
    }
  }
  
  SKTexture *temp = glowFrame[0];
  self.glowSprite = [SKSpriteNode spriteNodeWithTexture:temp];
  [self addChild:self.glowSprite];
  
  temp = powerUpFrame[0];
  self.powerUpSprite = [SKSpriteNode spriteNodeWithTexture:temp];
  [self addChild:self.powerUpSprite];
}


- (void)setAmount:(int)amount {
  _amount = amount;
  self.amountLabel.text = [NSString stringWithFormat:@"%d",_amount];
}

- (void)animatePowerUp {
  [self.powerUpSprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:powerUpFrame timePerFrame:0.07f resize:NO restore:YES]] withKey:@"PowerUp"];
  [self.glowSprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:glowFrame timePerFrame:0.07f resize:NO restore:YES]] withKey:@"Glow"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"meep");
}

@end

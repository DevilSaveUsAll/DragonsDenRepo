//
//  Dragon.m
//  DragonsDen
//
//  Created by Danny on 11/5/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Dragon.h"
#import "Globals.h"
#import "GameScene.h"

@implementation Dragon

#define SPEEDING_FRAME 0.02f
#define GLIDING_FRAME 0.01f
#define FLAPPING_FRAME 0.03f

- (id)init {
  if ((self = [super init])) {
    [self setUpFramesArray];
    SKTexture *temp = normalFlapFrames[0];
    self.dragon = [SKSpriteNode spriteNodeWithTexture:temp];
    self.name = @"Dragon";
    [self addChild:self.dragon];
    
    self.dragon.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.dragon.size.width/2, self.dragon.size.height/2-10)];
    self.dragon.physicsBody.dynamic = NO;
    self.dragon.physicsBody.categoryBitMask = DDColliderTypeDragon;
    self.dragon.physicsBody.collisionBitMask = DDColliderTypeBat | DDColliderTypeBat | DDColliderTypeForeground;
    self.dragon.physicsBody.contactTestBitMask = DDColliderTypeForeground;
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Smoke"];
    NSUInteger numImage = atlas.textureNames.count;
    for (int i = 0; i < numImage ; i++) {
      NSString *textureName = [NSString stringWithFormat:@"Smoke%0.2d",i];
      SKTexture *temps = [atlas textureNamed:textureName];
      [smokeFrames addObject:temps];
    }
    smokeSprite = [SKSpriteNode spriteNodeWithTexture:smokeFrames[0]];
    smokeSprite.hidden = YES;
    [self addChild:smokeSprite];
  }
  return self;
}

#pragma mark - Animation Setup

- (void)switchAnimation:(FlyingType)flyingState {
  if (self.powerUpState == kNormal) {
    switch (flyingState) {
      case kIdle:
        [self.dragon removeActionForKey:currentAction];
        break;
        
      case kFlapping:
        [self.dragon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:normalFlapFrames timePerFrame:FLAPPING_FRAME resize:NO restore:YES]] withKey:@"normalFlap"];
        currentAction = @"normalFlap";
        break;
        
      case kGliding:
        [self.dragon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:normalGlidingFrames timePerFrame:GLIDING_FRAME resize:NO restore:YES]] withKey:@"normalGlide"];
        currentAction = @"normalGlide";
        break;
        
      case kSpeed:
        [self.dragon runAction:[SKAction animateWithTextures:normalSpeedFrames timePerFrame:SPEEDING_FRAME resize:NO restore:YES] withKey:@"normalSpeed"];
        currentAction = @"normalSpeed";
        break;
        
      case kDied:
        [self.dragon runAction:[SKAction animateWithTextures:particleFrames timePerFrame:0.1f resize:NO restore:NO] completion:^{
          [self.dragon removeFromParent];
        }];
        smokeSprite.hidden = NO;
        smokeSprite.position = self.dragon.position;
        [smokeSprite runAction:[SKAction animateWithTextures:smokeFrames timePerFrame:0.01f resize:NO restore:NO] withKey:@"Smoke"];
        currentAction = @"death";
        break;
    }
  }
  else if (self.powerUpState == kArmor) {
    switch (flyingState) {
      case kIdle:
      case kFlapping:
        [self.dragon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:armoredFlappingFrames timePerFrame:FLAPPING_FRAME resize:NO restore:YES]] withKey:@"armorflap"];
        currentAction = @"armorflap";
        break;
        
      case kGliding:
        [self.dragon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:armorGlidingFrames timePerFrame:GLIDING_FRAME resize:NO restore:YES]] withKey:@"armorGlide"];
        currentAction = @"armorGlide";
        break;
        
      case kSpeed:
        [self.dragon runAction:[SKAction animateWithTextures:armorSpeedFrames timePerFrame:SPEEDING_FRAME resize:NO restore:YES] withKey:@"armorSpeed"];
        currentAction = @"armorSpeed";
        break;
      
      case kDied:
        [self.dragon runAction:[SKAction animateWithTextures:particleFrames timePerFrame:0.1f resize:NO restore:NO] withKey:@"Particle"];
        smokeSprite.hidden = NO;
        smokeSprite.position = self.dragon.position;
        [smokeSprite runAction:[SKAction animateWithTextures:smokeFrames timePerFrame:0.01f resize:NO restore:NO] withKey:@"Smoke"];
        currentAction = @"death";
        break;
    }
  }
  else if (self.powerUpState == kMayhem) {
    switch (flyingState) {
      case kIdle:
      case kFlapping:
        [self.dragon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:mayhemFlappingFrames timePerFrame:FLAPPING_FRAME resize:NO restore:YES]] withKey:@"mayhemFlap"];
        currentAction = @"mayhemFlap";
        break;
        
      case kGliding:
        [self.dragon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:mayhemGlidingFrames timePerFrame:GLIDING_FRAME resize:NO restore:YES]] withKey:@"mayhemGlide"];
        currentAction = @"mayhemGlide";
        break;
        
      case kSpeed:
        [self.dragon runAction:[SKAction animateWithTextures:mayhemSpeedFrames timePerFrame:SPEEDING_FRAME resize:NO restore:YES] withKey:@"mayhemSpeed"];
        currentAction = @"mayhemSpeed";
        break;
        
      case kDied:
        [self.dragon runAction:[SKAction animateWithTextures:particleFrames timePerFrame:0.1f resize:NO restore:NO] withKey:@"Particle"];
        smokeSprite.hidden = NO;
        smokeSprite.position = self.dragon.position;
        [smokeSprite runAction:[SKAction animateWithTextures:smokeFrames timePerFrame:0.1f resize:NO restore:NO] withKey:@"Smoke"];
        currentAction = @"death";
        break;
    }
  }
}

#pragma mark - Frames SetUp

- (void)setUpFramesArray {
  //initialize all the arrays
  normalFlapFrames = [NSMutableArray array];
  armoredFlappingFrames = [NSMutableArray array];
  mayhemFlappingFrames = [NSMutableArray array];
  normalGlidingFrames = [NSMutableArray array];
  armorGlidingFrames = [NSMutableArray array];
  mayhemGlidingFrames = [NSMutableArray array];
  particleFrames = [NSMutableArray array];
  smokeFrames = [NSMutableArray array];
  normalSpeedFrames = [NSMutableArray array];
  armorSpeedFrames = [NSMutableArray array];
  mayhemSpeedFrames = [NSMutableArray array];

  for (int i = kNormalFlapping; i < kDeath; i++) {
    NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithState:i];
    if (prefix != NULL) {
      SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:prefix];
      NSUInteger numImage = atlas.textureNames.count;
      NSMutableArray *array = [self getStateArray:i];
      for (int j = 1; j <= numImage; j++) {
        NSString *textureName = [NSString stringWithFormat:@"%@%0.2d",prefix,j];
        SKTexture *temp = [atlas textureNamed:textureName];
        [array addObject:temp];
      }
    }
  }
  
  NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithState:kDeath];
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:prefix];
  NSUInteger numImage = atlas.textureNames.count;
  NSMutableArray *array = [self getStateArray:kDeath];
  for (int i = 1; i <= numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"ParticleDeath%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [array addObject:temp];
  }
  
}

- (NSMutableArray *)getStateArray:(DragonState)dragonState {
  switch (dragonState) {
    case kNormalFlapping:
      return normalFlapFrames;
      break;
      
    case kArmorFlapping:
      return armoredFlappingFrames;
      break;
      
    case kMayhemFlapping:
      return mayhemFlappingFrames;
      break;
      
    case kNormalGliding:
      return normalGlidingFrames;
      break;
      
    case kArmorGliding:
      return armorGlidingFrames;
      break;
      
    case kMayhemGliding:
      return mayhemGlidingFrames;
      break;
      
    case kNormalSpeed:
      return normalSpeedFrames;
      break;
      
    case kArmorSpeed:
      return armorSpeedFrames;
      break;
      
    case kMayhemSpeed:
      return mayhemSpeedFrames;
      break;
      
    case kDeath:
      return particleFrames;
      break;
  }
}

@end

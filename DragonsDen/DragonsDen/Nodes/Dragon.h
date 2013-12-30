//
//  Dragon.h
//  DragonsDen
//
//  Created by Danny on 11/5/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
  kNormalFlapping = 1,
  kArmorFlapping,
  kMayhemFlapping,
  kNormalGliding,
  kArmorGliding,
  kMayhemGliding,
  kNormalSpeed,
  kArmorSpeed,
  kMayhemSpeed,
  kDeath
}DragonState;

typedef enum {
  kIdle = 100,
  kFlapping,
  kGliding,
  kSpeed,
  kDied,
}FlyingType;

typedef enum {
  kNormal = 50,
  kMayhem,
  kArmor,
  kNone,
}PowerUpState;

@interface Dragon : SKNode {
  //Flapping frames
  NSMutableArray *normalFlapFrames;
  NSMutableArray *armoredFlappingFrames;
  NSMutableArray *mayhemFlappingFrames;

  //Gliding Frames
  NSMutableArray *normalGlidingFrames;
  NSMutableArray *armorGlidingFrames;
  NSMutableArray *mayhemGlidingFrames;
  
  //Death Frames
  NSMutableArray *particleFrames;
  NSMutableArray *smokeFrames;
  
  //SuperSpeed Frames
  NSMutableArray *normalSpeedFrames;
  NSMutableArray *armorSpeedFrames;
  NSMutableArray *mayhemSpeedFrames;
  
  NSString *currentAction;
  
  SKSpriteNode *smokeSprite;

}

@property (nonatomic, strong) SKSpriteNode *dragon;
@property (nonatomic, assign) DragonState state;
@property (nonatomic, assign) PowerUpState powerUpState;

- (void)switchAnimation:(FlyingType)flyingState;

@end

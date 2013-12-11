//
//  PlayScene.m
//  DragonsDen
//
//  Created by Danny on 11/21/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "PlayScene.h"
#import "SKButton.h"
#import "Sound.h"
#import "PowerUp.h"

@implementation PlayScene {
  PowerUp *slowPowerup;
  PowerUp *armorPowerup;
  PowerUp *mayhemPowerup;
  CGSize winSize;
}

- (id)initWithSize:(CGSize)size {
  if ((self = [super initWithSize:size])) {
    winSize = size;
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"PlayMenuScreen.png"];
    background.position = CGPointMake(size.width/2, size.height/2);
    [self addChild:background];
    
    [self setPowerUp];
  }
  return self;
}

- (void)setPowerUp {
  slowPowerup = [[PowerUp alloc] initWithType:kTypeSlow];
  slowPowerup.position = CGPointMake(85, 200);
  slowPowerup.amountLabel.hidden = YES;
  [slowPowerup animatePowerUp];
  [self addChild:slowPowerup];
  
  armorPowerup = [[PowerUp alloc] initWithType:kTypeArmor];
  armorPowerup.position = CGPointMake(winSize.width/2, 200);
  armorPowerup.amountLabel.hidden = YES;
  [armorPowerup animatePowerUp];
  [self addChild:armorPowerup];
  
  mayhemPowerup = [[PowerUp alloc] initWithType:kTypeMayhem];
  mayhemPowerup.position = CGPointMake(475, 200);
  mayhemPowerup.amountLabel.hidden = YES;
  [mayhemPowerup animatePowerUp];
  [self addChild:mayhemPowerup];
}

@end

//
//  PowerUp.h
//  DragonsDen
//
//  Created by Danny on 11/9/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
  kTypeSlow = 1,
  kTypeArmor,
  kTypeMayhem
}PowerUpType;

@interface PowerUp : SKNode {
  NSMutableArray *powerUpFrame;
  NSMutableArray *glowFrame;
}

@property (nonatomic, strong) SKSpriteNode *powerUpSprite;
@property (nonatomic, strong) SKSpriteNode *glowSprite;
@property (nonatomic, strong) SKLabelNode *amountLabel;
@property (nonatomic) PowerUpType powerUpType;
@property (nonatomic) int amount;

- (id)initWithType:(PowerUpType)type;
- (void)animatePowerUp;
@end

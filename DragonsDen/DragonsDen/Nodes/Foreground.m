//
//  Foreground.m
//  DragonsDen
//
//  Created by Danny on 11/16/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Foreground.h"
#import "GameScene.h"

@implementation Foreground

- (id)initWithCurrentPiece:(ForeGroundType)type {
  if ((self = [super init])) {
    self.currentPiece = type;
    self.childName = @"Foreground";
    [self getRandomForeground];
  }
  return self;
}

- (void)getRandomForeground {
  int random;
  do {
    random = (arc4random() % 7) +1;
  }while (random == self.currentPiece);
  [self setCurrentForegroundWithPieceNumber:random];
  self.currentPiece = random;
}

- (void)setCurrentForegroundWithPieceNumber:(ForeGroundType)type {
  switch (type) {
    case kForegroundOne:
      [self setForegroundOne];
      break;
      
    case kForegroundTwo:
      [self setForegroundTwo];
      break;
      
    case kForegroundThree:
      [self setForegroundThree];
      break;
      
    case kForegroundFour:
      [self setForegroundFour];
      break;
      
    case kForegroundFive:
      [self setForegroundFive];
      break;
      
    case kForegroundSix:
      [self setForegroundSix];
      break;
      
    case kForegroundSeven:
      [self setForegroundSeven];
      break;
      
  }
}

- (void)setForegroundOne {
  SKSpriteNode *foregroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"ForeGround_1.png"];
  foregroundOne.size = CGSizeMake(foregroundOne.size.width/2, foregroundOne.size.height/2);
  foregroundOne.position = CGPointMake(foregroundOne.size.width/2, 320-foregroundOne.size.height/2);
  [self addChild:foregroundOne];
  foregroundOne.name = self.childName;

  SKSpriteNode *foregroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"ForeGround_1_2.png"];
  foregroundTwo.size = CGSizeMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  foregroundTwo.position = CGPointMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  [self addChild:foregroundTwo];
}

- (void)setForegroundTwo {
  SKSpriteNode *foregroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_2_1.png"];
  foregroundOne.size = CGSizeMake(foregroundOne.size.width/2, foregroundOne.size.height/2);
  foregroundOne.position = CGPointMake(foregroundOne.size.width/2, 320-foregroundOne.size.height/2);
  [self addChild:foregroundOne];
  foregroundOne.name = self.childName;
  
  SKSpriteNode *foregroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_2_4.png"];
  foregroundTwo.size = CGSizeMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  foregroundTwo.position = CGPointMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  [self addChild:foregroundTwo];
  
  SKSpriteNode *foregroundThree = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_2_2.png"];
  foregroundThree.size = CGSizeMake(foregroundThree.size.width/2, foregroundThree.size.height/2);
  foregroundThree.position = CGPointMake(320, 210);
  [self addChild:foregroundThree];
  
  SKSpriteNode *foregroundFour = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_2_3.png"];
  foregroundFour.size = CGSizeMake(foregroundFour.size.width/2,foregroundFour.size.height/2);
  foregroundFour.position = CGPointMake(130, 100);
  [self addChild:foregroundFour];
}

- (void)setForegroundThree {
  SKSpriteNode *foregroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground3_1.png"];
  foregroundOne.size = CGSizeMake(foregroundOne.size.width/2, foregroundOne.size.height/2);
  foregroundOne.position = CGPointMake(foregroundOne.size.width/2, 320-foregroundOne.size.height/2);
  [self addChild:foregroundOne];
  foregroundOne.name = self.childName;
  
  SKSpriteNode *foregroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground3_4.png"];
  foregroundTwo.size = CGSizeMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  foregroundTwo.position = CGPointMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  [self addChild:foregroundTwo];
  
  SKSpriteNode *foregroundThree = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground3_2.png"];
  foregroundThree.size = CGSizeMake(foregroundThree.size.width/2, foregroundThree.size.height/2);
  foregroundThree.position = CGPointMake(255, 220);
  [self addChild:foregroundThree];
  
  SKSpriteNode *foregroundFour = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground3_3.png"];
  foregroundFour.size = CGSizeMake(foregroundFour.size.width/2, foregroundFour.size.height/2);
  foregroundFour.position = CGPointMake(150, 120);
  [self addChild:foregroundFour];
}

- (void)setForegroundFour {
  SKSpriteNode *foregroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_4_1.png"];
  foregroundOne.size = CGSizeMake(foregroundOne.size.width/2, foregroundOne.size.height/2);
  foregroundOne.position = CGPointMake(foregroundOne.size.width/2, 320-foregroundOne.size.height/2);
  [self addChild:foregroundOne];
  foregroundOne.name = self.childName;
  
  SKSpriteNode *foregroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_4_2.png"];
  foregroundTwo.size = CGSizeMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  foregroundTwo.position = CGPointMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  [self addChild:foregroundTwo];
}

- (void)setForegroundFive {
  SKSpriteNode *foregroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_5_1.png"];
  foregroundOne.size = CGSizeMake(foregroundOne.size.width/2, foregroundOne.size.height/2);
  foregroundOne.position = CGPointMake(foregroundOne.size.width/2, 320-foregroundOne.size.height/2);
  [self addChild:foregroundOne];
  foregroundOne.name = self.childName;
  
  SKSpriteNode *foregroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_5_4.png"];
  foregroundTwo.size = CGSizeMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  foregroundTwo.position = CGPointMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  [self addChild:foregroundTwo];
  
  SKSpriteNode *foregroundThree = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_5_2.png"];
  foregroundThree.size = CGSizeMake(foregroundThree.size.width/2, foregroundThree.size.height/2);
  foregroundThree.position = CGPointMake(180, 175);
  [self addChild:foregroundThree];
  
  SKSpriteNode *foregroundFour = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_5_3.png"];
  foregroundFour.size = CGSizeMake(foregroundFour.size.width/2, foregroundFour.size.height/2);
  foregroundFour.position = CGPointMake(foregroundFour.size.width/2, 155);
  [self addChild:foregroundFour];
  
}

- (void)setForegroundSix {
  SKSpriteNode *foregroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_1.png"];
  foregroundOne.size = CGSizeMake(foregroundOne.size.width/2, foregroundOne.size.height/2);
  foregroundOne.position = CGPointMake(foregroundOne.size.width/2, 320-foregroundOne.size.height/2);
  [self addChild:foregroundOne];
  foregroundOne.name = self.childName;
  
  SKSpriteNode *foregroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_9.png"];
  foregroundTwo.size = CGSizeMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  foregroundTwo.position = CGPointMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  [self addChild:foregroundTwo];
  
  SKSpriteNode *foregroundThree = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_2.png"];
  foregroundThree.size = CGSizeMake(foregroundThree.size.width/2, foregroundThree.size.height/2);
  foregroundThree.position = CGPointMake(foregroundThree.size.width/2, 175);
  [self addChild:foregroundThree];
  
  SKSpriteNode *foregroundFour = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_3.png"];
  foregroundFour.size = CGSizeMake(foregroundFour.size.width/2, foregroundFour.size.height/2);
  foregroundFour.position = CGPointMake(140, 195);
  [self addChild:foregroundFour];
  
  SKSpriteNode *foregroundFive = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_4.png"];
  foregroundFive.size = CGSizeMake(foregroundFive.size.width/2, foregroundFive.size.height/2);
  foregroundFive.position = CGPointMake(265, 200);
  [self addChild:foregroundFive];
  
  SKSpriteNode *foregroundSix = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_5.png"];
  foregroundSix.size = CGSizeMake(foregroundSix.size.width/2, foregroundSix.size.height/2);
  foregroundSix.position = CGPointMake(350, 190);
  [self addChild:foregroundSix];

  SKSpriteNode *foregroundSeven = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_6.png"];
  foregroundSeven.size = CGSizeMake(foregroundSeven.size.width/2, foregroundSeven.size.height/2);
  foregroundSeven.position = CGPointMake(100, 80);
  [self addChild:foregroundSeven];
  
  SKSpriteNode *foregroundEight = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_7.png"];
  foregroundEight.size = CGSizeMake(foregroundEight.size.width/2, foregroundEight.size.height/2);
  foregroundEight.position = CGPointMake(300, 80);
  [self addChild:foregroundEight];
  
  SKSpriteNode *foregroundNine = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_6_8.png"];
  foregroundNine.size = CGSizeMake(foregroundNine.size.width/2, foregroundNine.size.height/2);
  foregroundNine.position = CGPointMake(240, 100);
  [self addChild:foregroundNine];
  
}

- (void)setForegroundSeven {
  SKSpriteNode *foregroundOne = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_7_1.png"];
  foregroundOne.size = CGSizeMake(foregroundOne.size.width/2, foregroundOne.size.height/2);
  foregroundOne.position = CGPointMake(foregroundOne.size.width/2, 320-foregroundOne.size.height/2);
  [self addChild:foregroundOne];
  foregroundOne.name = self.childName;
  
  SKSpriteNode *foregroundTwo = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_7_3.png"];
  foregroundTwo.size = CGSizeMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  foregroundTwo.position = CGPointMake(foregroundTwo.size.width/2, foregroundTwo.size.height/2);
  [self addChild:foregroundTwo];
  
  SKSpriteNode *foregroundThree = [SKSpriteNode spriteNodeWithImageNamed:@"Foreground_7_2.png"];
  foregroundThree.size = CGSizeMake(foregroundThree.size.width/2, foregroundThree.size.height/2);
  foregroundThree.position = CGPointMake(foregroundThree.size.width/2, 160);
  [self addChild:foregroundThree];
}

@end

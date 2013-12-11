//
//  Foregrounds.m
//  DragonsDen
//
//  Created by Danny on 12/5/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Foregrounds.h"
#import "GameScene.h"
#import "Coin.h"

#define COIN_MINIMUM_DISTANCE 15
#define COIN_MAXIMUM_DISTANCE 30

@implementation Foregrounds {
  int randomPos;
  int coinAmount;
}

- (id)initWithCurrentPiece:(ForeGroundType)type andCoinFrames:(NSMutableArray *)coinFrames {
  if (self = [super init]) {
    self.currentPiece = type;
    self.coinFrames = coinFrames;
    coinAmount = arc4random() % 7;
    [self getRandomForeground];
  }
  return self;
}

- (void)getRandomForeground {
  int random;
  do {
    random = (arc4random() % 7) +1;
  }while (random == self.currentPiece);
  self.currentPiece = random;
  self.foreground = [[SKSpriteNode alloc] initWithImageNamed:[NSString stringWithFormat:@"Foreground%d@2x.png",self.currentPiece]];
  self.foreground.name = @"Original";
  self.foreground.size = CGSizeMake(self.foreground.size.width/2, self.foreground.size.height/2);
  [self addChild:self.foreground];
  [self setCollisionRect];
}

- (void)setCollisionRect {
  switch (self.currentPiece) {
    case kForegroundOne:
      [self drawForegroundOne];
      [self spawnCoinsForegroundOne];
      break;
    case kForegroundTwo:
      [self drawForegroundTwo];
      [self spawnCoinsForegroundTwo];
      break;
    case kForegroundThree:
      [self drawForegroundThree];
      [self spawnCoinsForegroundThree];
      break;
    case kForegroundFour:
      [self drawForegroundFour];
      [self spawnCoinsForegroundFour];
      break;
    case kForegroundFive:
      [self drawForegroundFive];
      [self spawnCoinsForegroundFive];
      break;
    case kForegroundSix:
      [self drawForegroundSix];
      [self spawnCoinsForegroundSix];
      break;
    case kForegroundSeven:
      [self drawForegroundSeven];
      [self spawnCoinsForegroundSeven];
      break;
  }
  [self setCollision];
  [self setCoinCollision];
}

- (void)spawnCoinsForegroundOne {
  randomPos = arc4random() % 7;
  if (randomPos == 0) {
    for (int i = 0; i < coinAmount; i++) {
      int rndValue = COIN_MINIMUM_DISTANCE + arc4random() % (COIN_MAXIMUM_DISTANCE - COIN_MINIMUM_DISTANCE);
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(100+(i*rndValue), 30);
      [self addChild:coin];
    }
  }
  else if (randomPos == 1) {
    for (int i = 0; i < coinAmount; i++) {
      int rndValue = COIN_MINIMUM_DISTANCE + arc4random() % (COIN_MAXIMUM_DISTANCE - COIN_MINIMUM_DISTANCE);
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(100+(i*rndValue), 10);
      [self addChild:coin];
    }
  }
  else if (randomPos == 2) {
    for (int i = 0; i < coinAmount; i++) {
      int rndValue = COIN_MINIMUM_DISTANCE + arc4random() % (COIN_MAXIMUM_DISTANCE - COIN_MINIMUM_DISTANCE);
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(100+(i*rndValue), -10);
      [self addChild:coin];
    }
  }
  else if (randomPos == 3) {
    for (int i = 0; i < coinAmount; i++) {
      int rndValue = COIN_MINIMUM_DISTANCE + arc4random() % (COIN_MAXIMUM_DISTANCE - COIN_MINIMUM_DISTANCE);
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(100+(i*rndValue), -30);
      [self addChild:coin];
    }
  }
  else if (randomPos == 4){
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(100+(i*COIN_MINIMUM_DISTANCE), -50+(i*COIN_MINIMUM_DISTANCE));
      [self addChild:coin];
    }
  }
  else if (randomPos == 5) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-100+(i*COIN_MINIMUM_DISTANCE), 100-(i*COIN_MINIMUM_DISTANCE));
      [self addChild:coin];
    }
  }
  else if (randomPos == 6) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(150+(i*COIN_MINIMUM_DISTANCE),100);
      [self addChild:coin];
    }
  }
}

- (void)spawnCoinsForegroundTwo {
  randomPos = arc4random() % 7;

  if (randomPos == 0) {
    for (int i = 0; i < coinAmount; i++) {
      int rndValue = COIN_MINIMUM_DISTANCE + arc4random() % (COIN_MAXIMUM_DISTANCE - COIN_MINIMUM_DISTANCE);
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-100+(i*rndValue), 80);
      [self addChild:coin];
    }
  }
  else if (randomPos == 1) {
    for (int i = 0; i < coinAmount; i++) {
      int rndValue = COIN_MINIMUM_DISTANCE + arc4random() % (COIN_MAXIMUM_DISTANCE - COIN_MINIMUM_DISTANCE);
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-100+(i*rndValue), 60);
      [self addChild:coin];
    }
  }
  else if (randomPos == 2) {
    for (int i = 0; i < coinAmount; i++) {
      int rndValue = COIN_MINIMUM_DISTANCE + arc4random() % (COIN_MAXIMUM_DISTANCE - COIN_MINIMUM_DISTANCE);
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-100+(i*rndValue), 40);
      [self addChild:coin];
    }
  }
  else if (randomPos == 3) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-50+(i*COIN_MINIMUM_DISTANCE), 50-(i*COIN_MINIMUM_DISTANCE));
      [self addChild:coin];
    }
  }
  else if (randomPos == 4){
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(100+(i*COIN_MINIMUM_DISTANCE), 95);
      [self addChild:coin];
    }
  }
  else if (randomPos == 5) {
    int random = arc4random() % 11;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-140+(i*COIN_MINIMUM_DISTANCE), -100);
      [self addChild:coin];
    }
  }
  else if (randomPos == 6) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MINIMUM_DISTANCE),-60+(i*COIN_MINIMUM_DISTANCE));
      [self addChild:coin];
    }
  }
}

- (void)spawnCoinsForegroundThree {
  randomPos = arc4random() % 6;
  if (randomPos == 0) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MINIMUM_DISTANCE), 80-(i*COIN_MINIMUM_DISTANCE));
      [self addChild:coin];
    }
  }
  else if (randomPos == 1) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake((i*COIN_MAXIMUM_DISTANCE), 90);
      [self addChild:coin];
    }
  }
  else if (randomPos == 2) {
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < coinAmount; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-30+(i*COIN_MAXIMUM_DISTANCE), 20);
        [self addChild:coin];
      }
    }
  }
  else if (randomPos == 3) {
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < coinAmount; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-20+(i*10), -100+(i*COIN_MINIMUM_DISTANCE));
        [self addChild:coin];
      }
    }
  }
  else if (randomPos == 4){
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-300+(i*COIN_MINIMUM_DISTANCE), -90);
      [self addChild:coin];
    }
  }
  else if (randomPos == 5) {
    int random = arc4random() % 11;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-300+(i*COIN_MINIMUM_DISTANCE), -10);
      [self addChild:coin];
    }
  }
}

- (void)spawnCoinsForegroundFour {
  randomPos = arc4random() % 6;
  if (randomPos == 0) {
    int random = arc4random() % 15;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MINIMUM_DISTANCE), 70);
      [self addChild:coin];
    }
  }
  else if (randomPos == 1) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake((i*COIN_MAXIMUM_DISTANCE), 50);
      [self addChild:coin];
    }
  }
  else if (randomPos == 2) {
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < coinAmount; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-30+(i*COIN_MAXIMUM_DISTANCE), 30);
        [self addChild:coin];
      }
    }
  }
  else if (randomPos == 3) {
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < coinAmount; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-20+(i*10), -100+(i*COIN_MINIMUM_DISTANCE));
        [self addChild:coin];
      }
    }
  }
  else if (randomPos == 4){
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MINIMUM_DISTANCE), 40-(i*COIN_MINIMUM_DISTANCE));
      [self addChild:coin];
    }
  }
  else if (randomPos == 5) {
    int random = arc4random() % 11;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MINIMUM_DISTANCE), -80+(i*COIN_MINIMUM_DISTANCE));
      [self addChild:coin];
    }
  }
}

- (void)spawnCoinsForegroundFive {
  randomPos = arc4random() % 4;
  if (randomPos == 0) {
    int random = arc4random() % 15;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MINIMUM_DISTANCE), 70);
      [self addChild:coin];
    }
  }
  else if (randomPos == 1) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake((-180+i*COIN_MINIMUM_DISTANCE), 30+(i*10));
      [self addChild:coin];
    }
  }
  else if (randomPos == 2) {
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < coinAmount; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-180+(i*COIN_MAXIMUM_DISTANCE), -180);
        [self addChild:coin];
      }
    }
  }
  else if (randomPos == 3) {
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < coinAmount; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-40+(i*COIN_MINIMUM_DISTANCE), -60+(i*COIN_MINIMUM_DISTANCE));
        [self addChild:coin];
      }
    }
  }
}

- (void)spawnCoinsForegroundSix {
  randomPos = arc4random() % 4;
  if (randomPos == 0) {
    int random = arc4random() % 15;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MINIMUM_DISTANCE), 80);
      [self addChild:coin];
    }
  }
  else if (randomPos == 1) {
    for (int i = 0; i < coinAmount; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-200+(i*COIN_MAXIMUM_DISTANCE), -100);
      [self addChild:coin];
    }
  }
  else if (randomPos == 2) {
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < coinAmount; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-200+(i*COIN_MAXIMUM_DISTANCE), -20);
        [self addChild:coin];
      }
    }
  }
  else if (randomPos == 3) {
    int random  = arc4random() % 12;
    for (int i = 0; i < coinAmount; i++) {
      for (int i = 0; i < random; i++) {
        Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
        coin.position = CGPointMake(-80+(i*COIN_MINIMUM_DISTANCE), 0);
        [self addChild:coin];
      }
    }
  }
}

- (void)spawnCoinsForegroundSeven {
  randomPos = arc4random() % 2;
  if (randomPos == 0) {
    int random = arc4random() % 20;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-150+(i*COIN_MINIMUM_DISTANCE), 65);
      [self addChild:coin];
    }
  }
  else if (randomPos == 1) {
    int random = arc4random() % 20;
    for (int i = 0; i < random; i++) {
      Coin *coin = [[Coin alloc] initWithCoinType:[self getCoinType] andFrames:self.coinFrames];
      coin.position = CGPointMake(-150+(i*COIN_MINIMUM_DISTANCE), -80);
      [self addChild:coin];
    }
  }
}

- (CoinType)getCoinType {
  CoinType type = kTypeNormal;
  int random = arc4random() % 10;
  if (random == 0) {
    type = kTypePot;
  }
  return type;
}

- (void)drawForegroundOne {
  SKSpriteNode *n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 30)];
  n1.position = CGPointMake(0, 140);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(55, 25)];
  n1.position = CGPointMake(-133, 113);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(55, 25)];
  n1.position = CGPointMake(-133, 113);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(105, 25)];
  n1.position = CGPointMake(60, 113);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(70, 25)];
  n1.position = CGPointMake(70, 87);
  [self addChild:n1];

  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(40, 8)];
  n1.position = CGPointMake(-12, 122);
  [self addChild:n1];

  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 45)];
  n1.position = CGPointMake(0, -135);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(151, 80)];
  n1.position = CGPointMake(-79, -75);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(18, 30)];
  n1.position = CGPointMake(0, -98);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 20)];
  n1.position = CGPointMake(13, -105);
  [self addChild:n1];
  
  SKSpriteNode *n2 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(5, 14)];
  n2.position = CGPointMake(20, -107);
  [self addChild:n2];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(5, 14)];
  n1.position = CGPointMake(20, -107);
  [self addChild:n1];

  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(35, 10)];
  n1.position = CGPointMake(-136, -30);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(80, 30)];
  n1.position = CGPointMake(-60, -23);
  [self addChild:n1];

}

- (void)drawForegroundTwo {
  SKSpriteNode *n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 30)];
  n1.position = CGPointMake(0, 130);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 45)];
  n1.position = CGPointMake(0, -135);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(150, 40)];
  n1.position = CGPointMake(110, 53);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(5, 25)];
  n1.position = CGPointMake(32, 55);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(20, 5)];
  n1.position = CGPointMake(70, 32);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(150, 45)];
  n1.position = CGPointMake(-81, -57);

  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(110, 17)];
  n1.position = CGPointMake(-70, -30);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(15, 30)];
  n1.position = CGPointMake(-160,-55);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(25, 30)];
  n1.position = CGPointMake(-3, -56);
  [self addChild:n1];
}

- (void)drawForegroundThree {
  SKSpriteNode *n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 30)];
  n1.position = CGPointMake(0, 125);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 45)];
  n1.position = CGPointMake(0, -138);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(37, 40)];
  n1.position = CGPointMake(63, -95);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 15)];
  n1.position = CGPointMake(38, -108);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(26, 20)];
  n1.position = CGPointMake(61, -65);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(15, 7)];
  n1.position = CGPointMake(59, -53);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(50, 20)];
  n1.position = CGPointMake(28, 60);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 18)];
  n1.position = CGPointMake(69, 69);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 8)];
  n1.position = CGPointMake(38, 73);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(115, 20)];
  n1.position = CGPointMake(-57, -25);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(55, 12)];
  n1.position = CGPointMake(-83, -10);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(55, 6)];
  n1.position = CGPointMake(-40, -12);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(90, 15)];
  n1.position = CGPointMake(-67, -40);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(50, 8)];
  n1.position = CGPointMake(-76, -51);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 5)];
  n1.position = CGPointMake(-174, 106);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 10)];
  n1.position = CGPointMake(209, -111);
  [self addChild:n1];
  }

- (void)drawForegroundFour {
  SKSpriteNode *n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 30)];
  n1.position = CGPointMake(0, 127);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(20, 30)];
  n1.position = CGPointMake(76, 97);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(20, 30)];
  n1.position = CGPointMake(76, 97);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(110, 5)];
  n1.position = CGPointMake(-140, 110);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(35, 5)];
  n1.position = CGPointMake(-57, 110);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(25, 5)];
  n1.position = CGPointMake(168, 110);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 20)];
  n1.position = CGPointMake(-160, 100);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(40, 5)];
  n1.position = CGPointMake(-123, 105);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 30)];
  n1.position = CGPointMake(0, -126);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 15)];
  n1.position = CGPointMake(-113, -105);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(20, 3)];
  n1.position = CGPointMake(-138, -110);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(85, 4)];
  n1.position = CGPointMake(-55, -110);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 15)];
  n1.position = CGPointMake(-40, -101);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(40, 3)];
  n1.position = CGPointMake(-75, -107);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(15, 3)];
  n1.position = CGPointMake(15, -110);
  [self addChild:n1];

}

- (void)drawForegroundFive {
  SKSpriteNode *n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 25)];
  n1.position = CGPointMake(0, 143);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 25)];
  n1.position = CGPointMake(0, -123);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(80, 4)];
  n1.position = CGPointMake(110, -109);
  [self addChild:n1];
 
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(160, 3)];
  n1.position = CGPointMake(-110, -109);
  [self addChild:n1];
 
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(80, 4)];
  n1.position = CGPointMake(-145, -105);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(40, 4)];
  n1.position = CGPointMake(-155, -101);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(70, 38)];
  n1.position = CGPointMake(25, -92);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(35, 35)];
  n1.position = CGPointMake(35, -58);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(8, 15)];
  n1.position = CGPointMake(15, -65);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(50, 25)];
  n1.position = CGPointMake(-186, -3);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(90, 37)];
  n1.position = CGPointMake(-20, 28);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(28, 18)];
  n1.position = CGPointMake(-78, 20);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 10)];
  n1.position = CGPointMake(-70, 34);
  [self addChild:n1];
  
  n1 =[[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(40, 15)];
  n1.position = CGPointMake(-36, 5);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(25, 5)];
  n1.position = CGPointMake(-36, -5);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(20, 5)];
  n1.position =CGPointMake(-5, 8);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(145, 10)];
  n1.position = CGPointMake(-140, 125);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(280, 5)];
  n1.position = CGPointMake(73, 128);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(100, 55)];
  n1.position = CGPointMake(160, 100);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(70, 6)];
  n1.position = CGPointMake(75, 123);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(20, 10)];
  n1.position = CGPointMake(100, 118);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(70, 25)];
  n1.position = CGPointMake(-160, 108);
  [self addChild:n1];
}

- (void)drawForegroundSix {
  SKSpriteNode *n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 25)];
  n1.position = CGPointMake(0, 122);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(55, 3)];
  n1.position = CGPointMake(-128, 108);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 6)];
  n1.position = CGPointMake(84, 108);
  [self addChild:n1];
 
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 30)];
  n1.position = CGPointMake(0, -133);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(70, 5)];
  n1.position = CGPointMake(80, -117);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 10)];
  n1.position = CGPointMake(210, -113);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10,10)];
  n1.position = CGPointMake(-210, -113);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(65, 20)];
  n1.position = CGPointMake(-175, 8);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(55, 5)];
  n1.position = CGPointMake(-173, 20);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 7)];
  n1.position = CGPointMake(-173, 26);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(90, 30)];
  n1.position = CGPointMake(-95, -63);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(24, 3)];
  n1.position = CGPointMake(-95, -47);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(50, 6)];
  n1.position = CGPointMake(-95, -80);
  [self addChild:n1];
 
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 20)];
  n1.position = CGPointMake(-145, -60);
  [self addChild:n1];

  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(60, 15)];
  n1.position = CGPointMake(-60, 40);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 10)];
  n1.position = CGPointMake(-65, 30);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(15, 5)];
  n1.position = CGPointMake(-93, 45);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(65, 15)];
  n1.position = CGPointMake(65, 40);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(50, 15)];
  n1.position = CGPointMake(70, 30);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 5)];
  n1.position = CGPointMake(60, 20);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(15, 29)];
  n1.position = CGPointMake(27, 50);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(15, 20)];
  n1.position = CGPointMake(42, 53);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(20,10)];
  n1.position = CGPointMake(55, 53);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(40, 23)];
  n1.position = CGPointMake(42, -37);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 5)];
  n1.position = CGPointMake(20, -34);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(5, 5)];
  n1.position = CGPointMake(28, -50);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(38, 40)];
  n1.position = CGPointMake(160, 35);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(25, 8)];
  n1.position = CGPointMake(163, 13);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 30)];
  n1.position = CGPointMake(137, 40);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(13, 10)];
  n1.position = CGPointMake(118, 55);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(13, 10)];
  n1.position = CGPointMake(125, 48);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(70, 25)];
  n1.position = CGPointMake(100, -53);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(30, 10)];
  n1.position = CGPointMake(80, -38);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(40, 15)];
  n1.position = CGPointMake(80, -70);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 5)];
  n1.position = CGPointMake(90, -80);
  [self addChild:n1];
}

- (void)drawForegroundSeven {
  SKSpriteNode *n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 25)];
  n1.position = CGPointMake(0, 122);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(125, 7)];
  n1.position = CGPointMake(-110, 107);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(125, 6)];
  n1.position = CGPointMake(75, 107);
  [self addChild:n1];
 
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.foreground.size.width, 25)];
  n1.position = CGPointMake(0, -133);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(13, 13)];
  n1.position = CGPointMake(207, -115);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(18, 8)];
  n1.position = CGPointMake(-207, -117);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(130, 4)];
  n1.position = CGPointMake(60, -119);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(375, 27)];
  n1.position = CGPointMake(-5, 5);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(3, 10)];
  n1.position = CGPointMake(-193, 5);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(350, 4)];
  n1.position = CGPointMake(0, -10);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(220, 5)];
  n1.position = CGPointMake(35, -15);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(150, 5)];
  n1.position = CGPointMake(35, -20);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(100, 3)];
  n1.position = CGPointMake(43, -23);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(70, 4)];
  n1.position = CGPointMake(48, -26);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(350, 6)];
  n1.position = CGPointMake(-10, 21);
  [self addChild:n1];
  
  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)];
  n1.position = CGPointMake(-20, 25);
  [self addChild:n1];

  n1 = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(120, 3)];
  n1.position = CGPointMake(-100, 28);
  [self addChild:n1];
}

- (void)setCoinCollision {
  for (Coin *coin in self.children) {
    coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.coin.size.width];
    coin.physicsBody.dynamic = NO;
    coin.physicsBody.categoryBitMask = DDColliderTypeCoin;
    coin.physicsBody.collisionBitMask = DDColliderTypeDragon;
    coin.physicsBody.contactTestBitMask = DDColliderTypeDragon;
  }
}

- (void)setCollision {
  for (SKSpriteNode *rectangles in self.children) {
    if (![rectangles.name isEqualToString:@"Original"]) {
      rectangles.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rectangles.size.width-5, rectangles.size.height-5)];
      rectangles.physicsBody.dynamic = NO;
      rectangles.physicsBody.categoryBitMask = DDColliderTypeForeground;
      rectangles.physicsBody.collisionBitMask = DDColliderTypeDragon;
      rectangles.physicsBody.contactTestBitMask = DDColliderTypeDragon;
    }
  }
}

@end

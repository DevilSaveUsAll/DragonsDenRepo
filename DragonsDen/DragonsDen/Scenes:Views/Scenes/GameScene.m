//
//  GameScene.m
//  DragonsDen
//
//  Created by Danny on 11/4/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "GameScene.h"
#import "Dragon.h"
#import "FMMParallaxNode.h"
#import "PowerUp.h"
#import "Sound.h"
#import "GameState.h"
#import "FacebookManager.h"

#define FONT_SIZE 17
#define BUTTON_WIDTH 10
#define PAUSE_SCREEN_TAG 20

@implementation GameScene {
  FMMParallaxNode *backgroundOne;
  FMMParallaxNode *backgroundTwo;
  CGSize winSize;
  CGFloat backgroundOneSpeed;
  CGFloat backgroundTwoSpeed;
  DeathScreen *deathScreen;
  int foregroundSpeed;
  int previousSpeed;
  int postCount;
  float idleTime;
  
  BOOL gliding;
  BOOL dead;
  BOOL touched;
  BOOL speeding;
}

- (id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    winSize = size;
  }
  return self;
}

- (void)setUpPhysicsWorld {
  self.physicsWorld.gravity = CGVectorMake(0, 0);
  self.physicsWorld.contactDelegate = self;
}

- (void)setUpParallaxBG {
  backgroundOneSpeed = 15.0f;
  backgroundTwoSpeed = 10.0f;
  SKSpriteNode *sprite = [[SKSpriteNode alloc] initWithImageNamed:@"BlueBG@2x.png"];
  [self addChild:sprite];
  
  NSArray *parallaxBackgroundNames = @[@"BG1_1@2x.png", @"BG1_2@2x.png"];
  UIImage *image = [UIImage imageNamed:@"BG1_1@2x.png"];
  CGSize bgSize = CGSizeMake(image.size.width/2, image.size.height/2);
  
  backgroundOne = [[FMMParallaxNode alloc] initWithBackgrounds:parallaxBackgroundNames size:bgSize pointsPerSecondSpeed:backgroundOneSpeed];
  
  parallaxBackgroundNames = @[@"BG2_1@2x.png", @"BG2_2@2x.png"];
  image = [UIImage imageNamed:@"BG2_1@2x.png"];
  bgSize = CGSizeMake(image.size.width/2, image.size.height/2);
  backgroundTwo = [[FMMParallaxNode alloc] initWithBackgrounds:parallaxBackgroundNames size:bgSize pointsPerSecondSpeed:backgroundTwoSpeed];
  [self addChild:backgroundOne];
  [self addChild:backgroundTwo];
  
  SKSpriteNode *transparent = [[SKSpriteNode alloc] initWithImageNamed:@"TransparencyBG@2x.png"];
  [self addChild:transparent];
}

- (void)addCoinFrame:(NSMutableArray *)frames {
  self.coinFrames = frames;
  [self setUpPhysicsWorld];
  [self setUpParallaxBG];
  [self addForegroundPieces];
  
  self.dragon = [[Dragon alloc] init];
  self.dragon.position = CGPointMake(160, 160);
  self.dragon.dragon.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.dragon.dragon.size.width/2, self.dragon.dragon.size.height/2-10)];
  self.dragon.dragon.physicsBody.dynamic = YES;
  self.dragon.dragon.physicsBody.categoryBitMask = DDColliderTypeDragon;
  self.dragon.dragon.physicsBody.collisionBitMask = DDColliderTypeBat | DDColliderTypeBat | DDColliderTypeForeground;
  self.dragon.dragon.physicsBody.contactTestBitMask = DDColliderTypeForeground;
  self.flyingState = kFlapping;
  self.dragon.powerUpState = kNormal;
  [self addChild:self.dragon];
  gliding = NO;
  
  foregroundSpeed = 2;
  previousSpeed = 0;
  
  [self addStatsHud];
}

- (void)update:(NSTimeInterval)currentTime {
  idleTime += 0.01;
  if (idleTime > 1.0) {
    [self glide];
  }
  if (!backgroundOne) [backgroundOne update:currentTime];
  if (!backgroundTwo) [backgroundTwo update:currentTime];

  self.foregroundOne.position = CGPointMake(self.foregroundOne.position.x-foregroundSpeed, self.foregroundOne.position.y);
  self.foregroundTwo.position = CGPointMake(self.foregroundTwo.position.x-foregroundSpeed, self.foregroundTwo.position.y);
  self.foregroundThree.position = CGPointMake(self.foregroundThree.position.x-foregroundSpeed, self.foregroundTwo.position.y);

  if (self.foregroundOne.position.x < -self.foregroundOne.foreground.size.width/2) {
    [self repositionForegroundOne];
  }
  
  if (self.foregroundTwo.position.x < -self.foregroundTwo.foreground.size.width/2) {
    [self repositionForegroundTwo];
  }

  if (self.foregroundThree.position.x < -self.foregroundThree.foreground.size.width/2) {
    [self repositionForegroundThree];
  }
}

- (void)glide {
  self.flyingState = kGliding;
  if (!gliding) [self.dragon switchAnimation:self.flyingState];
  else  self.dragon.position = CGPointMake(self.dragon.position.x, self.dragon.position.y-1);
  gliding = YES;
}

- (void)pumpDragon {
  gliding = NO;
  idleTime = 0.0f;
  self.flyingState = kFlapping;
  [self.dragon switchAnimation:self.flyingState];
  [self.dragon runAction:[SKAction moveToY:self.dragon.position.y+10 duration:0.2f] completion:^{
    [self.dragon switchAnimation:kIdle];
  }];
}

- (void)death {
  dead = YES;
  self.dragon.powerUpState = kNormal;
  [self.dragon switchAnimation:kDied];
  [self addDeathScreen];
  
  previousSpeed = foregroundSpeed;
  foregroundSpeed = 0;
  backgroundOne.pointsPerSecondSpeed = 0.0f;
  backgroundTwo.pointsPerSecondSpeed = 0.0f;
}

- (void)addDeathScreen {
  deathScreen = [[DeathScreen alloc] initWithDistance:1000 gold:1000];
  deathScreen.position = CGPointMake(winSize.width/2, winSize.height/2);
  deathScreen.delegate = self;
  [self addChild:deathScreen];
}

- (void)removeDeathScreen {

}

- (void)mapSlow {
  
}

#pragma mark - Touch Delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (!dead) {
    touched = YES;
  }
}

#define MINIMUM_X 20
#define MINIMUM_Y 20

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if (touched) {
    [self pumpDragon];
  }
}

- (void)speedTowardsDirection:(SwipeDirections)direction {
  speeding = YES;
  self.flyingState = kSpeed;
  idleTime = 0;
  [self.dragon switchAnimation:kSpeed];
  if (direction == kDirectionUp) {
    [self.dragon runAction:[SKAction moveToY:self.dragon.position.y+25 duration:0.3f] completion:^{
      speeding = NO;
    }];
  }
  else if (direction == kDirectionRight) {
    [self.dragon runAction:[SKAction moveToX:self.dragon.position.x+25 duration:0.3f] completion:^{
      speeding = NO;
    }];
  }
  else if (direction == kDirectiondiagonalDown) {
    
  }
  else if (direction == kDirectionDiagonalUp) {
    
  }
  else if (direction == kDirectionDown) {
    [self.dragon runAction:[SKAction moveToY:self.dragon.position.y-25 duration:0.3f] completion:^{
      speeding = NO;
    }];
  }
  else if (direction == kDirectionLeft) {
    [self.dragon runAction:[SKAction moveToX:self.dragon.position.x-25 duration:0.3f] completion:^{
      speeding = NO;
    }];
  }
}

#pragma mark - HUD Setup

- (void)addStatsHud {
  self.mayhemPowerUp = [[PowerUp alloc] initWithType:kTypeMayhem];
  self.mayhemPowerUp.position = CGPointMake(winSize.width-self.mayhemPowerUp.powerUpSprite.size.width/2 - BUTTON_WIDTH, self.mayhemPowerUp.powerUpSprite.size.height/2);
  [self.mayhemPowerUp animatePowerUp];
  [self addChild:self.mayhemPowerUp];
  
  self.slowPowerUp = [[PowerUp alloc] initWithType:kTypeSlow];
  self.slowPowerUp.position = CGPointMake(self.mayhemPowerUp.position.x - self.slowPowerUp.powerUpSprite.size.width - BUTTON_WIDTH, self.mayhemPowerUp.frame.origin.y);
  [self.slowPowerUp animatePowerUp];
  [self addChild:self.slowPowerUp];
  
  self.armorPowerUp = [[PowerUp alloc] initWithType:kTypeArmor];
  self.armorPowerUp.position = CGPointMake(self.slowPowerUp.position.x - self.slowPowerUp.powerUpSprite.size.width - BUTTON_WIDTH, self.mayhemPowerUp.frame.origin.y);
  [self.armorPowerUp animatePowerUp];
  [self addChild:self.armorPowerUp];
  
  self.mayhemPowerUp.amount = 5;
  self.slowPowerUp.amount = 5;
  self.armorPowerUp.amount = 5;
  
}

- (void)putPowerupFirst {
  self.mayhemPowerUp.zPosition = 100;
  self.armorPowerUp.zPosition = 100;
  self.slowPowerUp.zPosition = 100;
  self.dragon.zPosition = 100;
}

#pragma mark - Pause

- (void)pauseGame {
  dead = YES;
  previousSpeed = foregroundSpeed;
  foregroundSpeed = 0;
  backgroundOne.pointsPerSecondSpeed = 0;
  backgroundTwo.pointsPerSecondSpeed = 0;
}

- (void)resumeGame {
  self.paused = NO;
  foregroundSpeed = previousSpeed;
  previousSpeed = 0;
  backgroundOne.pointsPerSecondSpeed = backgroundOneSpeed;
  backgroundTwo.pointsPerSecondSpeed = backgroundTwoSpeed;
}

#pragma mark - Death Delegate

- (void)share {
  if (postCount > 0) {
    if ([self.delegate respondsToSelector:@selector(showPopUp:)]) {
      [self.delegate showPopUp:kFacebookWallPost];
    }
    return;
  }
  FacebookManager *fb = [[FacebookManager alloc] init];
  [fb postToWall];
  postCount++;
}

- (void)continueGame {
  dead = NO;
}

- (void)restart {
  if ([self.delegate respondsToSelector:@selector(restartGame)]) {
    [self.delegate restartGame];
  }
  backgroundOne = nil;
  backgroundTwo = nil;
}

#pragma mark - Powerup methods

- (void)useArmor {
  if (self.armorPowerUp.amount > 0) {
    self.armorPowerUp.amount -= 1;
    self.dragon.powerUpState = kArmor;
    [self.dragon switchAnimation:self.flyingState];
  }
}

- (void)useSlow {
  if (self.slowPowerUp.amount > 0) {
    self.slowPowerUp.amount -= 1;
    [self mapSlow];
  }
}

- (void)useMayhem {
  if (self.mayhemPowerUp.amount > 0) {
    self.mayhemPowerUp.amount -= 1;
    self.dragon.powerUpState = kMayhem;
    [self.dragon switchAnimation:self.flyingState];
  }
}

- (void)removeObjects {
  [self.dragon removeAllActions];
  [self.slowPowerUp removeAllActions];
  [self.armorPowerUp removeAllActions];
  [self.mayhemPowerUp removeAllActions];
  [self removeAllChildren];
}

#pragma mark - Foreground Methods

- (void)addForegroundPieces {
  ForeGroundType type = (arc4random() % 7) + 1;
  self.foregroundOne = [[Foregrounds alloc] initWithCurrentPiece:type andCoinFrames:self.coinFrames];
  self.foregroundOne.position = CGPointMake(self.foregroundOne.foreground.size.width/2, self.foregroundOne.foreground.size.height/2);
  [self addChild:self.foregroundOne];

  self.foregroundTwo = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundOne.currentPiece andCoinFrames:self.coinFrames];
  self.foregroundTwo.position = CGPointMake(self.foregroundOne.foreground.size.width/2+self.foregroundTwo.foreground.size.width-2, self.foregroundTwo.foreground.size.height/2);
  [self addChild:self.foregroundTwo];
  
  self.foregroundThree = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundThree.currentPiece andCoinFrames:self.coinFrames];
  self.foregroundThree.position = CGPointMake(self.foregroundTwo.position.x+self.foregroundThree.foreground.size.width-2, self.foregroundThree.foreground.size.height/2);
  [self addChild:self.foregroundThree];
}

- (void)repositionForegroundOne {
  [self.foregroundOne removeFromParent];
  self.foregroundOne = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundThree.currentPiece andCoinFrames:self.coinFrames];
  self.foregroundOne.position = CGPointMake(self.foregroundThree.position.x+self.foregroundOne.foreground.size.width-2, self.foregroundThree.position.y);
  [self addChild:self.foregroundOne];
  [self putPowerupFirst];
}

- (void)repositionForegroundTwo {
  [self.foregroundTwo removeFromParent];
  self.foregroundTwo = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundOne.currentPiece andCoinFrames:self.coinFrames];
  self.foregroundTwo.position = CGPointMake(self.foregroundOne.position.x+self.foregroundOne.foreground.size.width-2, self.foregroundOne.position.y);
  [self addChild:self.foregroundTwo];
  [self putPowerupFirst];
}

- (void)repositionForegroundThree {
  [self.foregroundThree removeFromParent];
  self.foregroundThree = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundTwo.currentPiece andCoinFrames:self.coinFrames];
  self.foregroundThree.position = CGPointMake(self.foregroundTwo.position.x+self.foregroundThree.foreground.size.width-2, self.foregroundOne.position.y);
  [self addChild:self.foregroundThree];
  [self putPowerupFirst];
}

#pragma mark - Contact Delegate

- (void)didBeginContact:(SKPhysicsContact *)contact {
  SKNode *aNode = contact.bodyA.node;
  SKNode *bNode = contact.bodyB.node;

  if (aNode.physicsBody.categoryBitMask == DDColliderTypeForeground && bNode.physicsBody.categoryBitMask == DDColliderTypeDragon) {
    [self death];
  }
  
}

@end

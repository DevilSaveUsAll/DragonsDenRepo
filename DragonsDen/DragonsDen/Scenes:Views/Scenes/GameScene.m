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
#import "Definitions.h"

#define FONT_SIZE 17
#define BUTTON_WIDTH 10
#define PAUSE_SCREEN_TAG 20
#define MAX_FOREGROUND_SPEED 10
#define SPEED_INTERVAL 50
#define SLOW_DURATION 20
#define INITIAL_FOREGROUND_SPEED 1.0f

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
  
  float timeElapsed;
  float idleTime;
  float slowDuration;
  
  BOOL gliding;
  BOOL touched;
  BOOL speeding;
  BOOL slowed;
  BOOL distanceLabelMoved;
}

- (id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    winSize = size;
    [self setUpGame];
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

- (void)setUpGame {
  self.coinFrames = [NSMutableArray array];
  self.batFrames = [NSMutableArray array];
  
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"CoinNormal"];
  NSUInteger numImage = atlas.textureNames.count;
  for (int i = 0; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Coin%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [self.coinFrames addObject:temp];
  }
  
  atlas = [SKTextureAtlas atlasNamed:@"BatAnimation"];
  numImage = atlas.textureNames.count;
  for (int i = 1; i <=numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Bat%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [self.batFrames addObject:temp];
  }
  
  self.deathFrames = [NSMutableArray array];
  atlas = [SKTextureAtlas atlasNamed:@"Smoke"];
  numImage = atlas.textureNames.count;
  
  for (int i = 10; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"smoke%0.4d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [self.deathFrames addObject:temp];
  }
  
  [self setUpPhysicsWorld];
  [self setUpParallaxBG];
  [self addForegroundPieces];
  
  self.dragon = [[Dragon alloc] init];
  [self setDragonStartingPosition];
  self.dragon.dragon.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.dragon.dragon.size.width/2, self.dragon.dragon.size.height/2-10)];
  self.dragon.dragon.physicsBody.dynamic = YES;
  self.dragon.dragon.physicsBody.categoryBitMask = DDColliderTypeDragon;
  self.dragon.dragon.physicsBody.collisionBitMask = DDColliderTypeBat | DDColliderTypeBat | DDColliderTypeForeground;
  self.dragon.dragon.physicsBody.contactTestBitMask = DDColliderTypeForeground;
  self.flyingState = kFlapping;
  self.dragon.powerUpState = kNormal;
  [self addChild:self.dragon];
  gliding = NO;
  
  foregroundSpeed = INITIAL_FOREGROUND_SPEED;
  previousSpeed = 0;
  
  [self addStatsHud];
  self.statsHud = [[StatsHud alloc] init];
  self.statsHud.delegate = self;
  [self addChild:self.statsHud];
}

- (void)setDragonStartingPosition {
  switch (self.foregroundOne.currentPiece) {
    case kForegroundOne:
      self.dragon.position = CGPointMake(160, 190);
      break;
    case kForegroundTwo:
      self.dragon.position = CGPointMake(160, 190);
      break;
    case kForegroundThree:
      self.dragon.position = CGPointMake(160, 190);
      break;
    case kForegroundFour:
      self.dragon.position = CGPointMake(160, 190);
      break;
    case kForegroundFive:
      self.dragon.position = CGPointMake(70, 220);
      break;
    case kForegroundSix:
      self.dragon.position = CGPointMake(90, 140);
      break;
    case kForegroundSeven:
      self.dragon.position = CGPointMake(160, 210);
      break;
  }
}

- (void)moveDistanceLabel {
  if (self.distance >= 100 && self.distance < 1000 && !distanceLabelMoved) {
    self.statsHud.distanceLabel.position = CGPointMake(self.statsHud.distanceLabel.position.x + 5, self.statsHud.distanceLabel.position.y);
    distanceLabelMoved = YES;
  }
  else if (self.distance >= 1000 && self.distance < 10000 && distanceLabelMoved) {
    self.statsHud.distanceLabel.position = CGPointMake(self.statsHud.distanceLabel.position.x + 5, self.statsHud.distanceLabel.position.y);
    distanceLabelMoved = NO;
  }
  else if (self.distance >= 10000 && self.distance < 100000 && !distanceLabelMoved) {
    self.statsHud.distanceLabel.position = CGPointMake(self.statsHud.distanceLabel.position.x + 5, self.statsHud.distanceLabel.position.y);
    distanceLabelMoved = YES;
  }
}

- (void)update:(NSTimeInterval)currentTime {
  idleTime += 0.01;
  timeElapsed += 0.01;
  self.distance += 1;
  
  if (idleTime > 1.0) {
    [self glide];
  }
  
  [self moveDistanceLabel];
  
  if (timeElapsed > SPEED_INTERVAL && !slowed) {
    timeElapsed = 0;
    foregroundSpeed += 1;
    if (foregroundSpeed > MAX_FOREGROUND_SPEED) {
      foregroundSpeed = MAX_FOREGROUND_SPEED;
    }
  }
  
  if (slowed) {
    slowDuration += 0.1;
    if (slowDuration >= SLOW_DURATION) {
      slowDuration = 0;
      slowed = NO;
    }
  }
  
  if (!self.dead) {
    [self.statsHud updateDistance:self.distance];
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
}

- (void)glide {
  self.flyingState = kGliding;
  if (!gliding) [self.dragon switchAnimation:self.flyingState];
  else  self.dragon.position = CGPointMake(self.dragon.position.x, self.dragon.position.y-1);
  gliding = YES;
}

- (void)pumpDragon {
  if (self.dead) return;
  gliding = NO;
  idleTime = 0.0f;
  self.flyingState = kFlapping;
  [self.dragon switchAnimation:self.flyingState];
  [self.dragon runAction:[SKAction moveToY:self.dragon.position.y+10 duration:0.2f] completion:^{
    [self.dragon switchAnimation:kIdle];
  }];
}

- (void)death {
  self.dead = YES;
  [[Sound sharedSound] playSoundEffect:kDead];
  self.dragon.powerUpState = kNormal;
  [self.dragon switchAnimation:kDied];
  [self addDeathScreen];
  
  previousSpeed = foregroundSpeed;
  foregroundSpeed = 0;
  backgroundOne.pointsPerSecondSpeed = 0.0f;
  backgroundTwo.pointsPerSecondSpeed = 0.0f;
}

- (void)addDeathScreen {
  GameState *gs = [GameState sharedGameState];
  deathScreen = [[DeathScreen alloc] initWithDistance:self.distance gold:gs.gold];
  deathScreen.position = CGPointMake(winSize.width/2, winSize.height/2);
  deathScreen.delegate = self;
  [self addChild:deathScreen];
}

- (void)removeDeathScreen {
  [deathScreen removeFromParent];
  deathScreen.delegate = nil;
}

- (void)mapSlow {
  if (slowed) return;
  if (self.slowPowerUp.amount == 0) return;
  
  slowed = YES;
  foregroundSpeed = INITIAL_FOREGROUND_SPEED;
}

#pragma mark - Touch Delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  touched = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if (touched) {
    [self pumpDragon];
  }
}

- (void)speedTowardsDirection:(SwipeDirections)direction {
  [[Sound sharedSound] playSoundEffect:kSpeedBoost];
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
  
  self.mayhemPowerUp.amount = [[NSUserDefaults standardUserDefaults] integerForKey:MayhemCount];
  self.slowPowerUp.amount = [[NSUserDefaults standardUserDefaults] integerForKey:SlowCount];
  self.armorPowerUp.amount = [[NSUserDefaults standardUserDefaults] integerForKey:ArmorCount];
}

- (void)putPowerupFirst {
  self.mayhemPowerUp.zPosition = 100;
  self.armorPowerUp.zPosition = 100;
  self.slowPowerUp.zPosition = 100;
  self.dragon.zPosition = 100;
  self.statsHud.zPosition = 100;
}

#pragma mark - Pause

- (void)pauseGame {
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
  self.dead = NO;
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
  if (self.armorPowerUp.amount > 0 && self.dragon.powerUpState != kArmor && self.dragon.powerUpState != kMayhem) {
    [[Sound sharedSound] playSoundEffect:kPowerUp];
    self.armorPowerUp.amount -= 1;
    [[NSUserDefaults standardUserDefaults] setInteger:self.armorPowerUp.amount forKey:ArmorCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.dragon.powerUpState = kArmor;
    [self.dragon switchAnimation:self.flyingState];
  }
}

- (void)useSlow {
  if (self.slowPowerUp.amount > 0 && !slowed) {
    [[Sound sharedSound] playSoundEffect:kPowerUp];
    self.slowPowerUp.amount -= 1;
    [[NSUserDefaults standardUserDefaults] setInteger:self.slowPowerUp.amount forKey:SlowCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self mapSlow];
  }
}

- (void)useMayhem {
  if (self.mayhemPowerUp.amount > 0 && self.dragon.powerUpState != kMayhem && self.dragon.powerUpState != kArmor) {
    [[Sound sharedSound] playSoundEffect:kPowerUp];
    self.mayhemPowerUp.amount -= 1;
    [[NSUserDefaults standardUserDefaults] setInteger:self.mayhemPowerUp.amount forKey:MayhemCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
  self.foregroundOne = [[Foregrounds alloc] initWithCurrentPiece:type andCoinFrames:self.coinFrames batFrames:self.batFrames deathFrames:self.deathFrames];
  self.foregroundOne.position = CGPointMake(self.foregroundOne.foreground.size.width/2, self.foregroundOne.foreground.size.height/2);
  [self addChild:self.foregroundOne];
  
  self.foregroundTwo = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundOne.currentPiece andCoinFrames:self.coinFrames batFrames:self.batFrames deathFrames:self.deathFrames  ];
  self.foregroundTwo.position = CGPointMake(self.foregroundOne.foreground.size.width/2+self.foregroundTwo.foreground.size.width-2, self.foregroundTwo.foreground.size.height/2);
  [self addChild:self.foregroundTwo];
  
  self.foregroundThree = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundThree.currentPiece andCoinFrames:self.coinFrames batFrames:self.batFrames deathFrames:self.deathFrames];
  self.foregroundThree.position = CGPointMake(self.foregroundTwo.position.x+self.foregroundThree.foreground.size.width-2, self.foregroundThree.foreground.size.height/2);
  [self addChild:self.foregroundThree];

}

- (void)repositionForegroundOne {
  self.foregroundOne = nil;
  [self.foregroundOne removeFromParent];
  self.foregroundOne = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundThree.currentPiece andCoinFrames:self.coinFrames batFrames:self.batFrames deathFrames:self.deathFrames];
  self.foregroundOne.position = CGPointMake(self.foregroundThree.position.x+self.foregroundOne.foreground.size.width-2, self.foregroundThree.position.y);
  [self addChild:self.foregroundOne];
  [self putPowerupFirst];
}

- (void)repositionForegroundTwo {
  self.foregroundTwo = nil;
  [self.foregroundTwo removeFromParent];
  self.foregroundTwo = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundOne.currentPiece andCoinFrames:self.coinFrames batFrames:self.batFrames deathFrames:self.deathFrames];
  self.foregroundTwo.position = CGPointMake(self.foregroundOne.position.x+self.foregroundOne.foreground.size.width-2, self.foregroundOne.position.y);
  [self addChild:self.foregroundTwo];
  [self putPowerupFirst];
}

- (void)repositionForegroundThree {
  self.foregroundThree = nil;
  [self.foregroundThree removeFromParent];
  self.foregroundThree = [[Foregrounds alloc] initWithCurrentPiece:self.foregroundTwo.currentPiece andCoinFrames:self.coinFrames batFrames:self.batFrames deathFrames:self.deathFrames];
  self.foregroundThree.position = CGPointMake(self.foregroundTwo.position.x+self.foregroundThree.foreground.size.width-2, self.foregroundOne.position.y);
  [self addChild:self.foregroundThree];
  [self putPowerupFirst];
}

#pragma mark - Stats Delegate

- (void)pause {  
  if ([self.delegate respondsToSelector:@selector(pauseGame)]) {
    [self.delegate pauseGame];
  }
}

#pragma mark - Contact Delegate

- (void)didBeginContact:(SKPhysicsContact *)contact {
  SKNode *aNode = contact.bodyA.node;
  SKNode *bNode = contact.bodyB.node;
  
  if (aNode.physicsBody.categoryBitMask == DDColliderTypeDragon) {
    if (bNode.physicsBody.categoryBitMask == DDColliderTypeForeground) {
      [self death];
    }
    else if (bNode.physicsBody.categoryBitMask == DDColliderTypeCoin) {
      [self collectCoin:bNode];
    }
    else if (bNode.physicsBody.categoryBitMask == DDColliderTypeBat) {
      [self hitBat:bNode];
    }
  }
  else {
    if (aNode.physicsBody.categoryBitMask == DDColliderTypeForeground) {
      [self death];
    }
    else if (aNode.physicsBody.categoryBitMask == DDColliderTypeCoin) {
      [self collectCoin:aNode];
    }
    else if (aNode.physicsBody.categoryBitMask == DDColliderTypeBat) {
      [self hitBat:aNode];
    }
  }
}

- (void)collectCoin:(SKNode *)node {
  [[Sound sharedSound] playSoundEffect:kCollectingGold];
  Coin *coin = (Coin *)node;
  [self.statsHud updateGold:coin];
  [node removeFromParent];
  node = nil;
}

- (void)hitBat:(SKNode *)batNode {
  if (self.dragon.powerUpState == kArmor) {
    self.dragon.powerUpState = kNormal;
    [batNode removeFromParent];
    batNode = nil;
    [self.dragon switchAnimation:kIdle];
    [[Sound sharedSound] playSoundEffect:kBatDeath];
    return;
  }
  
  if (speeding) {
    [batNode removeFromParent];
    batNode = nil;
    [[Sound sharedSound] playSoundEffect:kBatDeath];
  }
  else {
    [self death];
  }
}

@end

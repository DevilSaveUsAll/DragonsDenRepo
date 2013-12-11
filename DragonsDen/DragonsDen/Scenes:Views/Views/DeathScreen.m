//
//  DeathScreen.m
//  DragonsDen
//
//  Created by Danny on 11/14/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "DeathScreen.h"
#import "GameState.h"
#import "SKButton.h"

@implementation DeathScreen

- (id)initWithDistance:(int)progress gold:(int)goldAmount {
  if ((self = [super init])) {
    SKSpriteNode *deathbg = [SKSpriteNode spriteNodeWithImageNamed:@"DeathScreenMain.png"];
    SKSpriteNode *youAreDead = [SKSpriteNode spriteNodeWithImageNamed:@"YouAreDead.png"];
    youAreDead.position = CGPointMake(0, 70);
    [self addChild:deathbg];
    [self addChild:youAreDead];
    
    SKButton *restartButton = [[SKButton alloc] initWithImageNamedNormal:@"Restart.png" selected:nil];
    [restartButton setTouchUpInsideTarget:self action:@selector(restartGame)];
    restartButton.position = CGPointMake(45, -75);
    [self addChild:restartButton];
    
    SKButton *reverseButton = [[SKButton alloc] initWithImageNamedNormal:@"ClockText.png" selected:nil];
    reverseButton.position = CGPointMake(45, -45);
    [reverseButton setTouchUpInsideTarget:self action:@selector(continueCurrentGame)];
    [self addChild:reverseButton];
    
    SKButton *facebookShare = [[SKButton alloc] initWithImageNamedNormal:@"FacebookShare.png" selected:nil];
    [facebookShare setTouchUpInsideTarget:self action:@selector(shareFacebook)];
    facebookShare.position = CGPointMake(-75, -65);
    [self addChild:facebookShare];
    
    SKLabelNode *distance = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    distance.text = [NSString stringWithFormat:@"Distance:"];
    distance.fontSize = 13;
    distance.position = CGPointMake(-75, 35);
    [self addChild:distance];
    
    SKLabelNode *gold = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    gold.text = @"Gold:";
    gold.fontSize = 13;
    gold.position = CGPointMake(-75, 12);
    [self addChild:gold];

    self.distanceLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    self.distanceLabel.text = [NSString stringWithFormat:@"%d",progress];
    self.distanceLabel.fontSize = 13;
    self.distanceLabel.position = CGPointMake(-30, 35);
    [self addChild:self.distanceLabel];
    
    self.goldLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    self.goldLabel.text = [NSString stringWithFormat:@"%d",goldAmount];
    self.goldLabel.fontSize = 13;
    self.goldLabel.position = CGPointMake(-30, 12);
    [self addChild:self.goldLabel];
    
    [self addClock];
    [self animateClock];
  }
  return self;
}

- (void)restartGame {
  if ([self.delegate respondsToSelector:@selector(restart)]) {
    [self.delegate restart];
  }
}

- (void)continueCurrentGame {
  if ([self.delegate respondsToSelector:@selector(continueGame)]) {
    [self.delegate continueGame];
  }
}

- (void)shareFacebook{
  if ([self.delegate respondsToSelector:@selector(share)]) {
    [self.delegate share];
  }
}

- (void)addClock {
  clockFrames = [NSMutableArray array];
  clockGlowFrames = [NSMutableArray array];
  
  NSString *prefix = @"Clock";
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:prefix];
  NSUInteger numImage = atlas.textureNames.count;
  
  for (int i = 0; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"clock%0.4d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [clockFrames addObject:temp];
  }
  
  clockSprite = [SKSpriteNode spriteNodeWithTexture:clockFrames[0]];
  clockSprite.position = CGPointMake(50,10);
  [self addChild:clockSprite];
  [self animateClock];
}

- (void)animateClock {
  [clockSprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:clockFrames timePerFrame:0.1f resize:NO restore:YES]] withKey:@"clockAnimation"];
}


@end

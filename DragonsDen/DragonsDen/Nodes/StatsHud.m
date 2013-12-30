//
//  StatsHud.m
//  DragonsDen
//
//  Created by Danny on 12/17/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "StatsHud.h"
#import "GameState.h"
#import "Definitions.h"
#import "Globals.h"
#import "Sound.h"

@implementation StatsHud

- (id)init {
  if ((self = [super init])) {
    GameState *gs = [GameState sharedGameState];

    self.distanceLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    self.distanceLabel.text = @"0";
    self.distanceLabel.fontSize = 13;
    [self addChild:self.distanceLabel];
    
    self.goldLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    self.goldLabel.text = [NSString stringWithFormat:@"%d",gs.gold];
    self.goldLabel.fontSize = 13;
    [self addChild:self.goldLabel];
    
    SKSpriteNode *coinImage = [SKSpriteNode spriteNodeWithImageNamed:@"Coin00.png"];
    [self addChild:coinImage];
    
    SKSpriteNode *distanceImage = [SKSpriteNode spriteNodeWithImageNamed:@"DistanceIcon.png"];
    [self addChild:distanceImage];
    
    BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
    
    self.musicButton = [[SKButton alloc] initWithImageNamedNormal:@"MusicNoteOFF.png" selected:nil disabled:@"MusicNoteON.png"];
    [self.musicButton setTouchUpInsideTarget:self action:@selector(musicClicked)];
    SKButton *pauseButton = [[SKButton alloc] initWithImageNamedNormal:@"PauseIcon.png" selected:nil];
    [pauseButton setTouchUpInsideTarget:self action:@selector(pauseClicked)];
        
    if (musicOn) self.musicButton.isMusicOn = NO;
    [self addChild:self.musicButton];
    [self addChild:pauseButton];
    
    coinImage.size = CGSizeMake(coinImage.size.width/2, coinImage.size.height/2);
    coinImage.position = CGPointMake(15, 280);
    distanceImage.position = CGPointMake(15, 305);
    self.distanceLabel.position = CGPointMake(35, 300);
    self.goldLabel.position = CGPointMake(40, 275);
    
    pauseButton.position = CGPointMake(568-pauseButton.size.width/2, 320-pauseButton.size.height/2);
    self.musicButton.position = CGPointMake(568-pauseButton.size.width/2-self.musicButton.size.width+20, 320-self.musicButton.size.height/4);
    
  }
  return self;
}

- (void)musicClicked {
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
  if (musicOn) {
    self.musicButton.isMusicOn = YES;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Music];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[Sound sharedSound] stopMusic];
  }
  else {
    self.musicButton.isMusicOn = NO;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Music];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[Sound sharedSound] playNextSong];
  }
}

- (void)pauseClicked {
  if ([self.delegate respondsToSelector:@selector(pause)]) {
    [self.delegate pause];
  }
}

- (void)updateDistance:(int)distance {
  self.distanceLabel.text = [NSString stringWithFormat:@"%d",distance];
}

- (void)updateGold:(Coin *)gold {
  GameState *gs = [GameState sharedGameState];
  gs.gold += gold.goldValue;
  self.goldLabel.text = [NSString stringWithFormat:@"%d",gs.gold];
  [[Globals sharedGlobals] updateGold];
}

@end

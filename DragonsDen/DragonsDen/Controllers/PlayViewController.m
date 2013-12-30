//
//  PlayViewController.m
//  DragonsDen
//
//  Created by Danny on 11/3/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "PlayViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "PlayScene.h"
#import "Sound.h"
#import "GameState.h"
#import "Definitions.h"
#import "Dragon.h"
#import "Globals.h"

#define ARMOR_COST 150000
#define SLOW_COST 75000
#define MAYHEM_COST 300000

@implementation PlayViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
  if (!musicOn) [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteOFF.png"] forState:UIControlStateNormal];
  
  GameState *gs = [GameState sharedGameState];
  self.goldLabel.text = [NSString stringWithFormat:@"%d",gs.gold];
}

- (void)viewDidLayoutSubviews {
  SKView *skView = (SKView *)self.view;
  if (!skView.scene) {
    PlayScene *playScene = [[PlayScene alloc] initWithSize:CGSizeMake(568, 320)];
    playScene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:playScene.scene];
  }
}

- (NSArray *)getPreloadedArray {
  NSMutableArray *tempArray = [NSMutableArray array];
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"CoinNormal"];
  NSUInteger numImage = atlas.textureNames.count;
  for (int i = 0; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Coin%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [tempArray addObject:temp];
  }
  
  for (int i = kNormalFlapping; i < kDeath; i++) {
    NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithState:i];
    if (prefix != NULL) {
      SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:prefix];
      NSUInteger numImage = atlas.textureNames.count;
      for (int j = 1; j <= numImage; j++) {
        NSString *textureName = [NSString stringWithFormat:@"%@%0.2d",prefix,j];
        SKTexture *temp = [atlas textureNamed:textureName];
        [tempArray addObject:temp];
      }
    }
  }
  
  NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithState:kDeath];
  atlas = [SKTextureAtlas atlasNamed:prefix];
  numImage = atlas.textureNames.count;
  for (int i = 1; i <= numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"ParticleDeath%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [tempArray addObject:temp];
  }
  
  atlas = [SKTextureAtlas atlasNamed:@"Smoke"];
  numImage = atlas.textureNames.count;
  for (int i = 0; i < numImage ; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Smoke%0.2d",i];
    SKTexture *temps = [atlas textureNamed:textureName];
    [tempArray addObject:temps];
  }

  atlas = [SKTextureAtlas atlasNamed:@"BatAnimation"];
  numImage = atlas.textureNames.count;
  for (int i = 1; i <=numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Bat%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [tempArray addObject:temp];
  }
  
  atlas = [SKTextureAtlas atlasNamed:@"Smoke"];
  numImage = atlas.textureNames.count;
  
  for (int i = 10; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"smoke%0.4d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [tempArray addObject:temp];
  }
  
  return [tempArray copy];
}

- (IBAction)musicTouched:(id)sender {
  BOOL isMusicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
  if (isMusicOn) {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Music];
    [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteOFF.png"] forState:UIControlStateNormal];
    [[Sound sharedSound] stopMusic];
  }
  else {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Music];
    [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteON.png"] forState:UIControlStateNormal];
    [[Sound sharedSound] playNextSong];
  }
}

- (IBAction)mainMenu:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
  [[Sound sharedSound] playSoundEffect:kButtonClicking];
}

- (IBAction)getGold:(id)sender {
  [[Sound sharedSound] playSoundEffect:kButtonClicking];
}

- (IBAction)startGame:(id)sender {
  [[Sound sharedSound] playSoundEffect:kButtonClicking];
}

- (IBAction)buySlow:(id)sender {
  GameState *gs = [GameState sharedGameState];
  if (gs.gold < SLOW_COST) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not enough gold" message:@"You don't have enough gold to buy this powerup" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"OK", nil];
    [alert show];
  }
  else {
    gs.gold -= SLOW_COST;
    [[Globals sharedGlobals] updateGold];
  }
}

- (IBAction)buyMayhem:(id)sender {
  GameState *gs = [GameState sharedGameState];
  if (gs.gold < MAYHEM_COST) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not enough gold" message:@"You don't have enough gold to buy this powerup" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"OK", nil];
    [alert show];
  }
  else {
    gs.gold -= MAYHEM_COST;
    [[Globals sharedGlobals] updateGold];
  }
}

- (IBAction)buyArmor:(id)sender {
  GameState *gs = [GameState sharedGameState];
  if (gs.gold < ARMOR_COST) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not enough gold" message:@"You don't have enough gold to buy this powerup" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"OK", nil];
    [alert show];
  }
  else {
    gs.gold -= ARMOR_COST;
    [[Globals sharedGlobals] updateGold];
  }
}

@end

//
//  MainViewController.m
//  DragonsDen
//
//  Created by Danny on 11/3/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "Sound.h"
#import "Definitions.h"
#import <SpriteKit/SpriteKit.h>
#import "Globals.h"
#import "PowerUp.h"

@implementation MainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
  if (musicOn) [[Sound sharedSound] playMenuMusic];
}


- (IBAction)playGame:(id)sender {

  [[Sound sharedSound] playSoundEffect:kButtonClicking];
  //preload texture
  [SKTexture preloadTextures:[self getPreloadedArray] withCompletionHandler:^{
    BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
    if (musicOn) [[Sound sharedSound] playNextSong];
  }];
}

- (NSArray *)getPreloadedArray {
  NSMutableArray *preloadedTexture = [NSMutableArray array];
  
  for (int i = kTypeSlow; i <= kTypeMayhem; i++) {
    NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithPowerUp:i];
    if (prefix != NULL) {
      SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:prefix];
      NSUInteger numImage = atlas.textureNames.count;
      for (int i = 0; i < numImage; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@%0.2d",prefix,i];
        SKTexture *temp = [atlas textureNamed:textureName];
        [preloadedTexture addObject:temp];
      }
      
      prefix = [NSString stringWithFormat:@"%@Glow",prefix];
      atlas = [SKTextureAtlas atlasNamed:prefix];
      numImage = atlas.textureNames.count;
      for (int i = 0; i < numImage; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%@%0.2d",prefix, i];
        SKTexture *temp = [atlas textureNamed:textureName];
        [preloadedTexture addObject:temp];
      }
    }
  }
  
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"CoinNormal"];
  NSUInteger numImage = atlas.textureNames.count;
  for (int i = 0; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Coin%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [preloadedTexture addObject:temp];
  }
  
  for (int i = kNormalFlapping; i < kDeath; i++) {
    NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithState:i];
    if (prefix != NULL) {
      SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:prefix];
      NSUInteger numImage = atlas.textureNames.count;
      for (int j = 1; j <= numImage; j++) {
        NSString *textureName = [NSString stringWithFormat:@"%@%0.2d",prefix,j];
        SKTexture *temp = [atlas textureNamed:textureName];
        [preloadedTexture addObject:temp];
      }
    }
  }
  
  NSString *prefix = [[Globals sharedGlobals] getAtlasNameWithState:kDeath];
  atlas = [SKTextureAtlas atlasNamed:prefix];
  numImage = atlas.textureNames.count;
  for (int i = 1; i <= numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"ParticleDeath%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [preloadedTexture addObject:temp];
  }
  
  atlas = [SKTextureAtlas atlasNamed:@"Smoke"];
  numImage = atlas.textureNames.count;
  for (int i = 0; i < numImage ; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Smoke%0.2d",i];
    SKTexture *temps = [atlas textureNamed:textureName];
    [preloadedTexture addObject:temps];
  }
  
  atlas = [SKTextureAtlas atlasNamed:@"BatAnimation"];
  numImage = atlas.textureNames.count;
  for (int i = 1; i <=numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Bat%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [preloadedTexture addObject:temp];
  }
  
  atlas = [SKTextureAtlas atlasNamed:@"Smoke"];
  numImage = atlas.textureNames.count;
  
  for (int i = 10; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"smoke%0.4d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [preloadedTexture addObject:temp];
  }
  
  return [preloadedTexture copy];
}

- (IBAction)highScore:(id)sender {
  [[Sound sharedSound] playSoundEffect:kButtonClicking];
}

- (IBAction)howToPlay:(id)sender {
  [[Sound sharedSound] playSoundEffect:kButtonClicking];
}

- (IBAction)facebookLike:(id)sender {
  [[Sound sharedSound] playSoundEffect:kButtonClicking];
  NSURL* facebookURL = [ NSURL URLWithString: @"https://www.facebook.com/dragonsdenios"];
  NSURL* facebookAppURL = [ NSURL URLWithString: @"fb://profile/589628087736943" ];
  UIApplication* app = [ UIApplication sharedApplication ];
  if( [ app canOpenURL: facebookAppURL ] ) {
    [ app openURL: facebookAppURL ];
  } else {
    [ app openURL: facebookURL ];
  }
}



@end

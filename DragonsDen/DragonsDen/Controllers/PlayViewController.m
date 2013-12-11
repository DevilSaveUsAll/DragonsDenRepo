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

@implementation PlayViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"Music"];
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

- (IBAction)musicTouched:(id)sender {
  BOOL isMusicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"Music"];
  if (isMusicOn) {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Music"];
    [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteOFF.png"] forState:UIControlStateNormal];
    [[Sound sharedSound] stopMusic];
  }
  else {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Music"];
    [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteON.png"] forState:UIControlStateNormal];
    [[Sound sharedSound] playNextSong];
  }
}

- (IBAction)mainMenu:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getGold:(id)sender {
  
}

- (IBAction)startGame:(id)sender {
  
}

@end

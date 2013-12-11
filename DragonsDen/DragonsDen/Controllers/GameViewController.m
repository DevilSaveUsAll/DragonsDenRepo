//
//  GameViewController.m
//  DragonsDen
//
//  Created by Danny on 11/4/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "GameViewController.h"
#import "HowToPlayViewController.h"
#import "FMMParallaxNode.h"
#import "GameScene.h"
#import "Sound.h"
#import "GameState.h"
#import "Coin.h"
#import "Globals.h"

@implementation GameViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"Music"];
  if (!musicOn) [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteOFF.png"] forState:UIControlStateNormal];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  
  NSMutableArray *tempArray = [NSMutableArray array];
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"CoinNormal"];
  NSUInteger numImage = atlas.textureNames.count;
  for (int i = 0; i < numImage; i++) {
    NSString *textureName = [NSString stringWithFormat:@"Coin%0.2d",i];
    SKTexture *temp = [atlas textureNamed:textureName];
    [tempArray addObject:temp];
  }
  SKView *skView = (SKView *)self.view;
  if (!skView.scene) {
    [SKTexture preloadTextures:tempArray withCompletionHandler:^{
      
      for (UIView *view in self.view.subviews) {
        if (view.hidden) {
          view.hidden = NO;
        }
      }
      
      self.gameScene = [[GameScene alloc] initWithSize:CGSizeMake(568, 320)];
      self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
      self.gameScene.delegate = self;
      [self.gameScene addCoinFrame:tempArray];
      [skView presentScene:self.gameScene.scene];
    }];
  }
  self.pauseScreen.delegate = self;
  
  UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft)];
  gesture.direction = UISwipeGestureRecognizerDirectionLeft;
  [self.view addGestureRecognizer:gesture];
  
  gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight)];
  gesture.direction = UISwipeGestureRecognizerDirectionRight;
  [self.view addGestureRecognizer:gesture];
  
  gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDown)];
  gesture.direction = UISwipeGestureRecognizerDirectionDown;
  [self.view addGestureRecognizer:gesture];
  
  gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUp)];
  gesture.direction = UISwipeGestureRecognizerDirectionUp;
  [self.view addGestureRecognizer:gesture];
}

- (void)swipedLeft {
  [self.gameScene speedTowardsDirection:kDirectionLeft];
}

- (void)swipedRight {
  [self.gameScene speedTowardsDirection:kDirectionRight];
}

- (void)swipedDown {
  [self.gameScene speedTowardsDirection:kDirectionDown];
}

- (void)swipedUp {
  [self.gameScene speedTowardsDirection:kDirectionUp];
}

- (void)addHowToPlayScreen {
  UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                bundle:nil];
  HowToPlayViewController* vc = [sb instantiateViewControllerWithIdentifier:@"HowToPlayViewController"];
  [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)musicClicked:(id)sender {
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"Music"];
  
  if (musicOn) {
    [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteOFF.png"] forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Music"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[Sound sharedSound] stopMusic];
  }
  else {
    [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteON.png"] forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Music"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[Sound sharedSound] playNextSong];
  }
}

- (IBAction)pauseClicked:(id)sender {
  SKView *skView = (SKView *)self.view;
  [skView addSubview:self.pauseScreen];
  [self.gameScene pauseGame];
}

#pragma mark - GameSceneDelegate

- (void)updateDistance {
  
}

- (void)updateGold:(Coin *)coin {
  GameState *gs = [GameState sharedGameState];
  gs.gold += coin.goldValue;
  [[Globals sharedGlobals] updateGold];
  self.goldLabel.text = [NSString stringWithFormat:@"%d",gs.gold];
}

- (void)restartGame {
  [self.gameScene removeAllChildren];
  [self.gameScene removeAllActions];
  [self.gameScene removeFromParent];
  self.gameScene = nil;
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)showPopUp:(PopUpType)type {
  NSString *postDescription;
  NSString *title;
  switch (type) {
    case kFacebookWallPost:
      title = @"Got 500 Gold";
      postDescription = @"You have received 500 gold";
      break;
      
    default:
      break;
  }
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:postDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alert show];
}

#pragma mark - PauseDelegate

- (void)resume {
  [self.gameScene resumeGame];
  [self.pauseScreen removeFromSuperview];
}

- (void)mainMenu {
  [self.navigationController popToRootViewControllerAnimated:YES];
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"Music"];
  if (musicOn) [[Sound sharedSound] playMenuMusic];
}

#pragma mark - Powerup Methods

- (IBAction)useSlow:(id)sender {
  [self.gameScene useSlow];
}

- (IBAction)useArmor:(id)sender {
  [self.gameScene useArmor];
}

- (IBAction)useMayhem:(id)sender {
  [self.gameScene useMayhem];
}


@end

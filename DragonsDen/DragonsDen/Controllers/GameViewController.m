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

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  
  SKView *skView = (SKView *)self.view;
  if (!skView.scene) {
    self.gameScene = [[GameScene alloc] initWithSize:CGSizeMake(568, 320)];
    self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
    self.gameScene.delegate = self;
    [skView presentScene:self.gameScene.scene];
  }
  
  self.pauseScreen.delegate = self;
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

#pragma mark - GameSceneDelegate

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

- (void)pauseGame {
  if (self.gameScene.dead) return;
  SKView *skView = (SKView *)self.view;
  [skView addSubview:self.pauseScreen];
  [self.gameScene pauseGame];
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
  if (self.gameScene.dead) return;
  [self.gameScene useSlow];
}

- (IBAction)useArmor:(id)sender {
  if (self.gameScene.dead) return;
  [self.gameScene useArmor];
}

- (IBAction)useMayhem:(id)sender {
  if (self.gameScene.dead) return;
  [self.gameScene useMayhem];
}

@end

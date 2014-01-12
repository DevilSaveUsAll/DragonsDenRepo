//
//  InAppPurchaseViewController.m
//  DragonsDen
//
//  Created by Danny on 1/4/14.
//  Copyright (c) 2014 Meep. All rights reserved.
//

#import "InAppPurchaseViewController.h"
#import "GameState.h"
#import "Sound.h"
#import "Definitions.h"
#import "DDIAPHelper.h"

@implementation InAppPurchaseViewController

- (void)viewWillAppear:(BOOL)animated {
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
  if (!musicOn) [self.musicButton setImage:[UIImage imageNamed:@"MusicNoteOFF.png"] forState:UIControlStateNormal];
  
  GameState *gs = [GameState sharedGameState];
  self.goldLabel.text = [NSString stringWithFormat:@"%d",gs.gold];
  
  [self.spinner startAnimating];
  self.loadingView.hidden = NO;
  
  [[DDIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
    if (success) {
      self.products = products;
      [self.spinner stopAnimating];
      self.loadingView.hidden = YES;
    }
  }];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productFailed:) name:IAPHelperProductFailedNotification object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
  NSString * productIdentifier = notification.object;
  [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
    if ([product.productIdentifier isEqualToString:productIdentifier]) {
      *stop = YES;
      [self boughtGold:idx];
      self.view.userInteractionEnabled = YES;
    }
  }];
}

- (void)productFailed:(NSNotification *)notification {
  self.view.userInteractionEnabled = YES;
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Failed" message:@"An unkown error occurred, please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
  [alert show];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)updateGold {
  GameState *gs = [GameState sharedGameState];
  self.goldLabel.text = [NSString stringWithFormat:@"%d",gs.gold];
}

- (void)buyProduct:(int)tag {
  self.view.userInteractionEnabled = NO;
  SKProduct *product = self.products[tag];
  NSLog(@"Buying %@...", product.productIdentifier);
  [[DDIAPHelper sharedInstance] buyProduct:product];
}

- (void)boughtGold:(NSUInteger)idx {
  int gold = 0;
  switch ((int)idx) {
    case 0:
      gold = 150000;
      break;
    case 1:
      gold = 350000;
      break;
    case 2:
      gold = 750000;
      break;
    case 3:
      gold = 2000000;
      break;
    case 4:
      gold = 4000000;
      break;
    case 5:
      gold = 8000000;
      break;
    case 6:
      gold = 25000000;
      break;
      
  }
  GameState *gs = [GameState sharedGameState];
  gs.gold += gold;
  
  [[NSUserDefaults standardUserDefaults] setInteger:gs.gold forKey:Gold];
  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:NO_ADS];
  [[NSUserDefaults standardUserDefaults] synchronize];
  self.goldLabel.text = [NSString stringWithFormat:@"%d",gs.gold];
  
}

- (IBAction)restoreNoAd:(id)sender {
  [[DDIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (IBAction)buyAppOne:(id)sender {
  [self buyProduct:0];
}

- (IBAction)buyAppTwo:(id)sender {
  [self buyProduct:1];
}

- (IBAction)buyAppThree:(id)sender {
  [self buyProduct:2];
}

- (IBAction)buyAppFour:(id)sender {
  [self buyProduct:3];
}

- (IBAction)buyAppFive:(id)sender {
  [self buyProduct:4];
}

- (IBAction)buyAppSix:(id)sender {
  [self buyProduct:5];
}

- (IBAction)buyAppSeven:(id)sender {
  [self buyProduct:6];
}

- (IBAction)back:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
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

@end

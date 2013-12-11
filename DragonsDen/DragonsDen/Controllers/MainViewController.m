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

@implementation MainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"Music"];
  if (musicOn) [[Sound sharedSound] playMenuMusic];
}

- (IBAction)playGame:(id)sender {
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"Music"];
  if (musicOn) [[Sound sharedSound] playNextSong];
}

- (IBAction)highScore:(id)sender {
  
}

- (IBAction)howToPlay:(id)sender {
  [[Sound sharedSound] playSoundEffect:kButtonClicking];
}

- (IBAction)facebookLike:(id)sender {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Need facebook link" message:@"Don't have facebook link" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
  [alert show];
}



@end

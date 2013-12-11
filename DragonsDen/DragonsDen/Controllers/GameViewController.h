//
//  GameViewController.h
//  DragonsDen
//
//  Created by Danny on 11/4/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameScene.h"
#import "PauseScreen.h"
#import "DeathScreen.h"

@interface GameViewController : UIViewController <GameSceneDelegate, PauseScreenDelegate>

@property (nonatomic, strong) GameScene *gameScene;
@property (nonatomic, strong) IBOutlet PauseScreen *pauseScreen;
@property (nonatomic, strong) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) IBOutlet UILabel *goldLabel;
@property (nonatomic, strong) IBOutlet UIButton *musicButton;

- (IBAction)musicClicked:(id)sender;
- (IBAction)pauseClicked:(id)sender;
- (IBAction)useArmor:(id)sender;
- (IBAction)useSlow:(id)sender;
- (IBAction)useMayhem:(id)sender;

@end

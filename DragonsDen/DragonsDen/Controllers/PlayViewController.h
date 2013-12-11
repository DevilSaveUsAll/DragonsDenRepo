//
//  PlayViewController.h
//  DragonsDen
//
//  Created by Danny on 11/3/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *musicButton;
@property (nonatomic, strong) IBOutlet UILabel *goldLabel;

- (IBAction)musicTouched:(id)sender;
- (IBAction)getGold:(id)sender;
- (IBAction)mainMenu:(id)sender;
- (IBAction)startGame:(id)sender;

@end

//
//  PauseScreen.h
//  DragonsDen
//
//  Created by Danny on 11/11/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol PauseScreenDelegate <NSObject>

- (void)resume;
- (void)mainMenu;

@end

@interface PauseScreen : UIView

@property (nonatomic) id <PauseScreenDelegate> delegate;

- (IBAction)resume:(id)sender;
- (IBAction)mainMenu:(id)sender;


@end

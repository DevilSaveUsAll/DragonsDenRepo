//
//  PauseScreen.m
//  DragonsDen
//
//  Created by Danny on 11/11/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "PauseScreen.h"
#import "SkButton.h"

@implementation PauseScreen

- (IBAction)resume:(id)sender {
  if ([self.delegate respondsToSelector:@selector(resume)]) {
    [self.delegate resume];
  }
}

- (IBAction)mainMenu:(id)sender {
  if ([self.delegate respondsToSelector:@selector(mainMenu)]) {
    [self.delegate mainMenu];
  }
}

@end

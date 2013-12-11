//
//  Bat.h
//  DragonsDen
//
//  Created by Danny on 11/12/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Bat : SKNode {
  NSArray *batFrames;
  NSArray *deathFrames;
}

@property (nonatomic, strong) SKSpriteNode *batSprite;

- (void)death;

@end

//
//  CollisionRect.m
//  DragonsDen
//
//  Created by Danny on 12/19/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "CollisionRect.h"
#import "GameScene.h"

@implementation CollisionRect

- (id)initWithColor:(UIColor *)color size:(CGSize)size {
  if (self = [super initWithColor:color size:size]) {
    self.color = color;
    self.size = size;
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(size.width, size.height)];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = DDColliderTypeForeground;
    self.physicsBody.collisionBitMask = DDColliderTypeDragon;
    self.physicsBody.contactTestBitMask = DDColliderTypeDragon;
  }
  return self;
}

@end

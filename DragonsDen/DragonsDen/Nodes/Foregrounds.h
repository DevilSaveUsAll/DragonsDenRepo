//
//  Foregrounds.h
//  DragonsDen
//
//  Created by Danny on 12/5/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum  {
  kForegroundOne = 1,
  kForegroundTwo,
  kForegroundThree,
  kForegroundFour,
  kForegroundFive,
  kForegroundSix,
  kForegroundSeven
}ForeGroundType;

@interface Foregrounds : SKNode

@property (nonatomic) ForeGroundType currentPiece;
@property (nonatomic, strong) SKSpriteNode *foreground;
@property (nonatomic, strong) NSMutableArray *coinFrames;

- (id)initWithCurrentPiece:(ForeGroundType)type andCoinFrames:(NSMutableArray *)coinFrames;
@end
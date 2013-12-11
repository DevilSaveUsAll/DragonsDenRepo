//
//  Foreground.h
//  DragonsDen
//
//  Created by Danny on 11/16/13.
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

@interface Foreground : SKNode

@property (nonatomic) ForeGroundType currentPiece;
@property (nonatomic, strong) NSString *childName;

- (id)initWithCurrentPiece:(ForeGroundType)type;

@end

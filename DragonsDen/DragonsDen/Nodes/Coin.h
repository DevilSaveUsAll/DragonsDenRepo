//
//  Coin.h
//  DragonsDen
//
//  Created by Danny on 11/11/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
  kTypeNormal = 1,
  kTypePot
}CoinType;

#define NORMAL_VALUE 100
#define POT_VALUE 500

@interface Coin : SKNode {
  NSArray *coinFrames;
}

@property (nonatomic) CoinType coinType;
@property (nonatomic, strong) SKSpriteNode *coin;
@property (nonatomic) int goldValue;

- (id)initWithCoinType:(CoinType)coinType andFrames:(NSMutableArray *)frames;
@end

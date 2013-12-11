//
//  GameScene.h
//  DragonsDen
//
//  Created by Danny on 11/4/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SkButton.h"
#import "PauseScreen.h"
#import "DeathScreen.h"
#import "PowerUp.h"
#import "Foregrounds.h"
#import "Dragon.h"
#import "Coin.h"

typedef enum  {
  kFacebookWallPost = 20,
  kAlreadyPosted,
  kLiked,
}PopUpType;

typedef enum : uint8_t {
  DDColliderTypeDragon           = 1,
  DDColliderTypeBat              = 2,
  DDColliderTypeForeground       = 4,
  DDColliderTypeCoin             = 8,
} DDAColliderType;

typedef enum {
  kDirectionRight = 1,
  kDirectionUp,
  kDirectionDown,
  kDirectionLeft,
  kDirectionDiagonalUp,
  kDirectiondiagonalDown
}SwipeDirections;

@protocol GameSceneDelegate <NSObject>

- (void)mainMenu;
- (void)updateDistance;
- (void)updateGold:(Coin *)coin;
- (void)restartGame;
- (void)showPopUp:(PopUpType)type;

@end

@interface GameScene : SKScene <DeathDelegate,SKPhysicsContactDelegate>

@property (nonatomic, strong) Dragon *dragon;
@property (nonatomic, strong) PowerUp *slowPowerUp;
@property (nonatomic, strong) PowerUp *armorPowerUp;
@property (nonatomic, strong) PowerUp *mayhemPowerUp;
@property (nonatomic) FlyingType flyingState;
@property (nonatomic) int speed;
@property (nonatomic) int distance;
@property (nonatomic) float time;
@property (nonatomic) id<GameSceneDelegate> delegate;

@property (nonatomic, strong) Foregrounds *foregroundOne;
@property (nonatomic, strong) Foregrounds *foregroundTwo;
@property (nonatomic, strong) Foregrounds *foregroundThree;
@property (nonatomic, strong) NSMutableArray *coinFrames;

- (void)pauseGame;
- (void)resumeGame;
- (void)removeObjects;
- (void)useArmor;
- (void)useSlow;
- (void)useMayhem;

- (void)speedTowardsDirection:(SwipeDirections)direction;
- (void)addCoinFrame:(NSMutableArray *)frames;

@end

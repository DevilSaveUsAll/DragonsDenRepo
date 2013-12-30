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
#import "StatsHud.h"

typedef enum  {
  kFacebookWallPost = 20,
  kAlreadyPosted,
  kLiked,
}PopUpType;

typedef enum {
  kDirectionRight = 1,
  kDirectionUp,
  kDirectionDown,
  kDirectionLeft,
  kDirectionDiagonalUp,
  kDirectiondiagonalDown
}SwipeDirections;

typedef enum : uint8_t {
  DDColliderTypeDragon           = 1,
  DDColliderTypeBat              = 2,
  DDColliderTypeForeground       = 4,
  DDColliderTypeCoin             = 8,
} DDAColliderType;

@protocol GameSceneDelegate <NSObject>

- (void)mainMenu;
- (void)restartGame;
- (void)showPopUp:(PopUpType)type;
- (void)pauseGame;

@end

@interface GameScene : SKScene <DeathDelegate,SKPhysicsContactDelegate, StatsDelegate>

@property (nonatomic, strong) Dragon *dragon;
@property (nonatomic, strong) PowerUp *slowPowerUp;
@property (nonatomic, strong) PowerUp *armorPowerUp;
@property (nonatomic, strong) PowerUp *mayhemPowerUp;
@property (nonatomic) FlyingType flyingState;
@property (nonatomic) int distance;
@property (nonatomic) BOOL dead;
@property (nonatomic) id<GameSceneDelegate> delegate;

@property (nonatomic, strong) Foregrounds *foregroundOne;
@property (nonatomic, strong) Foregrounds *foregroundTwo;
@property (nonatomic, strong) Foregrounds *foregroundThree;
@property (nonatomic, strong) NSMutableArray *coinFrames;
@property (nonatomic, strong) NSMutableArray *batFrames;
@property (nonatomic, strong) NSMutableArray *deathFrames;
@property (nonatomic, strong) StatsHud *statsHud;

- (void)pauseGame;
- (void)resumeGame;
- (void)removeObjects;
- (void)useArmor;
- (void)useSlow;
- (void)useMayhem;

- (void)speedTowardsDirection:(SwipeDirections)direction;

@end

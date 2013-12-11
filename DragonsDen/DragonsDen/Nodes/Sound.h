//
//  Sound.h
//  DragonsDen
//
//  Created by Danny on 11/13/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>

typedef enum {
  kBatDeath = 1,
  kButtonClicking,
  kCollectingGold,
  kDead,
  kPowerDown,
  kPowerUp,
  kSelectingPowerUp,
  kSpeedBoost
}SoundType;

typedef enum {
  kSongOne = 10,
  kSongTwo,
  kSongThree,
}SongType;

@interface Sound : SKNode <AVAudioPlayerDelegate>

+ (Sound *)sharedSound;

@property (nonatomic, strong) AVAudioPlayer *backgroundMusicPlayer;
@property (nonatomic) SongType songType;
@property (nonatomic) BOOL musicPaused;

- (void)playMenuMusic;
- (void)playNextSong;
- (void)playSoundEffect:(SoundType)type;
- (void)stopMusic;


@end

//
//  Sound.m
//  DragonsDen
//
//  Created by Danny on 11/13/13.
//  Copyright (c) 2013 Meep. All rights reserved.
//

#import "Sound.h"
#import "Definitions.h"

@implementation Sound

+ (Sound *)sharedSound {
  static Sound *sharedSound = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedSound = [[self alloc] init];
  });
  return sharedSound;
}

- (id)init {
  if ((self = [super init])) {
    self.songType = arc4random() % 3 + 10;
  }
  return self;
}

- (void)playMenuMusic {
  NSError *error;
  NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"08-Long Past Gone-Jami Sieber" withExtension:@"wav"];
  self.backgroundMusicPlayer = nil;
  self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
  self.backgroundMusicPlayer.delegate = self;
  self.backgroundMusicPlayer.numberOfLoops = -1;
  [self.backgroundMusicPlayer prepareToPlay];
  [self.backgroundMusicPlayer play];
}

- (void)playNextSong {
  if (self.musicPaused) {
    self.musicPaused = NO;
  }
  else {
    NSError *error;
    SongType type = [self getRandomSong];
    self.songType = type;
    NSString *songName = [self getSongName];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:songName withExtension:@"wav"];
    self.backgroundMusicPlayer = nil;
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.backgroundMusicPlayer.numberOfLoops = 1;
    [self.backgroundMusicPlayer prepareToPlay];
  }
  [self.backgroundMusicPlayer play];
}

- (void)stopMusic {
  if (!self.musicPaused) {
    self.musicPaused = YES;
    [self.backgroundMusicPlayer pause];
  }
}

- (NSString *)getSongName {
  NSString *songName;
  switch (self.songType) {
    case kSongOne:
      songName = @"01-Mr Gelatine_ Unknown Quantity-Magnatune Compilation";
      break;
    
    case kSongTwo:
      songName = @"07-Progressive Element-DP Kaufman";
      break;
      
    case kSongThree:
      songName = @"09-Hidden Sky-Jami Sieber";
      break;
  }
  return songName;
}

- (SongType)getRandomSong {
  int type[2];
  if (self.songType == kSongOne) {
    type[0] = 11;
    type[1] = 12;
  }
  else if (self.songType == kSongTwo) {
    type[0] = 10;
    type[1] = 12;
  }
  else if (self.songType == kSongThree) {
    type[0] = 10;
    type[1] = 11;
  }
  int random = arc4random() % 2;
  return type[random];
}

- (void)stopAllMusic {
  if (self.backgroundMusicPlayer.isPlaying) {
    [self.backgroundMusicPlayer pause];
  }
}

- (void)playSoundEffect:(SoundType)type {
  BOOL musicOn = [[NSUserDefaults standardUserDefaults] boolForKey:Music];
  if (musicOn == NO) return;
  NSString *fileName = @"";
  switch (type) {
    case kBatDeath:
      fileName = @"BatDeath.wav";
      break;
      
    case kButtonClicking:
      fileName = @"ButtonClicking.wav";
      break;
      
    case kCollectingGold:
      fileName = @"Collecting Gold Sound.wav";
      break;
      
    case kDead:
      fileName = @"DeathPoof.wav";
      break;
      
    case kPowerDown:
      fileName = @"Powerup PoweringDown.wav";
      break;
      
    case kPowerUp:
      fileName = @"Powerup Sound.wav";
      break;
      
    case kSelectingPowerUp:
      fileName = @"Selecting Powerup.wav";
      break;
      
    case kSpeedBoost:
      fileName = @"SpeedBoost Sound.wav";
      break;
  }
  
  NSURL *fileURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
  if (fileURL != nil)
  {
    SystemSoundID theSoundID;
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
    if (error == kAudioServicesNoError)
      soundID = theSoundID;
  }  
  AudioServicesPlaySystemSound(soundID);
}

#pragma mark AVAudioDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
  if (flag) {
  }
}

@end

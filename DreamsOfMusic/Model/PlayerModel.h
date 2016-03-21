//
//  PlayerModel.h
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

/** all delegate method is optional **/
@protocol PlayerModelDelegate <NSObject>
@optional
-(void)trackDidChange:(MPMediaItem *)nowPlayingTrack previousTrack:(MPMediaItem *)previousTrack;
-(void)endOfListReached:(MPMediaItem *)lastTrack;
-(void)playbackStateChanged:(MPMusicPlaybackState)nowState previousState:(MPMusicPlaybackState)previousState;
-(void)volumeChanged:(float)volume;
@end


@interface PlayerModel : NSObject <MPMediaPlayback>

@property (nonatomic, weak) MPMediaItem *nowPlayingTrack;
    ////
@property (nonatomic) MPMusicRepeatMode repeatMode;
@property (nonatomic) MPMusicShuffleMode shuffleMode;
    ////
@property (nonatomic) NSTimeInterval currentPlaybackTime;

@property (nonatomic) float volume; // 0.0 to 1.0
@property (nonatomic, readonly) NSUInteger indexOfNowPlayingItem;
@property (nonatomic, readonly) NSArray *trackList;

+ (PlayerModel *)sharedInstance;

- (void)addDelegate:(id<PlayerModelDelegate>)delegate;
- (void)removeDelegate:(id<PlayerModelDelegate>)delegate;
- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent;
- (void)setListWithItemCollection:(MPMediaItemCollection *)itemCollection;
- (void)setListWithQuery:(MPMediaQuery *)query;

- (void)playNextTrack;
- (void)playFromBeginning;
- (void)playPreviousTrack;

- (void)stopMusic;
- (void)pauseMusic;


- (void)playTrackAtIndex:(NSUInteger)index;
- (void)playTrack:(MPMediaItem *)item;

@end

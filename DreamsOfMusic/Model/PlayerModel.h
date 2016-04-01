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
@end


@interface PlayerModel : NSObject <MPMediaPlayback>

@property (strong, nonatomic, readonly) MPMediaItem *nowPlayingTrack;
@property (nonatomic) MPMusicPlaybackState playbackState;
    ////
@property (nonatomic) MPMusicRepeatMode repeatMode;
@property (nonatomic) MPMusicShuffleMode shuffleMode;
    ////
@property (nonatomic) NSTimeInterval currentPlaybackTime;

@property (nonatomic) float volume; // 0.0 to 1.0
@property (nonatomic, readonly) NSUInteger indexOfNowPlayingTrack;
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

- (void)playTrackAtIndex:(NSUInteger)index;
- (void)playTrack:(MPMediaItem *)item;

@end

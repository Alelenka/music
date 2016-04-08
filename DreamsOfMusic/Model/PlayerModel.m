//
//  PlayerModel.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "PlayerModel.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerModel () <AVAudioSessionDelegate>{
    NSArray *localMusic;
}
@property (copy, nonatomic) NSArray *delegates;
@property (nonatomic, strong) AVPlayer *player;

@property (strong, nonatomic) NSArray *originaltrackList;
@property (nonatomic, strong, readwrite) Song *nowPlayingTrack;
@property (nonatomic, readwrite) NSUInteger indexOfNowPlayingTrack;
@property (nonatomic, strong, readwrite) NSArray *trackList;

@end

@implementation PlayerModel

+(PlayerModel *)sharedInstance {
    static PlayerModel* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.indexOfNowPlayingTrack = NSNotFound;
        self.delegates = @[];
        self.repeatMode = MPMusicRepeatModeNone;
        self.shuffleMode = MPMusicShuffleModeOff;
        
        NSError *error = nil;
        BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
        if(!success){
            NSLog(@"SetCategory error %@",error);
        }
        success = [[AVAudioSession sharedInstance] setActive:YES error:&error];
        if(!success){
            NSLog(@"SetActive error %@",error);
        }
        [[MPMusicPlayerController iPodMusicPlayer] beginGeneratingPlaybackNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handle_VolumeChanged:)
                                                     name:MPMusicPlayerControllerVolumeDidChangeNotification
                                                   object:[MPMusicPlayerController iPodMusicPlayer]];
        
        }
    return self;
}

- (void)dealloc {
    [[MPMusicPlayerController iPodMusicPlayer] endGeneratingPlaybackNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMusicPlayerControllerVolumeDidChangeNotification
                                                  object:[MPMusicPlayerController iPodMusicPlayer]];
}

-(void)addDelegate:(id<PlayerModelDelegate>)delegate{
    NSMutableArray *delegatesCopy = [self.delegates mutableCopy];
    [delegatesCopy addObject:delegate];
    self.delegates = delegatesCopy;
    
    if([delegate respondsToSelector:@selector(playbackStateChanged:previousState:)]){
        [delegate playbackStateChanged:self.playbackState previousState:MPMusicPlaybackStateStopped];
    }
    if([delegate respondsToSelector:@selector(trackDidChange:previousTrack:)]){
        [delegate trackDidChange:self.nowPlayingTrack previousTrack:nil];
    }
}

-(void)removeDelegate:(id<PlayerModelDelegate>)delegate{
    NSMutableArray *delegatesCopy = [self.delegates mutableCopy];
    [delegatesCopy removeObject:delegate];
    self.delegates = delegatesCopy;
}


#pragma mark - Player
-(void)setListWithItemCollection:(MPMediaItemCollection *)itemCollection{
    self.originaltrackList = [itemCollection items];
}

-(void)setListWithQuery:(MPMediaQuery *)query{
    self.originaltrackList = [query items];
}

- (void)setListWithSongs:(NSArray *)songs{
    self.originaltrackList = songs;
}

-(void)playNextTrack{
    if(self.indexOfNowPlayingTrack+1 < [self.trackList count]){
            //play next track
        self.indexOfNowPlayingTrack++;
    }else {
        if (self.repeatMode == MPMusicRepeatModeAll){
            self.indexOfNowPlayingTrack = 0;
        } else{
            if(self.playbackState == MPMusicPlaybackStatePlaying){
                if(self.nowPlayingTrack != nil){
                    for (id <PlayerModelDelegate> delegate in self.delegates) {
                        if ([delegate respondsToSelector:@selector(endOfListReached:)]) {
                            [delegate endOfListReached:self.nowPlayingTrack];
                        }
                    }
                }
            }
            NSLog(@" end of trackList reached");
            [self stop];
        }
    }

}



-(void)playFromBeginning{
    self.currentPlaybackTime = 0.0;
}

-(void)playPreviousTrack{
    if(self.indexOfNowPlayingTrack > 0){
        self.indexOfNowPlayingTrack--;
    }///?
}

#pragma mark - PlayControls

-(void)play{
    [self.player play];
    self.playbackState = MPMusicPlaybackStatePlaying;
}

-(void)pause{
    [self.player pause];
    self.playbackState = MPMusicPlaybackStatePaused;
}

-(void)stop{
    [self.player pause];
    self.playbackState = MPMusicPlaybackStateStopped;
}

- (NSTimeInterval)currentPlaybackTime {
    return 0; ///????
}



- (void)setShuffleMode:(MPMusicShuffleMode)shuffleMode {
    _shuffleMode = shuffleMode;
    self.trackList = self.originaltrackList;
}

- (void)setVolume:(float)volume {
    self.player.volume = volume;
}

- (void)setOriginaltrackList:(NSArray *)originaltrackList{
    _originaltrackList = originaltrackList;
    self.trackList = originaltrackList;
}

-(void)setTrackList:(NSArray *)trackList{
    switch (self.shuffleMode) {
        case MPMusicShuffleModeOff:
            _trackList = trackList;
            break;
            
        case MPMusicShuffleModeSongs:
                //?????
            break;
            
        default:
                //?????
            break;
    }
    if([_trackList count]){
        self.indexOfNowPlayingTrack = 0;
    }else {
        self.indexOfNowPlayingTrack = NSNotFound;
    }
}


-(void)playTrackAtIndex:(NSUInteger)index{
    [self setIndexOfNowPlayingTrack:index];
}

-(void)setIndexOfNowPlayingTrack:(NSUInteger)indexOfNowPlayingTrack{
    if (indexOfNowPlayingTrack == NSNotFound) {
        return;
    }
    _indexOfNowPlayingTrack = indexOfNowPlayingTrack;
    self.nowPlayingTrack = self.trackList[indexOfNowPlayingTrack];
}

-(void)setNowPlayingTrack:(Song *)nowPlayingTrack{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    Song *prevTrack = _nowPlayingTrack;
    _nowPlayingTrack = nowPlayingTrack;
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:nowPlayingTrack.songUrl];
    
    if(self.player){
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
    } else {
        self.player = [AVPlayer playerWithPlayerItem:playerItem];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAVPlayerItemDidPlayToEndTimeNotification) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    for (id <PlayerModelDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(trackDidChange:previousTrack:)]) {
            [delegate trackDidChange:nowPlayingTrack previousTrack:prevTrack];
        }
    }

//    [self doUpdateNowPlayingCenter];
    
}

-(void)playTrack:(MPMediaItem *)item{
    [self playTrackAtIndex:[self.trackList indexOfObject:item]];
}



- (void)handle_VolumeChanged:(NSNotification *)notification {
        //??????
}


#pragma mark MPMediaPlayBack


- (BOOL)isPreparedToPlay {
    return YES;
}

- (void)setCurrentPlaybackRate:(float)currentPlaybackRate {
    self.player.rate = currentPlaybackRate;
}

- (float)currentPlaybackRate {
    return self.player.rate;
}

- (void)prepareToPlay {
    NSLog(@"!!!!!");
}

- (void)beginSeekingBackward {
    NSLog(@"+++++");
}

- (void)beginSeekingForward {
    NSLog(@"DO something");
}

- (void)endSeeking {
    NSLog(@"Not working right now");
}

@end

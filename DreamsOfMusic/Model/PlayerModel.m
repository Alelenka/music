//
//  PlayerModel.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "PlayerModel.h"

@interface PlayerModel (){
    NSArray *localMusic;
}
//@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) MPMusicPlayerController *player;

@end

@implementation PlayerModel

static PlayerModel* sharedInstance = nil;
static dispatch_once_t onceToken;


+(PlayerModel *)sharedInstance {
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.player = [MPMusicPlayerController iPodMusicPlayer];
    });
    
    return sharedInstance;
}

-(void)setFirstSong:(MPMediaItem *)firstSong{
    [self.player setNowPlayingItem:firstSong];
    [self.player play];
}

-(void)setSongsArray:(NSArray *)songsArray{
    
    [self.player setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:songsArray]];

}

//- (void) registerMediaPlayerNotifications
//{
//    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
//    
//    [notificationCenter addObserver: self
//                           selector: @selector (handle_NowPlayingItemChanged:)
//                               name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
//                             object: self.player];
//    
//    [notificationCenter addObserver: self
//                           selector: @selector (handle_PlaybackStateChanged:)
//                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
//                             object: self.player];
//    
//    [notificationCenter addObserver: self
//                           selector: @selector (handle_VolumeChanged:)
//                               name: MPMusicPlayerControllerVolumeDidChangeNotification
//                             object: self.player];
//    
//    [self.player beginGeneratingPlaybackNotifications];
//}



@end

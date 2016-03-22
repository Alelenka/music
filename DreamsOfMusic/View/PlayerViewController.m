//
//  PlayerViewController.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController () <PlayerModelDelegate>

@property (nonatomic, weak) IBOutlet UILabel *songInfoLabel;

@end

@implementation PlayerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playerModel addDelegate:self];
    NSLog(@"OOOOO - %@",self.playerModel.trackList);
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.playerModel removeDelegate:self];
    [super viewDidDisappear:animated];
}

-(PlayerModel *)playerModel{
    return [PlayerModel sharedInstance];
}

//-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
//    [self.songInfoLabel setText:@"Playback finished."];
//}


- (IBAction)playPrev:(id)sender {
    [self.playerModel playPreviousTrack];
}

- (IBAction)play:(id)sender {
    if(self.playerModel.playbackState == MPMusicPlaybackStatePlaying){
        [self.playerModel pause];
    }else{
        [self.playerModel play];
    }
    [self.songInfoLabel setText:@"Now playing..."];
}

- (IBAction)playNext:(id)sender {
    [self.playerModel playNextTrack];
}


- (IBAction)pause:(id)sender {

    [self.songInfoLabel setText:@"Paused..."];
}

- (IBAction)stopSound {
    
    [self.songInfoLabel setText:@"Playback stopped."];
}

@end

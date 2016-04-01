//
//  PlayerViewController.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController () <PlayerModelDelegate>

@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (nonatomic, weak) IBOutlet UILabel *songInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *songImage;

@end

@implementation PlayerViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playerModel addDelegate:self];
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
}

- (IBAction)playNext:(id)sender {
    [self.playerModel playNextTrack];
}


- (IBAction)pause:(id)sender {
    [self.playerModel pause];
}

- (IBAction)stopSound {
    
}

- (IBAction)volumeValueChanged:(UISlider *)sender {
    self.playerModel.volume = sender.value;
}

-(void)trackDidChange:(MPMediaItem *)nowPlayingTrack previousTrack:(MPMediaItem *)previousTrack{
    NSLog(@"меняй инфо о песен %@", nowPlayingTrack);
    self.songInfoLabel.text = [NSString stringWithFormat:@"%@ - %@",[nowPlayingTrack valueForProperty:MPMediaItemPropertyArtist],[nowPlayingTrack valueForProperty:MPMediaItemPropertyTitle]];
    MPMediaItemArtwork *artwork = [nowPlayingTrack valueForProperty: MPMediaItemPropertyArtwork];
    self.songImage.image = [artwork imageWithSize: CGSizeMake (320, 320)];
}


@end

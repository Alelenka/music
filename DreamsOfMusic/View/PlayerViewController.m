//
//  PlayerViewController.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@property (nonatomic, weak) IBOutlet UILabel *songInfoLabel;

@end

@implementation PlayerViewController



-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"wth - %@",self.playerModel);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(PlayerModel *)playerModel{
    return [PlayerModel sharedInstance];
}

//-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
//    [self.songInfoLabel setText:@"Playback finished."];
//}


- (IBAction)playPrev:(id)sender {
    
}

- (IBAction)play:(id)sender {
//    [self.player play];
    [self.songInfoLabel setText:@"Now playing..."];
}

- (IBAction)playNext:(id)sender {
}


- (IBAction)pause:(id)sender {
//    [self.player stop];
    [self.songInfoLabel setText:@"Paused..."];
}

- (IBAction)stopSound {
//    [self.player stop];
    
//    [self.player setCurrentTime:0.0];
    
    [self.songInfoLabel setText:@"Playback stopped."];
}

@end

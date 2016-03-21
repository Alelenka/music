//
//  SongsLibraryVC.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 09.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "SongsLibraryVC.h"
#import <MediaPlayer/MediaPlayer.h>

#import "PlayerViewController.h"

#import "Song.h"
#import "SongTableViewCell.h"
#import "SongTableViewDataSource.h"

static NSString * const cellIdentifier = @"SongCell";

@interface SongsLibraryVC () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SongTableViewDataSource *songTVDataSource;
@property (nonatomic, strong) NSArray *songs;

@end



@implementation SongsLibraryVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Songs";
    [self setupTableView];
}


- (void)setupTableView
{
    self.songs = [[MPMediaQuery songsQuery] items];
    TableViewCellConfigureBlock configureCell = ^(SongTableViewCell *cell, MPMediaItem *info) {
        cell.presenter.model = [Song songWithMediaInfo:info];
    };
    
    self.songTVDataSource = [[SongTableViewDataSource alloc] initWithItems:self.songs
                                                         cellIdentifier:cellIdentifier
                                                     configureCellBlock:configureCell];
    self.tableView.dataSource = self.songTVDataSource;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if ([segue.identifier isEqualToString:@"PlayMusicSegue"]) {
//         PlayerViewController *detailsVC;
//         if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
//             UINavigationController *nav = segue.destinationViewController;
//             detailsVC = ((PlayerViewController *)nav.topViewController);
//         }else {
//             detailsVC = ((PlayerViewController *)segue.destinationViewController);
//         }
//         detailsVC.playerModel.firstSong = sender;
//         detailsVC.playerModel.songsArray = self.songs;
         MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
         
         [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:self.songs]];
         [musicPlayer setNowPlayingItem:sender];
         
         [musicPlayer play];
     }
    
    
//    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
//    NSArray *songs = [songsQuery items];
//    
//    NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
//    
//    MPMediaItem *selectedItem = [[songs objectAtIndex:selectedIndex] representativeItem];
//    
//    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
//    
//    [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:[songsQuery items]]];
//    [musicPlayer setNowPlayingItem:selectedItem];
//    
//    [musicPlayer play];
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"PlayMusicSegue" sender:[self.songs objectAtIndex:indexPath.row]];
}


@end

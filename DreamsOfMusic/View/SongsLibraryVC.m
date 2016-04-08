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
#import "LibraryModel.h"

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTableView) name:@"SetMusicLibrary" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SetMusicLibrary" object:nil];
}


- (void)setupTableView
{
    self.songs = [[LibraryModel sharedInstance] getAllSongs];
    TableViewCellConfigureBlock configureCell = ^(SongTableViewCell *cell, Song *info) {
        cell.presenter.model = info;
    };
    
    self.songTVDataSource = [[SongTableViewDataSource alloc] initWithItems:self.songs
                                                         cellIdentifier:cellIdentifier
                                                     configureCellBlock:configureCell];
    self.tableView.dataSource = self.songTVDataSource;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if ([segue.identifier isEqualToString:@"PlayMusicSegue"]) {
         PlayerViewController *detailsVC;
         if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
             UINavigationController *nav = segue.destinationViewController;
             detailsVC = ((PlayerViewController *)nav.topViewController);
         }else {
             detailsVC = ((PlayerViewController *)segue.destinationViewController);
         }
         [detailsVC.playerModel setListWithSongs:self.songs];
         [detailsVC.playerModel playTrackAtIndex:[(NSIndexPath *)sender row]];
         [detailsVC.playerModel play];

     }
    
    
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"PlayMusicSegue" sender:indexPath];
}


@end

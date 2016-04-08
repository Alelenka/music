//
//  SongPresenter.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 14.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "SongPresenter.h"
#import "Song.h"

@implementation SongPresenter

- (void)reloadData{
    Song *song = self.model;
    self.nameLabel.text = song.name;
    self.singerLabel.text = song.singer;
    self.albumLabel.text = song.album;
    self.frontImageView.image = song.artwork;
#warning show year rigth!
//    self.yearLabel.text = [NSString stringWithFormat:@"%@", song.year];
}

@end

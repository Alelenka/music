//
//  LibraryModel.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 01.04.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "LibraryModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Song.h"


@interface LibraryModel ()

@property (nonatomic, strong) NSArray *songs;
@property (nonatomic, strong) NSArray *albums;
@property (nonatomic, strong) NSArray *artists;

@end

@implementation LibraryModel

+(LibraryModel *)sharedInstance {
    static LibraryModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.songs = @[];
        sharedInstance.albums = @[];
        sharedInstance.artists = @[];
    });
    
    return sharedInstance;
}


-(void)collectAllLibrary{
    NSMutableArray * freeArray = [[NSMutableArray alloc] init];
    for (MPMediaItem * item in [[MPMediaQuery songsQuery] items]) {
        NSURL* assetURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
        if (assetURL) {
            Song *song = [[Song alloc] initWithElement:item];
            [freeArray addObject:song];
        }
    }
#warning all of it in Songs.h
    
    
    [freeArray addObject:[[Song alloc] initWithElement:[[NSBundle mainBundle] pathForResource:@"System Of A Down - Lonely Day" ofType:@"mp3"]]];
    [freeArray addObject:[[Song alloc] initWithElement:[[NSBundle mainBundle] pathForResource:@"Сплин - Танцуй!" ofType:@"m4a"]]];
    self.songs = freeArray;
    
        //get songs from localDoc
        //get albums and artist
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetMusicLibrary" object:nil];
}

-(NSArray *)getAllSongs{
        //Check for updates in library
    return self.songs;
}

-(NSArray *)getAllAlbums{
    return self.albums;
}

-(NSArray *)getAllArtists{
    return self.artists;
}

@end

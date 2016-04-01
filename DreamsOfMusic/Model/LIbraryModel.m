//
//  LibraryModel.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 01.04.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "LibraryModel.h"
#import <MediaPlayer/MediaPlayer.h>

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
            [freeArray addObject:item];
        }
    }
    self.songs = freeArray;
    
        //get songs from localDoc
        //get albums and artist
    
    NSLog(@"!!!!");
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

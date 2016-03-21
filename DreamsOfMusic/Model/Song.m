//
//  Song.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "Song.h"

@implementation Song

+ (Song *)songWithName:(NSString *)name
                singer:(NSString *)singer
                 album:(NSString *)album
            imageNamed:(UIImage *)imageNamed
                  year:(NSNumber *)year{
    
    
    Song *song = [[Song alloc] init];
    song.year = year;
    song.name = name;
    song.album = album;
    song.singer = singer;
    song.imageNamed = imageNamed;
    return song;
}

+ (Song *)songWithMediaInfo:(MPMediaItem *)item{
    
    Song *song = [[Song alloc] init];
    song.year = [item valueForProperty:MPMediaItemPropertyReleaseDate];
    song.name = [item valueForProperty:MPMediaItemPropertyTitle];
    song.album = [item valueForProperty:MPMediaItemPropertyAlbumTitle];
    song.singer = [item valueForProperty:MPMediaItemPropertyArtist];
    MPMediaItemArtwork *artwork = [item valueForProperty: MPMediaItemPropertyArtwork];
    song.imageNamed = [artwork imageWithSize: CGSizeMake (320, 320)];
    song.songUrl = [item valueForProperty:MPMediaItemPropertyAssetURL];
    return song;
    
}

@end

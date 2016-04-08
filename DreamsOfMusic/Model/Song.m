//
//  Song.m
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "Song.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

typedef enum {
    SongTypeMediaItem,
    SongTypeLocal,
} SongType;


@interface Song ()
@property (nonatomic) id entity;
@property (nonatomic) SongType songType;

@end

@implementation Song

-(instancetype)initWithElement:(id)element{ //MAIN METHOD
    self = [self init];
    if (self) {
        if([element isKindOfClass:[MPMediaItem class]]){
            self.songType = SongTypeMediaItem;
            self.entity = element;
        } else {
                ///Check if this is music
            NSURL *fileURL = [NSURL fileURLWithPath:element];
            AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
            self.songType = SongTypeLocal;
            self.entity = asset;
        }//....
    }
    return self;
}


//+ (Song *)songWithName:(NSString *)name
//                singer:(NSString *)singer
//                 album:(NSString *)album
//            imageNamed:(UIImage *)imageNamed
//                  year:(NSNumber *)year{
//    
//    
//    Song *song = [[Song alloc] init];
//    song.year = year;
//    song.name = name;
//    song.album = album;
//    song.singer = singer;
////    song.imageNamed = imageNamed;
//    song.songType = SongTypeWhat;
//    return song;
//}
//
//
//+ (Song *)songWithMediaInfo:(MPMediaItem *)item{
//    
//    Song *song = [[Song alloc] init];
//    
//    
//    NSNumber *yearNumber = [item valueForProperty:@"year"];
//    if (yearNumber && [yearNumber isKindOfClass:[NSNumber class]]){
//        int year = [yearNumber intValue];
//        if (year != 0){
//            song.year = yearNumber;
//                // do something with year
//            }
//        }
//
//    song.name = [item valueForProperty:MPMediaItemPropertyTitle];
//    song.album = [item valueForProperty:MPMediaItemPropertyAlbumTitle];
//    song.singer = [item valueForProperty:MPMediaItemPropertyArtist];
//    song.songType = SongTypeMediaItem;
//    song.songUrl = [item valueForProperty:MPMediaItemPropertyAssetURL];
//    return song;
//    
//}
//
//+ (Song *)songWithURL:(NSString *)filePath{
//    __block Song *song = [[Song alloc] init];
//    
//    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
//
//    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
//    NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
//    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
//    NSArray *creationDates = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyCreationDate keySpace:AVMetadataKeySpaceCommon];
////    creationDate
//    
//    AVMetadataItem *title = [titles objectAtIndex:0];
//    AVMetadataItem *artist = [artists objectAtIndex:0];
//    AVMetadataItem *albumName = [albumNames objectAtIndex:0];
//    if([creationDates count]>0){
//        AVMetadataItem *creationDate = [creationDates objectAtIndex:0];
//        song.year = [creationDate.value copyWithZone:nil];
//    }
//
//
//    song.name = [title.value copyWithZone:nil];
//    song.album = [albumName.value copyWithZone:nil];
//    song.singer = [artist.value copyWithZone:nil];
//
//    song.songType = SongTypeLocal;
//    song.songUrl = fileURL;
//    
//    return song;
//}


-(NSString *)name{
    if(_songType == SongTypeMediaItem){
        MPMediaItem * item = _entity;
        return [item valueForProperty:MPMediaItemPropertyTitle];
    }else {
        AVURLAsset *asset = _entity;
        NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
        AVMetadataItem *title = [titles objectAtIndex:0];
        return [title.value copyWithZone:nil];
    }
    return nil;
}

-(NSString *)singer{
    if(_songType == SongTypeMediaItem){
        MPMediaItem * item = _entity;
        return [item valueForProperty:MPMediaItemPropertyArtist];
    }else {
        AVURLAsset *asset = _entity;
        NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
        AVMetadataItem *artist = [artists objectAtIndex:0];
        return [artist.value copyWithZone:nil];
    }
    return nil;
}

-(NSString *)album{
    if(_songType == SongTypeMediaItem){
        MPMediaItem * item = _entity;
        return [item valueForProperty:MPMediaItemPropertyAlbumTitle];
    }else {
        AVURLAsset *asset = _entity;
        NSArray *albums = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
        AVMetadataItem *album = [albums objectAtIndex:0];
        return [album.value copyWithZone:nil];
    }
    return nil;
}

-(NSNumber *)year{
    NSNumber *ny = nil;
    if(_songType == SongTypeMediaItem){
        MPMediaItem * item = _entity;
        NSNumber *yearNumber = [item valueForProperty:@"year"];
        if (yearNumber && [yearNumber isKindOfClass:[NSNumber class]]){
            int iy = [yearNumber intValue];
            if (iy != 0){
                ny = yearNumber;
            }
        }
    }else {
        AVURLAsset *asset = _entity;
        NSArray *creationDates = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyCreationDate keySpace:AVMetadataKeySpaceCommon];
        if([creationDates count]>0){
            AVMetadataItem *creationDate = [creationDates objectAtIndex:0];
            ny = [creationDate.value copyWithZone:nil];
        }

    }
    return ny;

}

-(NSURL *)songUrl{
    if(_songType == SongTypeMediaItem){
        MPMediaItem *item = _entity;
        return [item valueForProperty:MPMediaItemPropertyAssetURL];
    }else{
        AVURLAsset *asset = _entity;
        return asset.URL;
    }
    return nil;
}

-(UIImage *)artwork{
    __block UIImage *img;
    if(_songType == SongTypeMediaItem){
        MPMediaItem *item = _entity;
        MPMediaItemArtwork *artwork = [item valueForProperty: MPMediaItemPropertyArtwork];
        img = [artwork imageWithSize: CGSizeMake (320, 320)];
    }else{
        AVURLAsset *asset = _entity;
        NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
        [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
            NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                               withKey:AVMetadataCommonKeyArtwork
                                                              keySpace:AVMetadataKeySpaceCommon];
            
            for (AVMetadataItem *item in artworks) {
                if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
                    NSDictionary *d = [item.value copyWithZone:nil];
                    img = [UIImage imageWithData:[d objectForKey:@"data"]];
                } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
                    img = [UIImage imageWithData:[item.value copyWithZone:nil]];
                }
            }
        }];

    }
    
    if(!img){
        img = [UIImage imageNamed:@"noimage"];
    }
    
    return img;
}

@end

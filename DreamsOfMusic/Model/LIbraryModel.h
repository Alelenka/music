//
//  LibraryModel.h
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 01.04.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryModel : NSObject

+ (LibraryModel *)sharedInstance;
- (void)collectAllLibrary;

- (NSArray *)getAllSongs;
- (NSArray *)getAllAlbums;
- (NSArray *)getAllArtists;

@end

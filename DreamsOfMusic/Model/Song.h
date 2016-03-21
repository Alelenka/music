//
//  Song.h
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Song : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) UIImage *imageNamed;
@property (nonatomic, copy) NSNumber *year;
@property (nonatomic, copy) NSURL *songUrl;

+ (Song *)songWithName:(NSString *)name
               singer:(NSString *)singer
                album:(NSString *)album
          imageNamed:(UIImage *)imageNamed
                  year:(NSNumber *)year;

+ (Song *)songWithMediaInfo:(MPMediaItem *)item;

@end

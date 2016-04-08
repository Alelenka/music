//
//  Song.h
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 06.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Song : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *singer;
@property (nonatomic, readonly) NSString *album;
@property (nonatomic, readonly) NSNumber *year;
@property (nonatomic, readonly) NSURL *songUrl;
@property (nonatomic, readonly) UIImage *artwork;

//+ (Song *)songWithName:(NSString *)name
//               singer:(NSString *)singer
//                album:(NSString *)album
//          imageNamed:(UIImage *)imageNamed
//                  year:(NSNumber *)year;

-(instancetype)initWithElement:(id)element;

@end

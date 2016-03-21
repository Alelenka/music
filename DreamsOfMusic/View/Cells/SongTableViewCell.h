//
//  SongTableViewCell.h
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 14.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongPresenter.h"

@class Presenter;

@interface SongTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet Presenter *presenter;

@end

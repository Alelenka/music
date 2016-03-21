//
//  SongPresenter.h
//  DreamsOfMusic
//
//  Created by Alyona Belyaeva on 14.03.16.
//  Copyright © 2016 Alyona Belyaeva. All rights reserved.
//

#import "Presenter.h"

@interface SongPresenter : Presenter

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end

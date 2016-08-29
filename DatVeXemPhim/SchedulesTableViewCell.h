//
//  SchedulesTableViewCell.h
//  DatVeXemPhim
//
//  Created by Nguyen Khang on 8/14/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleTime.h"
#import "Film.h"
@interface SchedulesTableViewCell : UITableViewCell < UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSString *FilmID;
@property (strong, nonatomic) NSString *TheaterID;
@property (strong, nonatomic) NSString *ScheduleTime;
@property (strong, nonatomic) NSMutableArray *ScheduleTimeList;
@property (strong, nonatomic) NSString *ScheduleString;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)ScheduleTime *currentScheduleTime;
@property (strong, nonatomic)Film *currentFilm;

@property (weak, nonatomic) IBOutlet UILabel *labelScheduleDate;


@property (retain, nonatomic)UIViewController *parent;
@property (retain, nonatomic)UIStoryboard *sb;

@end

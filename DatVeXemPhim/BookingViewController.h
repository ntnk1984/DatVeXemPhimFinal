//
//  BookingViewController.h
//  DatVeXemPhim
//
//  Created by ngolehoang on 8/1/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Film.h"
#import "ScheduleTime.h"

@interface BookingViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)butFinish:(UIButton *)sender;


@property (nonatomic)NSMutableArray *seatList;
@property (nonatomic) NSMutableArray *selectedSeats;
@property (nonatomic) NSMutableArray *vipSeats;
@property (nonatomic) NSMutableArray *normalSeats;
@property (nonatomic)Film *currentFilm;
@property (nonatomic)ScheduleTime *currentSchedule;
@property (nonatomic)NSMutableDictionary *dicSeats;
@property (weak, nonatomic) IBOutlet UILabel *lblTongTien;


@property (weak, nonatomic) IBOutlet UITextView *tvFilmDetail;
@end

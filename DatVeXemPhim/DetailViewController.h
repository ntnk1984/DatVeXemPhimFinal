//
//  DetailViewController.h
//  DatVeXemPhim
//
//  Created by ngolehoang on 7/31/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Film.h"
#import "Theater.h"
#import "YTPlayerView.h"
@interface DetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblFilmName;
@property (strong, nonatomic) IBOutlet UILabel *lblDirector;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblStartDate;
@property (strong, nonatomic) IBOutlet UIImageView *imvFilmImage;
@property (strong, nonatomic) IBOutlet UITextView *tvFilmSub;
@property (weak, nonatomic) IBOutlet UILabel *lblFilmVote;
@property (weak, nonatomic) IBOutlet UITextView *tvInfo;

@property (strong, nonatomic)Film *currentItem;
- (IBAction)butBook:(id)sender;
- (IBAction)butPlay:(UIButton *)sender;
//@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UILabel *lblFilmType;
@property (weak, nonatomic) IBOutlet UIButton *butPlayOutlet;

@property (nonatomic)NSString *trailURL;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewThumnail;

- (IBAction)butPlayWebView:(UIButton *)sender;

@property (strong, nonatomic) NSArray *FilmSchedules;
@property (strong, nonatomic) NSArray *FilmCinema;
@property (weak, nonatomic) IBOutlet UIPickerView *ouPickerViewCinema;
@property (strong, nonatomic) IBOutletCollection(UIPickerView) NSArray *pickerViewCinema;

@property (strong, nonatomic) NSMutableArray *ScheduleList;
@property (strong, nonatomic) NSArray *ScheduleTimeList;
@property (strong, nonatomic) NSString *currentScheduleTime;

@property (weak, nonatomic) IBOutlet UITextField *txtTheater;
@property (strong, nonatomic) NSMutableArray *theaterList;

@property (nonatomic) UIAlertController *pickerSheet;
@property ( nonatomic)UIPickerView *theaterPickerView;
@property (nonatomic)Theater *currentTheater;
@property (weak, nonatomic) IBOutlet UITableView *tbvSchedule;
@property (weak, nonatomic) IBOutlet UIButton *butTheater;

- (IBAction)butTheaterClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet YTPlayerView *viewVideo;
- (IBAction)playVideo:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imvFilmThumnail;

@end

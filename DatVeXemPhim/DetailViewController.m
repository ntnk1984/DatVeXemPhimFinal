//
//  DetailViewController.m
//  DatVeXemPhim
//
//  Created by ngolehoang on 7/31/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import "DetailViewController.h"
#import "BookingViewController.h"
#import "YTPlayerView.h"
#import "SchedulesTableViewCell.h"
#import "ScheduleTime.h"
#import "Theater.h"
#import "PlayerViewController.h"
@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    
    self.theaterList = [[NSMutableArray alloc] init];
    // 1
    NSString *dataUrl = [NSString stringWithFormat:@"http://ntnk1894.somee.com/api/getTheaterByFilm_Result/%@", _currentItem.id];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              //NSLog(@"response header: %@", response);
                                              
                                              NSString* aStr;
                                              aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                              //NSLog(@"response data: %@", aStr);
                                              
                                              NSMutableArray *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              
                                              for (NSDictionary *dic in json) {
                                                  Theater *t = [[Theater alloc] init];
                                                  t.theaterID = [dic objectForKey:@"theaterid"];
                                                  t.theaterName = [dic objectForKey:@"theatername"];
                                                  
                                                  
                                                  [self.theaterList addObject:t];
                                              }
                                              
                                              if (self.theaterList.count > 0) {
                                                  Theater *t = _theaterList[0];
                                                  self.currentTheater = t;
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      _butTheater.titleLabel.text = t.theaterName;
                                                      
                                                      //[self.theaterPickerView selectRow:1 inComponent:0 animated:NO];
                                                      // 1
                                                      NSString *dataUrl = [NSString stringWithFormat:@"http://ntnk1894.somee.com/api/getFilmSchedulesByTheater_Result?FilmID=%@&TheaterID=%@", _currentItem.id, t.theaterID];
                                                      NSURL *url = [NSURL URLWithString:dataUrl];
                                                      
                                                      // 2
                                                      NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                                                                            dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                                                // 4: Handle response here
                                                                                                //NSLog(@"response header: %@", response);
                                                                                                
                                                                                                NSString* aStr;
                                                                                                aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                                                                //NSLog(@"response data: %@", aStr);
                                                                                                
                                                                                                NSArray *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                                                                self.ScheduleList = [[NSMutableArray alloc] init];
                                                                                                for (NSDictionary *dic in json) {
                                                                                                    ScheduleTime *st = [[ScheduleTime alloc]init];
                                                                                                    st.filmTimes = [dic objectForKey:@"scheduletimes"];
                                                                                                    st.filmDate = [dic objectForKey:@"scheduledate"];
                                                                                                    [self.ScheduleList addObject:st];
                                                                                                    
                                                                                                }
                                                                                                
                                                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                    [self.tbvSchedule reloadData];
                                                                                                    
                                                                                                    
                                                                                                });
                                                                                                
                                                                                                
                                                                                            }];
                                                      
                                                      // 3
                                                      [downloadTask resume];

                                                      
                                                      
                                                  });

                                                 
                                                  
                                                  
                                                  
                                                  
                                              }

                                              
                                          }];
    
    // 3
    [downloadTask resume];

    
    [format setDateFormat:@"dd/MM/yyyy"];

    
    NSString *str0 = [[NSString stringWithFormat:@"%@", _currentItem.filmName] uppercaseString];
    NSString *str1 = @"Khởi chiếu:";
    NSString *str2 = [NSString stringWithFormat:@"%@",_currentItem.filmDateStart ];
    NSString *str3 = @"Thể loại:";
    NSString *str4 = [NSString stringWithFormat:@"%@",_currentItem.filmType ];
    NSString *str5 = @"Độ dài:";
    NSString *str6 = [NSString stringWithFormat:@"%@",_currentItem.filmTime ];
    NSString *str7 = @"Đạo diễn:";
    NSString *str8 = [NSString stringWithFormat:@"%@",_currentItem.filmDirector ];
    
    NSString *strComplete = [NSString stringWithFormat:@"%@\r%@ %@\r%@ %@\r%@ %@ phút\r%@ %@", str0, str1, str2, str3, str4, str5, str6, str7, str8];
    NSMutableAttributedString *strInfo = [[NSMutableAttributedString alloc] initWithString:strComplete];
    
   
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor whiteColor]
                    range:[strComplete rangeOfString:str0]];
    [strInfo addAttribute:NSFontAttributeName
                    value:[UIFont boldSystemFontOfSize:14]
                    range:[strComplete rangeOfString:str0]];
    
    
    [strInfo addAttribute:NSForegroundColorAttributeName
                             value:[UIColor whiteColor]
                             range:[strComplete rangeOfString:str1]];
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor whiteColor]
                    range:[strComplete rangeOfString:str3]];
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor whiteColor]
                    range:[strComplete rangeOfString:str5]];
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor whiteColor]
                    range:[strComplete rangeOfString:str7]];
    
    [strInfo addAttribute:NSForegroundColorAttributeName
                          value:[UIColor blackColor]
                          range:[strComplete rangeOfString:str2]];
    
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:[strComplete rangeOfString:str4]];
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:[strComplete rangeOfString:str6]];
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:[strComplete rangeOfString:str8]];

    
    
    self.tvInfo.attributedText = strInfo;
    
    
    _tvFilmSub.text = [NSString stringWithFormat:@"%@", _currentItem.filmContent];
    
   
    //NSURL *url = [NSURL URLWithString:_currentItem.filmTrailerURL];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton addTarget:self action:@selector(backButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    if ([self.currentItem.filmsPlaying  isEqual: @"1"]) {
        [_butPlayOutlet setTitle:@"Chưa khởi chiếu" forState:UIControlStateNormal];
    }
    else {
        [_butPlayOutlet setTitle:@"ĐẶT VÉ" forState:UIControlStateNormal];
        UIImage *imageTicket = [UIImage imageNamed:@"Cinema_ticket_1.png"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 8, 20, 20)];
        imageView.image = imageTicket;
        [self.butPlayOutlet addSubview:imageView];

    }
    
    [self setImage:_currentItem.filmTrailerURL];
    //Load lich chieu phim
    
    self.ScheduleList = [[NSMutableArray alloc]init];
    
    
    self.tbvSchedule.delegate = self;
    self.tbvSchedule.dataSource = self;
  
    self.imvFilmThumnail.image = [UIImage imageWithData: self.currentItem.dataThumnail];
}

-(void)setImage:(NSString*)urlResponse
{
    //NSString *youtubeUrl = [NSString stringWithFormat:@"%@",[self parseVideoHTMLUrl: urlResponse]];
    
    NSString *videoThumbUrl = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/default.jpg", @"bT8qmoCgxZg"];
    
    NSURL* videoURL =[NSURL URLWithString: videoThumbUrl];
    
    //[_imageViewThumnail setImageWithURL:videoURL forState:UIControlStateNormal];
    NSData *data = [NSData dataWithContentsOfURL:videoURL];
    [_imageViewThumnail setImage:[UIImage imageWithData:data]];
}

-(NSString *)parseVideoHTMLUrl:(NSString *)videoUrl
{
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@";//(.+?)\\&quot;"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    NSTextCheckingResult *textCheckingResult = [regex firstMatchInString:videoUrl options:0 range:NSMakeRange(0, videoUrl.length)];
    
    NSString *url = [videoUrl substringWithRange:[textCheckingResult rangeAtIndex:1]];
    
    return url;
}

-(NSString*)getYoutubeVideoThumbnail:(NSString*)youTubeUrl
{
    NSString* video_id = @"";
    
    if (youTubeUrl.length > 0)
    {
        NSError *error = NULL;
        NSRegularExpression *regex =
        [NSRegularExpression regularExpressionWithPattern:@"(?<=watch\\?v=|/videos/|embed\\/)[^#\\&\\?]*"
                                                  options:NSRegularExpressionCaseInsensitive
                                                    error:&error];
        NSTextCheckingResult *match = [regex firstMatchInString:youTubeUrl
                                                        options:0
                                                          range:NSMakeRange(0, [youTubeUrl length])];
        if (match)
        {
            NSRange videoIDRange = [match rangeAtIndex:0];
            video_id = [youTubeUrl substringWithRange:videoIDRange];
            
            NSLog(@"%@",video_id);
        }
    }
    
    NSString* thumbImageUrl = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/default.jpg",video_id];
    
    return thumbImageUrl;
}

-(void)backButtonTap:(id)sender{
    //Quay ve view truoc do trong navigation stack
    [self.navigationController popViewControllerAnimated:true   ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)butBook:(id)sender {
    /*
    if ([self.currentItem.filmsPlaying  isEqual: @"1"]) {
       
    }
    else {
        BookingViewController *booking = [self.storyboard instantiateViewControllerWithIdentifier:@"booking"];
        Film *currentItem = self.currentItem;
        booking.currentFilm = self.currentItem;
        [self.navigationController pushViewController:booking animated:true];
    }
    
    
    
*/
    
}

- (IBAction)butPlay:(UIButton *)sender {
   /*
    NSURL *videoStreamURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=R8NbfFUU4xE"];
    
    MPMoviePlayerController *_player;
    _player = [[MPMoviePlayerController alloc] initWithContentURL:videoStreamURL];
    _player.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 320);
    
    
    [self.view addSubview:_player.view];
    
    [_player play];
    
*/
    /*
    //NSString *thePath=[[NSBundle mainBundle] pathForResource:@"NỮ HOÀNG BĂNG GIÁ - FROZEN Trailer - Phim Hoat Hinh (2014)" ofType:@"MP4"];
    //NSURL *videoURL = [NSURL fileURLWithPath:thePath];
    
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:@"https://youtu.be/R8NbfFUU4xE"]];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    [self presentViewController:playerViewController animated:YES completion:nil];
*/
    /*
    
    YTPlayerView *pV = [[YTPlayerView alloc]init];
    [self.view addSubview:pV];
    NSLog(@"%@",@"1");
    [pV loadVideoByURL:@"https://youtu.be/R8NbfFUU4xE" startSeconds:0.0 suggestedQuality:kYTPlaybackQualityLarge];
    */
    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=R8NbfFUU4xE"];
    //UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 320)];
    UIWebView *web = [[UIWebView alloc]init];
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    
    
     }


- (IBAction)butPlayWebView:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"https://youtu.be/c6jrL6HFW04"];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 320)];
    //UIWebView *web = [[UIWebView alloc]init];
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //trả về số phim trong danh sách
    return self.ScheduleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell_id";
    SchedulesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    //lấy phim ở vị trí của dòng hiện tại
    ScheduleTime *scheduleTime = [self.ScheduleList objectAtIndex:indexPath.row];
    
    cell.ScheduleString = scheduleTime.filmTime;
    cell.labelScheduleDate.text = scheduleTime.filmDate;
    cell.ScheduleTimeList = [[NSMutableArray alloc] init];
    cell.currentFilm = self.currentItem;
    cell.parent = self;
    cell.sb = self.storyboard;
    
    NSArray *arrayTime = [scheduleTime.filmTimes componentsSeparatedByString:@","];
    for (NSObject *obj in arrayTime) {
        ScheduleTime *time = [[ScheduleTime alloc] init];
        time.filmID = self.currentItem.id;
        time.theaterID = self.currentTheater.theaterID;
        time.filmDate = scheduleTime.filmDate;
        time.filmTime = [NSString stringWithFormat:@"%@", obj];
        
        [cell.ScheduleTimeList addObject:time];
        
    }
    
    [cell.collectionView reloadData];
    //trả về ô đã truyền đầy đủ dữ liệu
    return cell;
}



- (IBAction)okBook:(UIButton *)sender {
    if ([self.currentItem.filmsPlaying  isEqual: @"1"]) {
        
    }
    else {
        BookingViewController *booking = [self.storyboard instantiateViewControllerWithIdentifier:@"booking"];
        Film *currentItem = self.currentItem;
        booking.currentFilm = currentItem;
        /*
        ScheduleTime *currentSchedule = [[ScheduleTime alloc] init];
        currentSchedule.filmID = self.currentItem.id;
        currentSchedule.filmDate = @"";
        currentSchedule.filmTime = sender.titleLabel.text;
        currentSchedule.theaterID = self.currentTheater.theaterID;
        
        booking.currentSchedule = currentSchedule;
         */
        
        
        [self.navigationController pushViewController:booking animated:true];
    }
}



#pragma mark - Picker view Data source
//So luong component trong picker view
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//So luong dong trong tung component
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.theaterList.count;
}
#pragma mark - Picker view Delegate
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return self.colorList[row];
//}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lblColor = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, pickerView.frame.size.width - 20, 20)];
    lblColor.textAlignment = NSTextAlignmentCenter;
    lblColor.font = [UIFont boldSystemFontOfSize:20];
    
    Theater *t = self.theaterList[row];
    lblColor.text = t.theaterName;
    return lblColor;
}


//Phuong thuc xu ly khi chon mot dong trong component
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    Theater *t = self.theaterList[row];
    self.txtTheater.text = t.theaterName;
    self.currentTheater = t;
    self.currentTheater.row = row;
    self.butTheater.titleLabel.text = t.theaterName;
    
    // 1
    NSString *dataUrl = [NSString stringWithFormat:@"http://ntnk1894.somee.com/api/getFilmSchedulesByTheater_Result?FilmID=%@&TheaterID=%@", _currentItem.id, _currentTheater.theaterID];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    
    NSURLSessionDataTask *getFilmSchedulesByTheater_Result = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              //NSLog(@"response header: %@", response);
                                              
                                              NSString* aStr;
                                              aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                              //NSLog(@"response data: %@", aStr);
                                              
                                              NSArray *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              self.ScheduleList = [[NSMutableArray alloc] init];
                                              for (NSDictionary *dic in json) {
                                                  ScheduleTime *st = [[ScheduleTime alloc]init];
                                                  st.filmTimes = [dic objectForKey:@"scheduletimes"];
                                                  st.filmDate = [dic objectForKey:@"scheduledate"];
                                                  [self.ScheduleList addObject:st];

                                              }
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.tbvSchedule reloadData];
                                                  
                                                  
                                                  
                                                  [self.butTheater setTitle:self.currentTheater.theaterName forState:UIControlStateNormal];
                                                  [self.butTheater setTitle:self.currentTheater.theaterName forState:UIControlEventTouchDown];
                                              });
                                              
                                              
                                          }];
    
    // 3
    [getFilmSchedulesByTheater_Result resume];
    
  

    
    
    
    
    [self hidePickerView];
}

-(void)showPickerView{
    if (self.currentTheater == nil) {
        self.currentTheater.row = 1;
    }
    
    self.pickerSheet = [UIAlertController alertControllerWithTitle:@"Chọn rạp" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.theaterPickerView = [[UIPickerView alloc]initWithFrame:CGRectZero];
    self.theaterPickerView.dataSource = self;
    self.theaterPickerView.delegate = self;
    self.theaterPickerView.showsSelectionIndicator = YES;
    [self.theaterPickerView selectRow:self.currentTheater.row inComponent:0 animated:YES];
    [self.pickerSheet.view addSubview:self.theaterPickerView];
    self.theaterPickerView.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *view = self.theaterPickerView;
    [self.pickerSheet.view addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"V:|[view]|"
                                           options:0l
                                           metrics:nil
                                           views:NSDictionaryOfVariableBindings(view)]];
    
    [self.pickerSheet.view addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:|[view]|"
                                           options:0l
                                           metrics:nil
                                           views:NSDictionaryOfVariableBindings(view)]];
    [self presentViewController:self.pickerSheet animated:YES completion:^{
    }];
    
}

-(void)hidePickerView{
    [self.pickerSheet dismissViewControllerAnimated:YES completion:^{
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (IBAction)butTheaterClick:(UIButton *)sender {
    [self showPickerView];
}


- (IBAction)playVideo:(UIButton *)sender {
    PlayerViewController *player = [self.storyboard instantiateViewControllerWithIdentifier:@"player"];
    
    
    player.filmID = self.currentItem.filmID;
    
    
    
    [self.navigationController pushViewController:player animated:true];
}
@end

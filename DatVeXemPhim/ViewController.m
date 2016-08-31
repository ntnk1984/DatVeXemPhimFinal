//
//  ViewController.m
//  DatVeXemPhim
//
//  Created by ngolehoang on 7/30/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import "ViewController.h"
#import "FilmPlayingTableViewCell.h"
#import "Film.h"
#import "DetailViewController.h"
#import "MySegmentedControl.h"
#import "PlayerViewController.h"
#define baseUrl @"http://192.168.159.1/api.cinema/api/"
//#define baseUrl @"http://ntnk1894.somee.com/api/"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    //NSMutableDictionary *data=[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"]];
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSString *path = [documentsDirectory stringByAppendingPathComponent:@"modified.plist"];
    
    //if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    //{
      //  path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        //[data writeToFile:path atomically:YES];
    //}
    
    //self.root = [[NSDictionary alloc] init];
    //Doc file tu Bundle cua ung dung
    //[self readFileInBundle];
    //Copy file tu bundle -> Documents
    //[self copyFileIfNeed];
    /*
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    //Lay duong dan den tap tin .plist trong Documents
    NSString *filePathInDocument = [documentPath stringByAppendingPathComponent:@"modifiedData.plist"];
    NSString *filePathInBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSError *error;
    //Copy file tu Bunlde->Documents
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager copyItemAtPath:filePathInBundle toPath:filePathInDocument error:&error];
    */
    
    //[self readFileInDocumentWithFileName:@"modifiedData.plist"];

    [_segControl setSelectedSegmentIndex:0];
    [_segControl addTarget:self action:@selector(segValueChange:) forControlEvents: UIControlEventValueChanged];
    
    //[_segControl sendActionsForControlEvents:UIControlEventValueChanged];
    
    self.tbvFilmPlaying.delegate = self;
    self.tbvFilmPlaying.dataSource = self;
    
    self.segControl.layer.borderColor= (__bridge CGColorRef _Nullable)([UIColor greenColor]);
    self.segControl.layer.cornerRadius = 0.0;
    self.segControl.layer.borderWidth = 0.0f;
    
    
   
    // Set background images
    UIImage *normalBackgroundImage = [UIImage imageNamed:@"mySegCtrl-normal-bkgd.png"];
    //[self.segControl setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *selectedBackgroundImage = [UIImage imageNamed:@"mySegCtrl-selected-bkgd.png"];
    //[self.segControl setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected | UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    
    [self.segControl setBackgroundImage:normalBackgroundImage
                    forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segControl setBackgroundImage:selectedBackgroundImage
                    forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segControl setBackgroundImage:normalBackgroundImage
                    forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self.segControl setBackgroundImage:selectedBackgroundImage
                    forState:UIControlStateSelected | UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    // Set divider images
    
    [self.segControl   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-none-selected.png"]
        forLeftSegmentState:UIControlStateNormal
          rightSegmentState:UIControlStateNormal
                 barMetrics:UIBarMetricsDefault];
    
    [self.segControl   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-left-selected.png"]
        forLeftSegmentState:UIControlStateSelected
          rightSegmentState:UIControlStateNormal
                 barMetrics:UIBarMetricsDefault];
    [self.segControl   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-left-selected.png"]
        forLeftSegmentState:UIControlStateSelected | UIControlStateHighlighted
          rightSegmentState:UIControlStateNormal
                 barMetrics:UIBarMetricsDefault];
    [self.segControl   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-left-selected.png"]
        forLeftSegmentState:UIControlStateSelected
          rightSegmentState:UIControlStateHighlighted
                 barMetrics:UIBarMetricsDefault];
    
    [self.segControl   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-right-selected.png"]
        forLeftSegmentState:UIControlStateHighlighted
          rightSegmentState:UIControlStateSelected
                 barMetrics:UIBarMetricsDefault];
    [self.segControl   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-right-selected.png"]
        forLeftSegmentState:UIControlStateNormal
          rightSegmentState:UIControlStateSelected | UIControlStateHighlighted
                 barMetrics:UIBarMetricsDefault];
    [self.segControl   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-right-selected.png"]
        forLeftSegmentState:UIControlStateNormal
          rightSegmentState:UIControlStateSelected
                 barMetrics:UIBarMetricsDefault];
    //
    [self.segControl setContentPositionAdjustment:UIOffsetMake(20 / 2, 0) forSegmentType:UISegmentedControlSegmentLeft barMetrics:UIBarMetricsDefault];
    [self.segControl setContentPositionAdjustment:UIOffsetMake(- 20 / 2, 0) forSegmentType:UISegmentedControlSegmentRight barMetrics:UIBarMetricsDefault];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:baseUrl forKey:@"baseUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // 1
    NSString *dataUrl = [NSString stringWithFormat:@"%@%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"baseUrl"], @"getFilmList_Result"];
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
                                              
                                              self.root = [[NSMutableArray alloc] initWithArray:json];
                                              [_segControl sendActionsForControlEvents:UIControlEventValueChanged];
                                          }];
    
    // 3
    [downloadTask resume];
    
    
    
   }


//Doc file trong bundle
-(void)readFileInBundle{
    //Lay duong dan den main bundle
    NSBundle *mainBundle = [NSBundle mainBundle];
    //Lay duong dan den tap tin Test.plist
    NSString *filePath = [mainBundle pathForResource:@"Data" ofType:@"plist"];
    
    //Khai bao fileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //Kiem tra su ton tai cua file
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist) { //isExist == true
        //Doc noi dung cua tap tin
        
        
    }
}
//Copy file tu bundle vao Documents
-(void)copyFileIfNeed{
    //Lay duong dan den thu muc Document
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    //Lay duong dan den tap tin .plist trong Documents
    NSString *filePathInDocument = [documentPath stringByAppendingPathComponent:@"modifiedData.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:filePathInDocument]) {
        NSString *filePathInBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        NSError *error;
        //Copy file tu Bunlde->Documents
        [fileManager copyItemAtPath:filePathInBundle toPath:filePathInDocument error:&error];
        if (!error) {//Neu viec copy khong co loi
            NSLog(@"Copy Successfully");
        }
        else{
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    else{
        NSLog(@"File exist at path: %@",filePathInDocument);
    }
    
}

//Doc file tu Document
-(void)readFileInDocumentWithFileName:(NSString *)fileName{
    //Lay duong dan den thu muc Document
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    //Lay duong dan den tap tin Test.plist trong Documents
    NSString *filePathInDocument = [documentPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePathInDocument]) {
        //self.root = [NSDictionary dictionaryWithContentsOfFile:filePathInDocument];
        //[self updateUI:myDict];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //trả về số phim trong danh sách
    return self.filmsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"cell_id";
    FilmPlayingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    //lấy phim ở vị trí của dòng hiện tại
    Film *filmDetail = [self.filmsList objectAtIndex:indexPath.row];
    //truyền dữ liệu lên các control trên cell thông qua các IBOutlet đã kết nối.
    [cell.imvFilmImage setImage:[UIImage imageWithData: filmDetail.dataThumnail]];
    //cell.imvFilmImage.image = [UIImage imageNamed:filmDetail.filmImage];
    cell.butPlay.tag = indexPath.row;
    
    cell.lblFilmName.text = filmDetail.filmName;
    //để định dạng ngày tháng về dạng ngày/tháng/năm ta dùng NSDateFormatter
    //NSDateFormatter* format = [[NSDateFormatter alloc]init];
    //Xét định dạng: 23/09/2015
    //[format setDateFormat:@"dd/MM/yyyy"];
    //Tạo ra chuỗi ngày hiển thị theo định dạng đã được xét ở trên từ tham số ngày truyền vào
    //NSString *date = [format stringFromDate:filmDetail.filmDateStart];
    cell.lblFilmDateStart.text = [NSString stringWithFormat:@"Ngày: %@",filmDetail.filmDateStart];
    //Tính số hình ngôi sao sẽ hiển thị với điểm bình chọn cao nhất là 10 và số ngôi sao hiển thị tương ứng là 5.
    //Do đó ta lấy điểm bình chọn chia 2 và làm tròn số
    //ví dụ: 4.25 => 4 || 4.75 => 5
    int star = round([filmDetail.filmVote doubleValue]/2.0f);
    //x để lưu tọa độ của hình ngôi sao
    int x = 0;
    for (int i = 0; i < star; i++) {
        //khởi tạo imageview để chứa hình ngôi sao
        UIImageView *imvStar = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, 20, 20)];
        imvStar.image = [UIImage imageNamed:@"star.png"];
        //hiển thị hình ngôi sao lên view
        [cell.vFilmVote addSubview:imvStar];
        //tính tọa độ hình ngôi sao tiếp theo
        x+=20;
    }
    
    
    //trả về ô đã truyền đầy đủ dữ liệu
    
    return cell;
}



- (IBAction)segValueChange:(UISegmentedControl *)sender {
    
    self.filmsList = [[NSMutableArray alloc]init];
    
    //NSString *lisFilm = [[NSString alloc]init];
    switch (self.segControl.selectedSegmentIndex) {
        case 0:
            for (NSDictionary *dic in self.root) {
                NSString *filmStatus = [dic objectForKey:@"filmstatus"];
                
                if ([filmStatus  isEqual: @"1"]) {
                    //khởi tạo một đối tượng film từ một NSDictionary truyền vào
                    Film *f = [[Film alloc]initWithDictionary:dic];
                    f.filmsPlaying = [NSString stringWithFormat:@"%ld", (long)self.segControl.selectedSegmentIndex];
                    [self.filmsList addObject:f];
                    
                }
            }

            break;
        case 1:
            for (NSDictionary *dic in self.root) {
                NSString *filmStatus = [dic objectForKey:@"filmstatus"];
                
                if ([filmStatus  isEqual: @"2"]) {
                    //khởi tạo một đối tượng film từ một NSDictionary truyền vào
                    Film *f = [[Film alloc]initWithDictionary:dic];
                    f.filmsPlaying = [NSString stringWithFormat:@"%ld", (long)self.segControl.selectedSegmentIndex];
                    [self.filmsList addObject:f];
                    
                }
            }

            break;
        default:
            for (NSDictionary *dic in self.root) {
                NSString *filmStatus = [dic objectForKey:@"filmstatus"];
                
                if ([filmStatus  isEqual: @"1"]) {
                    //khởi tạo một đối tượng film từ một NSDictionary truyền vào
                    Film *f = [[Film alloc]initWithDictionary:dic];
                    f.filmsPlaying = [NSString stringWithFormat:@"%ld", (long)self.segControl.selectedSegmentIndex];
                    [self.filmsList addObject:f];
                    
                }
            }

            break;
    }
    
    //[self readFileInDocumentWithFileName:@"modifiedData.plist"];
    //NSArray *films = [self.root objectForKey:lisFilm];

    /*
    for (NSDictionary *dic in films) {
        //khởi tạo một đối tượng film từ một NSDictionary truyền vào
        Film *f = [[Film alloc]initWithDictionary:dic];
        f.filmsPlaying = [NSString stringWithFormat:@"%ld", (long)self.segControl.selectedSegmentIndex];
        [self.filmsList addObject:f];
    }
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tbvFilmPlaying reloadData];

    });
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Khoi tao view voi story board
    DetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    //Pass data
    Film *currentItem = self.filmsList[indexPath.row];
    detailView.currentItem = currentItem;
    //push view
    [self.navigationController pushViewController:detailView animated:true];
}
- (IBAction)playVideo:(UIButton *)sender {
    PlayerViewController *player = [self.storyboard instantiateViewControllerWithIdentifier:@"player"];
    
    Film *f = self.filmsList[sender.tag];
    player.filmID = f.filmID;
    
    
    
    [self.navigationController pushViewController:player animated:true];
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
            
            //NSLog(@"%@",video_id);
        }
    }
    
    NSString* thumbImageUrl = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/default.jpg",video_id];
    
    return thumbImageUrl;
}


@end

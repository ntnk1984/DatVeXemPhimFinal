//
//  BookingViewController.m
//  DatVeXemPhim
//
//  Created by ngolehoang on 8/1/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import "BookingViewController.h"


@interface BookingViewController ()

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.seatList = [[NSMutableArray alloc]init];
    self.selectedSeats = [[NSMutableArray alloc]init];
    self.collectionView.allowsMultipleSelection = true;
    self.normalSeats = [[NSMutableArray alloc] init];
    self.vipSeats = [[NSMutableArray alloc] init];
    self.dicSeats = [[NSMutableDictionary alloc] init];
    
    int stt_row = 0;
    
    for (int i =0; i<72; i++) {
        NSString *seatName = [NSString stringWithFormat:@"%d",i];
        [self.seatList addObject:seatName];
        
        NSString *row = [[NSString alloc] init];
        
        switch (i / 9) {
            case 0:
                stt_row = 0;
                row = @"A";
                break;
            case 1:
                stt_row = 1;
                row = @"B";
                break;
            case 2:
                stt_row = 2;
                row = @"C";
                break;
            case 3:
                stt_row = 3;
                row = @"D";
                break;
            case 4:
                stt_row = 4;
                row = @"E";
                break;
            case 5:
                stt_row = 5;
                row = @"F";
                break;
            case 6:
                stt_row = 6;
                row = @"G";
                break;
            case 7:
                stt_row = 7;
                row = @"H";
                break;
                
                
            default:
                break;
        }
        
        //NSLog(@"%@", [row stringByAppendingString:[NSString stringWithFormat:@"%d", i+1 - (stt_row * 9)]]);
        
        [self.dicSeats setValue:[row stringByAppendingString:[NSString stringWithFormat:@"%d", i+1 - (stt_row * 9)]] forKey:[NSString stringWithFormat:@"%d", i]];
        
        [self tinhTongTien];
        
        
    }
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:[UIImage imageNamed:@"BackButton.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton addTarget:self action:@selector(backButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

        
    
    NSString *str0 = [[NSString stringWithFormat:@"%@", _currentFilm.filmName] uppercaseString];
    NSString *str1 = @"Suất chiếu:";
    NSString *str2 = [NSString stringWithFormat:@"%@", _currentSchedule.filmTime ];
    NSString *str3 = @"Ngày chiếu:";
    NSString *str4 = [NSString stringWithFormat:@"%@", _currentSchedule.filmDate ];
    
    NSString *strComplete = [NSString stringWithFormat:@"%@\r%@ %@ %@ %@", str0, str1, str2, str3, str4];
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
                    value:[UIColor blackColor]
                    range:[strComplete rangeOfString:str2]];
    
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:[strComplete rangeOfString:str4]];
    [strInfo addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]
                    range:[strComplete rangeOfString:str4]];
     
    self.tvFilmDetail.attributedText = strInfo;
     
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


#pragma mark - Collection View DataSource
//So luong item trong tung sectin
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.seatList.count;
}

//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    //configure cell
    //lay image view  tren cell theo tag
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:10];
    if (indexPath.row < 27 || indexPath.row > 53)
        imageView.backgroundColor = [UIColor orangeColor];
    else
        imageView.backgroundColor = [UIColor redColor];

    NSString *string = self.currentFilm.filmBookings;
    NSArray *stringArray = [string componentsSeparatedByString: @","];
    for (int i = 0 ; i < [stringArray count ] ; i++) {
        
        
        if ([[stringArray objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]){
            imageView.backgroundColor = [UIColor purpleColor];
        }
        
    }
    
    
    
    //Lay hinh trong mang photoList
    //UIImage *image = [UIImage imageNamed:self.photoList[indexPath.row]];
    //UIImage *image = [[UIImage alloc ]init];
    
    //imageView.image = image;
    return cell;
}

#pragma mark - Collection view delegate flow layout
//Tuy chinh kich thuoc mot item
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/10,collectionView.frame.size.width/10 );
}

#pragma mark Collectin view delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //them item duoc chon vao mang
    /*
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect cellRect = attributes.frame;
    
    CGRect cellFrameInSuperview = [collectionView convertRect:cellRect toView:[collectionView superview]];
    
    NSLog(@"%f",cellFrameInSuperview.origin.x);
    */
    NSString *string = self.currentFilm.filmBookings;
    
    NSArray *stringArray = [string componentsSeparatedByString: @","];
    for (int i = 0 ; i < [stringArray count ] ; i++) {
        if ([[stringArray objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%ld", (long)indexPath.row]])
        {
            return;
        }
        
    }

    [self.selectedSeats addObject:self.seatList[indexPath.row]];
    
    if (indexPath.row < 27 || indexPath.row > 53)
    {
        [self.normalSeats addObject:self.seatList[indexPath.row]];
    }
    else
        [self.vipSeats addObject:self.seatList[indexPath.row]];
    
    //lay cell duoc chon
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = cell.frame;
    frame.size.height = 20;
    frame.size.width = 20;
    cell.frame = frame;
    
    //thiet lap selected background cho cell duoc chon
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor greenColor];
    
    cell.selectedBackgroundView = imageView;
    
    [cell bringSubviewToFront:cell.selectedBackgroundView];

   
    
    [self tinhTongTien];
}
-(void)tinhTongTien{
    long tt = [self.normalSeats count] * 135000 + [self.vipSeats count] * 155000;
    NSString *TongTien = [NSNumberFormatter localizedStringFromNumber:@(tt)
                                                          numberStyle:NSNumberFormatterDecimalStyle];
    
    self.lblTongTien.text = TongTien;
    self.lblTongTien.text = [NSString stringWithFormat:@"Tổng tiền: %@", TongTien];
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = self.currentFilm.filmBookings;
    
    NSArray *stringArray = [string componentsSeparatedByString: @","];
    for (int i = 0 ; i < [stringArray count ] ; i++) {
        if ([[stringArray objectAtIndex:i] isEqual:[NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row]])
        {
           
            return false;
        }
        
    }
    
    return true;

}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = self.currentFilm.filmBookings;
    
    NSArray *stringArray = [string componentsSeparatedByString: @","];
    for (int i = 0 ; i < [stringArray count ] ; i++) {
        if ([[stringArray objectAtIndex:i] isEqual:[NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row]])
        {
            
            return false;
        }
        
    }
    
    return true;
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = self.currentFilm.filmBookings;
    
    NSArray *stringArray = [string componentsSeparatedByString: @","];
    for (int i = 0 ; i < [stringArray count ] ; i++) {
        if ([[stringArray objectAtIndex:i] isEqual:[NSString stringWithFormat:@"%lu", (unsigned long)indexPath.row]])
        {
            //lay cell duoc chon
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            CGRect frame = cell.frame;
            frame.size.height = 20;
            frame.size.width = 20;
            cell.frame = frame;
            
            //thiet lap selected background cho cell duoc chon
            
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.backgroundColor = [UIColor greenColor];
            
            cell.selectedBackgroundView = imageView;
            
            [cell bringSubviewToFront:cell.selectedBackgroundView];
            return;
        }
        
    }
    
    //xoa item khoi selectedSeats
    [self.selectedSeats removeObject:self.seatList[indexPath.row]];
    
    if (indexPath.row < 27 || indexPath.row > 53)
        [self.normalSeats removeObject:self.seatList[indexPath.row]];
    else
        [self.vipSeats removeObject:self.seatList[indexPath.row]];
    
    [self tinhTongTien];
    
}

- (IBAction)butFinish:(UIButton *)sender {
    
    NSString *normalmessage = [[NSString alloc] init];
    if ([self.normalSeats count] > 0) {
        
        normalmessage = [NSString stringWithFormat:@"%lu vé thường 135,000/vé", (unsigned long)[self.normalSeats count]];
    }
    
    NSString *vipmessage = [[NSString alloc] init];
    if ([self.vipSeats count] > 0) {
        vipmessage = [NSString stringWithFormat:@"%lu vé VIP 155,000/vé", (unsigned long)[self.vipSeats count]];
    }
    
    NSString *message = [[NSString alloc] init];
    NSString *title = [[NSString alloc] init];
    
    if ([self.normalSeats count] == 0 && [self.vipSeats count] == 0) {
        title = @"";
        message = [NSString stringWithFormat:@"Vui lòng chọn ghế."];
    }
    else
    {
        title = @"Xác nhận";
        NSString *seatName = [[NSString alloc] init];
        for (NSObject *s in self.selectedSeats) {
            seatName = [seatName stringByAppendingString:[self.dicSeats objectForKey:[NSString stringWithFormat:@"%@", s]]];
            seatName = [seatName stringByAppendingString:@" "];
        }
        
      
        
        message = [NSString stringWithFormat:@"Bạn đã đặt vé %@ suất %@ ngày %@ bao gồm: %@ %@. Tổng tiền: %@ ", seatName, _currentSchedule.filmTime, _currentSchedule.filmDate, normalmessage, vipmessage, self.lblTongTien.text];
    }
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Huỷ"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Mua"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   /*
                                   NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
                                   
                                   NSString *filePathInDocument = [documentPath stringByAppendingPathComponent:@"modifiedData.plist"];
                                   

                                   NSMutableDictionary *root =[NSMutableDictionary dictionaryWithContentsOfFile:filePathInDocument];
                                   NSMutableArray *films = [root objectForKey:@"FilmsPlaying"];
                                
                                   

                                   for (NSMutableDictionary *dic in films) {
                                       Film *f = [[Film alloc]initWithDictionary:dic];
                                       
                                       
                                       if (f.filmID == self.currentFilm.filmID) {
                                           
                                           
                                           for (NSObject *obj in self.selectedSeats) {
                                               
                                               self.currentFilm.filmBookings = [self.currentFilm.filmBookings stringByAppendingString:[NSString stringWithFormat:@",%@", obj]];
                                               f.filmBookings = [self.currentFilm.filmBookings stringByAppendingString:[NSString stringWithFormat:@",%@", obj]];
                                               
                                               for (int i =0; i<films.count; i++) {
                                                   NSDictionary *di = [films objectAtIndex:i];
                                                   
                                                   if ([[di objectForKey:@"ZFILMID"] isEqual:f.filmID]) {
                                                       [di setValue:[self.currentFilm.filmBookings stringByAppendingString:[NSString stringWithFormat:@",%@", obj]] forKey:@"ZFILMBOOKINGS"];
                                                   }
                                               }
                                               
                                               
                                               
                                               

                                           }
                        
                                           
                                           break;
                                       }
                                       
                                   }

                                   */
                                   
                                   //NSLog(@"%@", root);
                                   
                                   
                                  //BOOL kq = [root writeToFile:filePathInDocument atomically:YES];
                                   //NSLog(@"%d", kq);
                                   
                                   [self.collectionView reloadData];
                                   [self.normalSeats removeAllObjects];
                                   [self.vipSeats removeAllObjects];
                                   
                                   [self tinhTongTien];
                               }];
    
    if ([self.normalSeats count] == 0 && [self.vipSeats count] == 0) {
        [alertController addAction:cancelAction];
    }
    else
    {
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
    }
    
    
    if (self.presentedViewController == nil) {
        [self presentViewController:alertController animated:YES completion:nil];
    }
   
    
    
}

@end

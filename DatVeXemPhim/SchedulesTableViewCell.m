//
//  SchedulesTableViewCell.m
//  DatVeXemPhim
//
//  Created by Nguyen Khang on 8/14/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import "SchedulesTableViewCell.h"
#import "BookingViewController.h"


@implementation SchedulesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //NSLog(@"%@", self.ScheduleList);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ScheduleTimeList.count;
}

//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    //NSLog(@"%@", self.ScheduleTimeList);
    //configure cell
    //lay image view  tren cell theo tag
    /*
    for (NSObject *obj in self.ScheduleTimeList) {
        UIButton *button = (UIButton *)[cell viewWithTag:10];
        
        button.titleLabel.text = [NSString stringWithFormat:@"%@", obj];
    }
    */
    UILabel *button = (UILabel *)[cell viewWithTag:10];
    [button.layer setBorderWidth:1.0];
    button.layer.cornerRadius = 5.0;
    [button.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    
    ScheduleTime *time = self.ScheduleTimeList[indexPath.row];
    button.text = time.filmTime;
    
    //Lay hinh trong mang photoList
    //UIImage *image = [UIImage imageNamed:self.photoList[indexPath.row]];
    //UIImage *image = [[UIImage alloc ]init];
    
    //imageView.image = image;
    return cell;
}

#pragma mark - Collection view delegate flow layout
//Tuy chinh kich thuoc mot item
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50,33);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
    BookingViewController *booking = [self.sb instantiateViewControllerWithIdentifier:@"booking"];
    
    booking.currentFilm = self.currentFilm;
    ScheduleTime *time = self.ScheduleTimeList[indexPath.row];
    booking.currentSchedule = time;
    
    [self.parent.navigationController pushViewController:booking animated:true];
}
/*
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleTime *currentItem = self.ScheduleList[indexPath.row];
    self.currentTime = currentItem.filmTime;
    
    
    
    
    
}
*/
- (IBAction)okBook:(UIButton *)sender {
    //[self performSegueWithIdentifier:@"segBooking" sender:sender];
    
    
}


@end

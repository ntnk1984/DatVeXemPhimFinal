//
//  FilmPlayingTableViewCell.h
//  DatVeXemPhim
//
//  Created by ngolehoang on 7/30/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmPlayingTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imvFilmImage;

@property (strong, nonatomic) IBOutlet UILabel *lblFilmName;


@property (strong, nonatomic) IBOutlet UIView *vFilmVote;
@property (strong, nonatomic) IBOutlet UILabel *lblFilmDateStart;

@property (weak, nonatomic) IBOutlet UIButton *butPlay;




- (IBAction)playVideo:(UIButton *)sender;

@end

//
//  ViewController.h
//  DatVeXemPhim
//
//  Created by ngolehoang on 7/30/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UITableView *tbvFilmPlaying;

@property (strong, nonatomic) NSMutableArray *root;
@property (strong, nonatomic) NSMutableArray *filmsList;
- (IBAction)segValueChange:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;


- (IBAction)playVideo:(UIButton *)sender;

@end


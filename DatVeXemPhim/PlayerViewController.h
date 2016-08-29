//
//  demoYTViewController.h
//  DatVeXemPhim
//
//  Created by Nguyen Khang on 8/29/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface PlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;
@property (nonatomic)NSString *filmID;
@end

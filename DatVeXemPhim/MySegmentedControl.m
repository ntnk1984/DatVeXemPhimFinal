//
//  MySegmentedControl.m
//  DatVeXemPhim
//
//  Created by ngolehoang on 8/3/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import "MySegmentedControl.h"

@implementation MySegmentedControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        // Set background images
        UIImage *normalBackgroundImage = [UIImage imageNamed:@"mySegCtrl-normal-bkgd.png"];
        //[self.segControl setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        UIImage *selectedBackgroundImage = [UIImage imageNamed:@"mySegCtrl-selected-bkgd.png"];
        //[self.segControl setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected | UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        
        
        [self setBackgroundImage:normalBackgroundImage
                                   forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:selectedBackgroundImage
                                   forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:normalBackgroundImage
                                   forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:selectedBackgroundImage
                                   forState:UIControlStateSelected | UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        
        // Set divider images
        
        [self   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-none-selected.png"]
                       forLeftSegmentState:UIControlStateNormal
                         rightSegmentState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
        
        [self   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-left-selected.png"]
                       forLeftSegmentState:UIControlStateSelected
                         rightSegmentState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
        [self   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-left-selected.png"]
                       forLeftSegmentState:UIControlStateSelected | UIControlStateHighlighted
                         rightSegmentState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
        [self   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-left-selected.png"]
                       forLeftSegmentState:UIControlStateSelected
                         rightSegmentState:UIControlStateHighlighted
                                barMetrics:UIBarMetricsDefault];
        
        [self   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-right-selected.png"]
                       forLeftSegmentState:UIControlStateHighlighted
                         rightSegmentState:UIControlStateSelected
                                barMetrics:UIBarMetricsDefault];
        [self   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-right-selected.png"]
                       forLeftSegmentState:UIControlStateNormal
                         rightSegmentState:UIControlStateSelected | UIControlStateHighlighted
                                barMetrics:UIBarMetricsDefault];
        [self   setDividerImage:[UIImage imageNamed:@"mySegCtrl-divider-right-selected.png"]
                       forLeftSegmentState:UIControlStateNormal
                         rightSegmentState:UIControlStateSelected
                                barMetrics:UIBarMetricsDefault];
        //
        [self setContentPositionAdjustment:UIOffsetMake(30 / 2, 0) forSegmentType:UISegmentedControlSegmentLeft barMetrics:UIBarMetricsDefault];
        [self setContentPositionAdjustment:UIOffsetMake(- 30 / 2, 0) forSegmentType:UISegmentedControlSegmentRight barMetrics:UIBarMetricsDefault];
    }
    return self;
}

@end

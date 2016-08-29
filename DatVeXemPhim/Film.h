//
//  Film.h
//  DatVeXemPhim
//
//  Created by ngolehoang on 7/30/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Film : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *filmContent;
@property (nonatomic, strong) NSDate *filmDateStart;
@property (nonatomic, strong) NSString *filmDirector;
@property (nonatomic, strong) NSString *filmID;
@property (nonatomic, strong) NSString *filmImage;
@property (nonatomic, strong) NSString *filmName;
@property (nonatomic, strong) NSNumber *filmTime;
@property (nonatomic, strong) NSString *filmType;
@property (nonatomic, strong) NSNumber *filmVote;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, strong) NSString *filmTrailerURL;
@property (nonatomic, strong) NSString *filmBookings;
@property (nonatomic, strong) NSString *filmsPlaying;
@property (nonatomic, strong) NSData *dataThumnail;
@end

//
//  Film.m
//  DatVeXemPhim
//
//  Created by ngolehoang on 7/30/16.
//  Copyright © 2016 VNPOST. All rights reserved.
//

#import "Film.h"

@implementation Film

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self.id = [dic objectForKey:[@"id" lowercaseString]];
    self.filmContent = [dic objectForKey:[@"FILMCONTENT" lowercaseString]];
    self.filmDateStart = [dic objectForKey:[@"FILMDATESTART" lowercaseString]];
    self.filmDirector = [dic objectForKey:[@"FILMDIRECTOR" lowercaseString]];
    self.filmID = [dic objectForKey:[@"FILMID" lowercaseString]];
    self.filmImage = [dic objectForKey:[@"FILMIMAGE" lowercaseString]];
    self.filmName = [dic objectForKey:[@"FILMNAME" lowercaseString]];
    self.filmTime = [dic objectForKey:[@"FILMTIME" lowercaseString]];
    self.filmType = [dic objectForKey:[@"FILMTYPE" lowercaseString]];
    self.filmVote = [dic objectForKey:[@"FILMVOTE" lowercaseString]];
    //self.filmTrailerURL = [dic objectForKey:@"FILMTRAILERURL"];
    //self.filmBookings = [dic objectForKey:@"ZFILMBOOKINGS"];
    
    
    NSString *videoThumbUrl = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/default.jpg", self.filmID];
    
    NSURL* videoURL =[NSURL URLWithString: videoThumbUrl];
    
    //[_imageViewThumnail setImageWithURL:videoURL forState:UIControlStateNormal];
    self.dataThumnail = [NSData dataWithContentsOfURL:videoURL];
    
    
    
    return self;
}

@end

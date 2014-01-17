//
//  IDZMovie.h
//  Rotten Tomatoes
//
//  Created by Anthony Powles on 15/01/14.
//  Copyright (c) 2014 Anthony Powles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDZMovie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *synopsis;

@property (strong, nonatomic) NSString *thumbUrl;
@property (strong, nonatomic) UIImage *thumbImage;

@property (strong, nonatomic) NSString *posterUrl;
@property (strong, nonatomic) UIImage *posterImage;

- (IDZMovie *)initWithDictionary:(NSDictionary *)movie;
- (NSString *)castText;

@end

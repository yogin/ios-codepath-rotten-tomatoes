//
//  IDZMovie.m
//  Rotten Tomatoes
//
//  Created by Anthony Powles on 15/01/14.
//  Copyright (c) 2014 Anthony Powles. All rights reserved.
//

#import "IDZMovie.h"

@interface IDZMovie ()

@property NSDictionary *movie;
@property NSMutableArray *castMembers;

@end

@implementation IDZMovie

- (IDZMovie *)initWithDictionary:(NSDictionary *)movie
{
	self = [super init];

	if (self) {
		self.movie = movie;
		NSLog(@"movie: %@", self.movie);
	
		[self setTitle:self.movie[@"title"]];
		[self setSynopsis:self.movie[@"synopsis"]];
		[self setThumbUrl:self.movie[@"posters"][@"profile"]];
		[self setPosterUrl:self.movie[@"posters"][@"original"]];

		self.castMembers = [[NSMutableArray alloc] init];
		for (NSDictionary *cast in self.movie[@"abridged_cast"]) {
			[self.castMembers addObject:cast[@"name"]];
		}
	}

	return self;
}

- (NSString *)castText
{
	return [self.castMembers componentsJoinedByString:@", "];
}

@end

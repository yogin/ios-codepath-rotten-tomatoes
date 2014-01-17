//
//  IDZMovieListViewController.m
//  Rotten Tomatoes
//
//  Created by Anthony Powles on 15/01/14.
//  Copyright (c) 2014 Anthony Powles. All rights reserved.
//

#import "IDZMovieListViewController.h"
#import "IDZMovie.h"
#import "IDZMovieCell.h"
#import "IDZMovieDetailViewController.h"
#import <UIImageView+AFNetworking.h>

@interface IDZMovieListViewController ()

@property (strong, nonatomic) NSMutableArray *movies;

- (void)setup;

@end

@implementation IDZMovieListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		[self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
		[self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setup
{
	self.movies = [[NSMutableArray alloc] init];

	[self fetchData];
}

- (void)fetchData
{
	NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
		NSDictionary *movies = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		
		for (NSDictionary *movie in movies[@"movies"]) {
			[self.movies addObject:[[IDZMovie alloc] initWithDictionary:movie]];
		}
		
		[self.tableView reloadData];
	}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IDZMovieCell";
    IDZMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	IDZMovie *movie = self.movies[[indexPath row]];
	
	cell.titleLabel.text = movie.title;
	cell.synopsisLabel.text = movie.synopsis;
	cell.castLabel.text = movie.castText;
	[cell.thumbImage setImageWithURL:[NSURL URLWithString:movie.thumbUrl]];

    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
		IDZMovieDetailViewController *detailController = [segue destinationViewController];

		NSIndexPath *indexPath = [self.tableView indexPathForCell:(IDZMovieCell *)sender];
		IDZMovie *movie = self.movies[indexPath.row];

		[detailController setMovie:movie];
	}

}

@end

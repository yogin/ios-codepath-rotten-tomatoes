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

@interface IDZMovieListViewController ()

@property NSMutableArray *movies;

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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

	if (!movie.thumbImage) {
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);

		dispatch_async(queue, ^{
			NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.thumbUrl]];

			dispatch_sync(dispatch_get_main_queue(), ^{
				[movie setThumbImage:[UIImage imageWithData:data]];
				cell.thumbImage.image = movie.thumbImage;
				[cell setNeedsLayout];
			});
		});
	}

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

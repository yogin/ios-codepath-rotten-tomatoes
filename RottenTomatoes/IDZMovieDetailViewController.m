//
//  IDZMovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Anthony Powles on 1/16/14.
//  Copyright (c) 2014 Anthony Powles. All rights reserved.
//

#import "IDZMovieDetailViewController.h"

@interface IDZMovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;

- (IBAction)onClose:(id)sender;

@end

@implementation IDZMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	self.title = self.movie.title;
	self.summaryLabel.text = self.movie.synopsis;
	self.castLabel.text = self.movie.castText;

	if (self.movie.posterImage) {
		self.backgroundImage.image = self.movie.posterImage;
	}
	else {
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);

		dispatch_async(queue, ^{
			NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.movie.posterUrl]];

			dispatch_sync(dispatch_get_main_queue(), ^{
				[self.movie setPosterImage:[UIImage imageWithData:data]];
				self.backgroundImage.image = self.movie.posterImage;
				[self.view setNeedsLayout];
			});
		});
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setMovie:(IDZMovie *)movie
//{
//	NSLog(@"%@", movie);
//	self.backgroundImage.image = movie.thumbImage;
//	[self.view setNeedsLayout];
//}

- (IBAction)onClose:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end

//
//  IDZMovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Anthony Powles on 1/16/14.
//  Copyright (c) 2014 Anthony Powles. All rights reserved.
//

#import "IDZMovieDetailViewController.h"
#import <UIImageView+AFNetworking.h>

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
	[self.backgroundImage setImageWithURL:[NSURL URLWithString:self.movie.posterUrl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClose:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end

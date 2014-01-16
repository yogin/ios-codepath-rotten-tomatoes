//
//  IDZMovieCell.h
//  Rotten Tomatoes
//
//  Created by Anthony Powles on 15/01/14.
//  Copyright (c) 2014 Anthony Powles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDZMovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;

@end

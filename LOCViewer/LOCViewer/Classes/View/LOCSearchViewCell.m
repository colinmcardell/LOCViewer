//
//  LOCSearchViewCell.m
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCSearchViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation LOCSearchViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.contentView setBackgroundColor:[UIColor grayColor]];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.image cancelCurrentImageLoad];
}

@end

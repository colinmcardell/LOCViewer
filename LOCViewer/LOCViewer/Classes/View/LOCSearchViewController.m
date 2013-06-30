//
//  LOCSearchViewController.m
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCSearchViewController.h"
#import "LOCClient.h"
#import "LOCSearchFeed.h"
#import "LOCPicture.h"
#import "LOCSearchViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface LOCSearchViewController ()

@property (strong, nonatomic) LOCSearchFeed *searchFeed;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation LOCSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor grayColor]];
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    // Cell
    NSString *searchCellClass = NSStringFromClass([LOCSearchViewCell class]);
    UINib *searchCellNib = [UINib nibWithNibName:searchCellClass bundle:bundle];
    [self.tableView registerNib:searchCellNib forCellReuseIdentifier:searchCellClass];
    
    // Fetch some data
    [[LOCClient sharedClient] executeSearch:@"congress"
                            completionBlock:^(OVCRequestOperation *operation, id object, NSError *error) {
                                [self setSearchFeed:object];
                                [self setDataSource:[[object valueForKey:@"results"] mutableCopy]];
                                [self.tableView reloadData];
                            }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOCSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LOCSearchViewCell class])];
    
    LOCPicture *picture = [self.dataSource objectAtIndex:indexPath.section];
    
    [cell.title setText:[picture title]];
    NSString *notAvailable = @"Information Not Available";
    [cell.publish setText:[picture createdPublishedDate] ? [picture createdPublishedDate] : notAvailable];
    [cell.medium setText:[picture medium] ? [picture medium] : notAvailable];
    [cell.creator setText:[picture creator] ? [picture creator] : notAvailable];

    [cell.image setImageWithURL:[picture imageURL]
               placeholderImage:nil
                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                          // Could set the image to an error loading image or something right here...
                      }];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOCPicture *picture = [self.dataSource objectAtIndex:indexPath.row];
    DLog(@"%@", picture);
}

@end

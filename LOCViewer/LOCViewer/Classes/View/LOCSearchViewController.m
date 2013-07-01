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
#import <SVPullToRefresh/UIScrollView+SVInfiniteScrolling.h>

@interface LOCSearchViewController ()

@property (strong, nonatomic) LOCSearchFeed *searchFeed;
@property (strong, nonatomic) NSMutableArray *dataSource;

- (void)fetchNextPage;
- (void)mergeNewData:(NSArray *)newData;

@end

@implementation LOCSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    [self.tableView setBackgroundColor:[UIColor grayColor]];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if ([self_weak_.dataSource count]) {
            [self_weak_ fetchNextPage];
        }
    }];
    
    // Cell
    NSString *searchCellClass = NSStringFromClass([LOCSearchViewCell class]);
    UINib *searchCellNib = [UINib nibWithNibName:searchCellClass bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:searchCellNib forCellReuseIdentifier:searchCellClass];
    
    // Fetch some data

    [[LOCClient sharedClient] executeSearch:@"congress"
                            completionBlock:^(OVCRequestOperation *operation, id object, NSError *error) {
                                [self_weak_ setSearchFeed:object];
                                [self_weak_ setDataSource:[[object valueForKey:@"results"] mutableCopy]];
                                [self_weak_.tableView reloadData];
                            }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - Private

- (void)fetchNextPage
{
    @weakify(self);
    [[LOCClient sharedClient] fetchNextPageOfSearchFeed:[self searchFeed]
                                        completionBlock:^(OVCRequestOperation *operation, id object, NSError *error) {
                                            [self_weak_.tableView.infiniteScrollingView stopAnimating];
                                            if (!error) {
                                                [self_weak_ setSearchFeed:object];
                                                NSArray *results = [[object valueForKey:@"results"] copy];
                                                [self_weak_ mergeNewData:results];
                                            }
                                        }];
}

- (void)mergeNewData:(NSArray *)newData
{
    NSUInteger initialCount = [self.dataSource count];
    NSUInteger newCount = initialCount + [newData count];
    [self.dataSource addObjectsFromArray:newData];

    if (newCount - initialCount > 0) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:newCount - initialCount];
        for (NSUInteger i = initialCount; i < newCount; ++i) [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOCSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LOCSearchViewCell class])];
    
    LOCPicture *picture = [self.dataSource objectAtIndex:indexPath.row];
    
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

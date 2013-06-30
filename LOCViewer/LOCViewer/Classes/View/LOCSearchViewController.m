//
//  LOCSearchViewController.m
//  LOCViewer
//
//  Created by Colin McArdell on 6/30/13.
//  Copyright (c) 2013 Colin McArdell. All rights reserved.
//

#import "LOCSearchViewController.h"
#import "LOCClient.h"
#import "LOCSearchViewCell.h"

@interface LOCSearchViewController ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation LOCSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *searchCellClass = NSStringFromClass([LOCSearchViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:searchCellClass bundle:[NSBundle mainBundle]] forCellReuseIdentifier:searchCellClass];
    
    [[LOCClient sharedClient] executeSearch:@"congress" completionBlock:^(OVCRequestOperation *operation, id object, NSError *error) {
        [self setDataSource:[[object valueForKey:@"results"] mutableCopy]];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    LOCSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LOCSearchViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
@end

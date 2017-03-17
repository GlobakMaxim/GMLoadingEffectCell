//
//  ViewController.m
//  test
//
//  Created by Globak Maxim on 17/02/2017.
//  Copyright © 2017 Globak Maxim. All rights reserved.
//

#import "ViewController.h"
#import "GMLoadingTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) GMLoadingTableViewCell *loadingCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    
    UINib *cellNib = [UINib nibWithNibName:[GMLoadingTableViewCell nibName] bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:[GMLoadingTableViewCell cellIdentifier]];   
}

#pragma mark UITableView DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GMLoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GMLoadingTableViewCell cellIdentifier]];
    cell.label.text = [NSString stringWithFormat:@"Cell at index %i", (int)indexPath.row];
    cell.animationDuration = 2;
    cell.completionBlock = ^{
        NSLog(@"Done!");
        [tableView selectRowAtIndexPath:indexPath
                               animated:YES
                         scrollPosition:UITableViewScrollPositionNone];
    };
    cell.failureBlock = ^{
      NSLog(@"Fail!");
    };
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end

//
//  MainViewController.m
//  WaxPatch
//
//  Created by Yimin Tu on 12-8-10.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

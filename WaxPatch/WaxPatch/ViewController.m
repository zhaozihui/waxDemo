//
//  ViewController.m
//  WaxPatch
//
//  Created by 赵子辉 on 15/9/22.
//  Copyright © 2015年 dianping.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSString *testStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    testStr = @"显示内容";
    [self setTitle:@"我是标题OC"];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIWebView *wb = [[UIWebView alloc] init];
    NSURLRequest *url = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
    [wb loadRequest:url];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    cell.textLabel.text = testStr;
    return cell;
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"aa");
//}

@end

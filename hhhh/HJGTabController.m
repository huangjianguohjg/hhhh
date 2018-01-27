//
//  HJGTabController.m
//  hhhh
//
//  Created by Developer on 2018/1/23.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "HJGTabController.h"
#import "ViewController.h"
@interface HJGTabController ()<TYTabPagerControllerDataSource,TYTabPagerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *titleModelArr;

@property (nonatomic, strong) NSMutableArray *mostArr;


@end

@implementation HJGTabController

- (NSMutableArray *)mostArr{
    
    if (!_mostArr) {
        _mostArr = [NSMutableArray array];
    }
    return _mostArr;
    
    
}

- (NSMutableArray *)titleModelArr{
    if (!_titleModelArr) {
        _titleModelArr = [NSMutableArray array];
    }
    return _titleModelArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNot];
    [self configView];
    
    [self getTitleData];
    
[[UIApplication sharedApplication] setStatusBarHidden:YES];
}
#pragma mark - configView
- (void)configView{
    
    
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    self.dataSource = self;
    self.delegate = self;
    
}


- (void)configNot{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushData:) name:@"fff" object:nil];
    
    
}


- (void)pushData:(NSNotification *)obj{
    
    NSLog(@"%@",obj.object);
    
    [self.mostArr replaceObjectAtIndex:self.tabBar.curIndex withObject:obj.object];
    
}

#pragma mark - 获取标题数据
- (void)getTitleData{
    
    for (int i = 0; i < 100; i ++ ) {
        NSString *str = [NSString stringWithFormat:@"台%d号",i + 1];
        [self.titleModelArr addObject:str];
    }
    
    
    for (int i = 0; i < 100; i ++) {
        [self.mostArr addObject:@""];
    }
    
    [self loadData];
    
}


- (void)loadData {
    
    [self reloadData];
}

#pragma mark - TYTabPagerControllerDataSource

- (NSInteger)numberOfControllersInTabPagerController {
    return self.titleModelArr.count;
}

- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    ViewController *vc = [[ViewController alloc]init];
    vc.totalModelArr = [self.mostArr objectAtIndex:index];
    return vc;
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index {
    NSString *title = self.titleModelArr[index];
    return title;
}

@end

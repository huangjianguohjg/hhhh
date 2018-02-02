//
//  HJGTabController.m
//  hhhh
//
//  Created by Developer on 2018/1/23.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "HJGTabController.h"
#import "ViewController.h"
#import "HJGModel.h"
@interface HJGTabController ()<TYTabPagerControllerDataSource,TYTabPagerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *titleModelArr;

@property (nonatomic, strong) NSMutableArray *mostArr;

@property (nonatomic, strong) UIButton *but;


@end

@implementation HJGTabController


- (UIButton *)but
{
    if (!_but) {
        UIButton * theView = [[UIButton alloc] init];
        [theView setTitle:@"清除缓存数据" forState:0];
        [theView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        theView.backgroundColor = [UIColor blueColor];
        [theView addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:theView];
        [theView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-100);
            make.size.equalTo(CGSizeMake(150, 50));
        }];
        _but = theView;
    }
    return _but;
}

#pragma mark - butClick

- (void)butClick{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"haha"];
    
    
    [SVProgressHUD setMinimumDismissTimeInterval:2.f];
    [SVProgressHUD showInfoWithStatus:@"清除缓存成功"];
    
}

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
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *arr = [user objectForKey:@"haha"];
    
    
    NSLog(@"---%@",arr);

    NSMutableArray *bigArr = [NSMutableArray array];
    
    
    [arr enumerateObjectsUsingBlock:^( id obj_a, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        if ([obj_a isKindOfClass:[NSString class]]) {
            
            [bigArr addObject:@""];
        }else{
                NSMutableArray *smallArr = [NSMutableArray array];
            [obj_a enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                                                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:obj];
                                                    [smallArr addObject:dic];
            }];
            [bigArr addObject:smallArr];
            
        }
    }];
    
    
    [self.mostArr addObjectsFromArray:bigArr];
    
    [self configNot];
    [self configView];
    
    NSLog(@"%@",self.mostArr);
    
    
    if (arr.count > 0) {
        for (int i = 0; i < 100; i ++ ) {
            NSString *str = [NSString stringWithFormat:@"台%d号",i + 1];
            [self.titleModelArr addObject:str];
        }
        
        [self reloadData];
    }else{
        
        [self getTitleData];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
#pragma mark - configView
- (void)configView{
    
    
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    self.dataSource = self;
 
    self.delegate = self;
    [self but];
}


- (void)configNot{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushData:) name:@"fff" object:nil];
    
    
}


- (void)pushData:(NSNotification *)obj{
    
    NSLog(@"%@",obj.object);
    
    
    [self.mostArr replaceObjectAtIndex:self.tabBar.curIndex withObject:obj.object];
    
    
    NSLog(@"%@",self.mostArr);
    
    [[NSUserDefaults standardUserDefaults] setObject:self.mostArr forKey:@"haha"];
    
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

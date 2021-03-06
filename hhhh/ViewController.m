//
//  ViewController.m
//  qqq
//
//  Created by Developer on 2018/1/21.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ViewController.h"
#import "HJGTableViewCell.h"
#import "HJGModel.h"
#import <BRPickerView.h>
#import "FlLocalStoreManager.h"
#import "HJGBottomTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *rootTableView;

@property (nonatomic, strong) UIButton *addBut;

@property (nonatomic, strong) UIButton *changeBut;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) UIButton *saveBut;

@property (nonatomic, strong) UIButton *cleanBut;

@property (nonatomic, strong) UIView *bottomView;


@end

@implementation ViewController


- (UIView *)bottomView
{
    if (!_bottomView) {
        UIView * theView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        tap.numberOfTapsRequired = 2;
        [theView addGestureRecognizer:tap];
        _bottomView = theView;
    }
    return _bottomView;
}


- (void)tapClick{
    
    [self addButClick];
    
}


- (void)setTotalModelArr:(NSArray *)totalModelArr{
    
    _totalModelArr = totalModelArr;
    
    
    if ([totalModelArr isKindOfClass:[NSArray class]]) {
        
        [self.modelArr addObjectsFromArray:totalModelArr];
        
        [self.rootTableView reloadData];
        
    }
    
}


- (UIButton *)cleanBut
{
    if (!_cleanBut) {
        UIButton * theView = [[UIButton alloc] init];
        [theView setTitle:@"清除" forState:UIControlStateNormal];
        [theView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [theView addTarget:self action:@selector(cleanButClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:theView];
        [theView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(5);
            make.size.equalTo(CGSizeMake(80, 70));
            make.left.equalTo(self.saveBut.right);
        }];
        _cleanBut = theView;
    }
    return _cleanBut;
}

- (void)cleanButClick{
    
    [self.modelArr removeAllObjects];
    [self.rootTableView reloadData];
}


- (void)saveButClick{
    
//    HJGModel *model = [[HJGModel alloc]init];
//    model.change = @"2";
    
//    [self.modelArr addObject:model];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"change"] = @"2";
    [self.modelArr addObject:dic];
    [self.rootTableView reloadData];
    
}


- (UIButton *)saveBut
{
    if (!_saveBut) {
        UIButton * theView = [[UIButton alloc] init];
        [theView setTitle:@"换牌" forState:UIControlStateNormal];
        [theView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [theView addTarget:self action:@selector(saveButClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:theView];
        [theView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(5);
            make.size.equalTo(CGSizeMake(80, 70));
            make.left.equalTo(self.changeBut.right);
        }];
        _saveBut = theView;
    }
    return _saveBut;
}

- (UIButton *)changeBut
{
    if (!_changeBut) {
        UIButton * theView = [[UIButton alloc] init];
        [theView setTitle:@"新牌手" forState:0];
        [theView setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [theView addTarget:self action:@selector(changeButClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:theView];
        [theView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(5);
            make.size.equalTo(CGSizeMake(120, 70));
            make.left.equalTo(self.view);
        }];
        _changeBut = theView;
    }
    return _changeBut;
}

- (void)changeButClick{
    
//    HJGModel *model = [[HJGModel alloc]init];
//    model.change = @"1";
//    [self.modelArr addObject:model];
//    [self.rootTableView reloadData];

    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"change"] = @"1";
    [self.modelArr addObject:dic];
    [self.rootTableView reloadData];
}

- (NSMutableArray *)modelArr{
    
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
    
}



- (UIButton *)addBut
{
    if (!_addBut) {
        UIButton * theView = [[UIButton alloc] init];
        [theView setTitle:@"添加新一局" forState:0];
        [theView setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [theView addTarget:self action:@selector(addButClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:theView];
        [theView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(5);
            make.size.equalTo(CGSizeMake(120, 70));
            make.right.equalTo(self.view);
        }];
        _addBut = theView;
    }
    return _addBut;
}

- (void)addButClick{
    
//    HJGModel *model = [[HJGModel alloc]init];
//    [self.modelArr addObject:model];
//    [self.rootTableView reloadData];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.modelArr addObject:dic];
    [self.rootTableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self changeBut];
    [self addBut];
    [self rootTableView];
    
    [self cleanBut];
        [self saveBut];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addButClick];
        });
    });
}

- (UITableView *)rootTableView
{
    if (!_rootTableView) {
        UITableView * theView = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, WIDTH, HEIGHT - 70)];
        theView.delegate = self;
        theView.dataSource = self;
        [self.view addSubview:theView];
        [theView registerClass:[HJGTableViewCell class] forCellReuseIdentifier:@"cell"];
        [theView registerClass:[HJGBottomTableViewCell class] forCellReuseIdentifier:@"bCell"];
        _rootTableView = theView;
    }
    return _rootTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section

{
    return [[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelArr.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == self.modelArr.count) {
        HJGBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bCell"];
        // 双击的 Recognizer
        UITapGestureRecognizer * doubleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(douClick)];
        doubleRecognizer.numberOfTapsRequired = 2; // 双击
        //关键语句，给self.view添加一个手势监测；
        [cell.bottomView addGestureRecognizer:doubleRecognizer];
        cell.selectionStyle = 0;
        return cell;
    }
    
    HJGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.firstBut addTarget:self action:@selector(doubleClick:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [cell.firstBut  addTarget:self action:@selector(singleClick:forEvent:) forControlEvents:UIControlEventTouchDown];
    
    [cell.secondBut addTarget:self action:@selector(doubleClick:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [cell.secondBut  addTarget:self action:@selector(singleClick:forEvent:) forControlEvents:UIControlEventTouchDown];
    
    
    [cell.thirdBut addTarget:self action:@selector(doubleClick:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [cell.thirdBut  addTarget:self action:@selector(singleClick:forEvent:) forControlEvents:UIControlEventTouchDown];
    
    
    [cell.forthBut addTarget:self action:@selector(doubleClick:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [cell.forthBut  addTarget:self action:@selector(singleClick:forEvent:) forControlEvents:UIControlEventTouchDown];
    
    
    [cell.fifthBut addTarget:self action:@selector(doubleClick:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [cell.fifthBut  addTarget:self action:@selector(singleClick:forEvent:) forControlEvents:UIControlEventTouchDown];
    
    [cell.zhuangBut addTarget:self action:@selector(doubleClick:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [cell.zhuangBut  addTarget:self action:@selector(singleClick:forEvent:) forControlEvents:UIControlEventTouchDown];
    
    
    cell.model = [self.modelArr objectAtIndex:indexPath.row];
    cell.preLab.text = [NSString stringWithFormat:@"第%ld局",indexPath.row + 1];
    cell.selectionStyle = 0;
    return cell;
}


-(void)singleClick:(UIButton *)button forEvent:(UIEvent *)event{
    
    [self performSelector:@selector(cellClick:) withObject:button afterDelay:0.2];
    
}

-(void)doubleClick:(UIButton *)button forEvent:(UIEvent *)event
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cellClick:) object:button];
    
    NSLog(@"双击操作");
    
    button.layer.borderColor  = RGB(198, 198, 198).CGColor;
    [button setTitle:@"" forState:UIControlStateNormal];
    
    HJGTableViewCell *cell = (HJGTableViewCell *)[[button superview] superview];
    
    NSIndexPath *indexPa = [self.rootTableView indexPathForCell:cell];
    
    NSMutableDictionary *model = [self.modelArr objectAtIndex:indexPa.row];
    
    if (button.tag == 1) {
        model[@"Number_1"] = @"";
    }else if (button.tag == 2){
        model[@"Number_2"] = @"";
    }else if (button.tag == 3){
        model[@"Number_3"] = @"";
    }else if (button.tag == 4){
        model[@"Number_4"] = @"";
    }else if (button.tag == 5){
        model[@"Number_5"] = @"";
    }else if (button.tag == 6){
        model[@"Number_6"] = @"";
    }else if (button.tag == 7){
        model[@"Number_zhuang"] = @"";
        NSLog(@"000000_%@",model[@"Number_zhuang"]);
        
    }
    
    [self.rootTableView reloadData];
}


- (void)douClick{
    
    [self addButClick];
}

- (void)cellClick:(UIButton *)but{
    
    [self timeButClick:but];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.modelArr.count) {
        return 300;
    }
    return 50;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self getHeaderView];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 150;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (UIView *)getHeaderView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *zhuoLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 80, 20)];
    zhuoLab.textAlignment = NSTextAlignmentCenter;
    zhuoLab.text = @"           桌1       桌2      桌3    桌4     桌5";
    [view addSubview:zhuoLab];
    
    
    UILabel *zhuang = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 80, 0, 80, 20)];
    zhuang.textAlignment = NSTextAlignmentCenter;
    zhuang.text = @"庄家";
    [view addSubview:zhuang];
    return view;
    
}



- (void)timeButClick:(UIButton *)but{
    
    NSArray *arr = @[
                     @"牛1",
                     @"牛2",
                     @"牛3",
                     @"牛4",
                     @"牛5",
                     @"牛6",
                     @"牛7",
                     @"牛8",
                     @"牛9",
                     @"牛牛10",
                     @"牛牛J",
                     @"牛牛Q",
                     @"牛牛K",
                     @"无牛-1",
                     @"无牛-2",
                     @"无牛-3",
                     @"无牛-4",
                     @"无牛-5",
                     @"无牛-6",
                     @"无牛-7",
                     @"无牛-8",
                     @"无牛-9",
                     @"无牛-10",
                     @"无牛-J",
                     @"无牛-Q",
                     @"无牛-K",];
    
    @weakify_self;
    [BRStringPickerView showStringPickerWithTitle:@"飞式牛牛记牌器" dataSource:arr defaultSelValue:@"牛1----------------14" isAutoSelect:NO resultBlock:^(id selectValue) {
        @strongify_self;
        //        NSLog(@"%@",selectValue);
        
        
        if ([selectValue isEqualToString:@"牛1"]) {
            selectValue =  @"牛1----------------14";
        }
        
        if ([selectValue isEqualToString:@"牛2"]) {
            selectValue =@"牛2----------------15";
        }
        
        if ([selectValue isEqualToString:@"牛3"]) {
            selectValue =@"牛3----------------16";
        }
        
        if ([selectValue isEqualToString:@"牛4"]) {
            selectValue =@"牛4----------------17";
        }
        
        if ([selectValue isEqualToString:@"牛5"]) {
            selectValue =@"牛5----------------18";
        }
        
        if ([selectValue isEqualToString:@"牛6"]) {
            selectValue =@"牛6----------------19";
        }
        
        if ([selectValue isEqualToString:@"牛7"]) {
            selectValue =@"牛7----------------20";
        }
        
        if ([selectValue isEqualToString:@"牛8"]) {
            selectValue =@"牛8----------------21";
        }
        
        if ([selectValue isEqualToString:@"牛9"]) {
            selectValue =@"牛9----------------22";
        }
        
        if ([selectValue isEqualToString:@"牛牛10"]) {
            selectValue =@"牛牛10----------------23";
        }
        
        if ([selectValue isEqualToString:@"牛牛J"]) {
            selectValue =@"牛牛J----------------24";
        }
        
        if ([selectValue isEqualToString:@"牛牛Q"]) {
            selectValue =@"牛牛Q----------------25";
        }
        
        if ([selectValue isEqualToString:@"牛牛K"]) {
            selectValue =@"牛牛K----------------26";
        }
        
        if ([selectValue isEqualToString:@"无牛-1"]) {
            selectValue =@"无牛-1----------------1";
        }
        
        if ([selectValue isEqualToString:@"无牛-2"]) {
            selectValue =@"无牛-2----------------2";
        }
        
        if ([selectValue isEqualToString:@"无牛-3"]) {
            selectValue =@"无牛-3----------------3";
        }
        
        if ([selectValue isEqualToString:@"无牛-4"]) {
            selectValue =@"无牛-4----------------4";
        }
        
        if ([selectValue isEqualToString:@"无牛-5"]) {
            selectValue =@"无牛-5----------------5";
        }
        
        if ([selectValue isEqualToString:@"无牛-6"]) {
            selectValue =@"无牛-6----------------6";
        }
        
        if ([selectValue isEqualToString:@"无牛-7"]) {
            selectValue =@"无牛-7----------------7";
        }
        
        if ([selectValue isEqualToString:@"无牛-8"]) {
            selectValue =@"无牛-8----------------8";
        }
        
        if ([selectValue isEqualToString:@"无牛-9"]) {
            selectValue =@"无牛-9----------------9";
        }
        
        if ([selectValue isEqualToString:@"无牛-10"]) {
            selectValue =@"无牛-10----------------10";
        }
        
        if ([selectValue isEqualToString:@"无牛-J"]) {
            selectValue =@"无牛-J----------------11";
        }
        
        if ([selectValue isEqualToString:@"无牛-Q"]) {
            selectValue =@"无牛-Q----------------12";
        }
        
        if ([selectValue isEqualToString:@"无牛-K"]) {
            selectValue =@"无牛-K----------------13";
        }
        
        
        HJGTableViewCell *cell = (HJGTableViewCell *)[[but superview] superview];
        
        NSIndexPath *indexPa = [self.rootTableView indexPathForCell:cell];
        
        NSMutableDictionary *model = [self.modelArr objectAtIndex:indexPa.row];
        if ([model isKindOfClass:[NSString class]]) {
            [self.modelArr replaceObjectAtIndex:indexPa.row withObject:[NSMutableDictionary dictionary]];
            model = [self.modelArr objectAtIndex:indexPa.row];
        }else{
            
            model = [self.modelArr objectAtIndex:indexPa.row];
        }
        if (but.tag == 1) {
            model[@"Number_1"] = selectValue;
            if ([model[@"Number_zhuang"] length] > 0) {
                [self compareBut:but xianText:selectValue zhuangText:model[@"Number_zhuang"]];
            }
        }else if (but.tag == 2){
            model[@"Number_2"] = selectValue;
            if ([model[@"Number_zhuang"] length] > 0) {
                [self compareBut:but xianText:selectValue zhuangText:model[@"Number_zhuang"]];
            }
        }else if (but.tag == 3){
            model[@"Number_3"] = selectValue;
            if ([model[@"Number_zhuang"] length] > 0) {
                [self compareBut:but xianText:selectValue zhuangText:model[@"Number_zhuang"]];
            }
        }else if (but.tag == 4){
            model[@"Number_4"] = selectValue;
            if ([model[@"Number_zhuang"] length] > 0) {
                [self compareBut:but xianText:selectValue zhuangText:model[@"Number_zhuang"]];
            }
        }else if (but.tag == 5){
            model[@"Number_5"] = selectValue;
            if ([model[@"Number_zhuang"] length] > 0) {
                [self compareBut:but xianText:selectValue zhuangText:model[@"Number_zhuang"]];
            }
        }else if (but.tag == 6){
            model[@"Number_6"] = selectValue;
        }else if (but.tag == 7){
            model[@"Number_zhuang"] = selectValue;
            NSLog(@"000000_%@",model[@"Number_zhuang"]);
            [self compareBut:cell.firstBut xianText:model[@"Number_1"] zhuangText:model[@"Number_zhuang"]];
            [self compareBut:cell.secondBut xianText:model[@"Number_2"] zhuangText:model[@"Number_zhuang"]];
            [self compareBut:cell.thirdBut xianText:model[@"Number_3"] zhuangText:model[@"Number_zhuang"]];
            [self compareBut:cell.forthBut xianText:model[@"Number_4"] zhuangText:model[@"Number_zhuang"]];
            [self compareBut:cell.fifthBut xianText:model[@"Number_5"] zhuangText:model[@"Number_zhuang"]];
            
        }
        
        [self.rootTableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fff" object:self.modelArr];
    }];
    
}

- (void)compareBut:(UIButton *)but xianText:(NSString *)xianText zhuangText:(NSString *)zhuangText
{
    
    if ([xianText containsString:@"----------------"]&&[zhuangText containsString:@"----------------"]) {
        NSString *xian = [self sub_str:xianText];
        NSString *zhuang = [self sub_str:zhuangText];
        if ([xian intValue] > [zhuang intValue]) {
            but.layer.borderColor = [UIColor redColor].CGColor;
        }else{
            but.layer.borderColor = RGB(198, 198, 198).CGColor;
        }
    }
    
}


- (NSString *)sub_str:(NSString *)str{
    
    NSArray *arr = [str componentsSeparatedByString:@"----------------"];
    
    return [arr objectAtIndex:1];
}


@end

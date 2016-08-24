//
//  ViewController.m
//  TableView 折叠
//
//  Created by hua on 16/8/24.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "ViewController.h"
#import "GHSubmitGuideCell.h"
#define MainScreenHeight        [UIScreen mainScreen ].bounds.size.height
#define MainScreenWidth         [UIScreen mainScreen ].bounds.size.width

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate  >
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *foldDict;
@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSMutableDictionary *tempDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableView];
    [self footerView];
}

-(void)footerView
{
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(-1, MainScreenHeight- 49, MainScreenWidth+2, 50)];
    
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: bottom];
    
     UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(15, 5, CGRectGetWidth(bottom.frame)- 15*2, 40);
    [submitButton addTarget:self action:@selector(submitButton:) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"确认支付" forState:UIControlStateNormal];

    submitButton.tag =1;
    submitButton.layer.cornerRadius = 3;
    submitButton.layer.masksToBounds =YES;
    submitButton.layer.borderWidth =1;
    submitButton.layer.borderColor =[UIColor grayColor].CGColor;
    [bottom addSubview:submitButton];
    [submitButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)submitButton:(UIButton *)sender {
    NSLog(@"商品信息:%@",self.dataDict);
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, MainScreenWidth, MainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor =[UIColor redColor];
    [self.view addSubview:_tableView];
    self.foldDict = [NSMutableDictionary dictionary];
    self.dataDict = [ NSMutableDictionary dictionary];
    self.tempDict = [NSMutableDictionary dictionary];
   [self.foldDict setValue:@"0" forKey:[NSString stringWithFormat:@"0"]];
}
#pragma mark - tableviewDelegate(分组)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[self.foldDict valueForKey:[NSString stringWithFormat:@"%ld",section]] isEqualToString:@"0"]) {
        return 5;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
        //
 
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame = CGRectMake(0, 0, MainScreenWidth, 40);
    [clickButton addTarget:self action:@selector(breakButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    clickButton.backgroundColor = [UIColor blueColor];
    [titleView addSubview:clickButton];
    clickButton.tag = 100 + section;
        UIView *view = [[UIView alloc] initWithFrame:[titleView frame]];
    titleView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [view addSubview:titleView];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 44; //MainScreenHeight/2.2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GHSubmitGuideCell *cell = [GHSubmitGuideCell cellWithTableView:tableView];
//    cell.model = _G_dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"section:%ld  row: %ld",indexPath.section,indexPath.row];
 
   NSString * a = self.dataDict[[NSString stringWithFormat:@"%ld",indexPath.section]][[NSString stringWithFormat:@"%ld",indexPath.row]][@"num"];
     if ([[NSString stringWithFormat:@"%ld",indexPath.row]isEqualToString:a]) {
        cell.submitButton.selected = YES;
        [cell.submitButton setBackgroundImage:[UIImage imageNamed:@"yueke_select"] forState:UIControlStateNormal];
    }else{
         cell.submitButton.selected = NO;
         [cell.submitButton setBackgroundImage:[UIImage imageNamed:@"yueke_noselect"] forState:UIControlStateNormal];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataDict[[NSString stringWithFormat:@"%ld",indexPath.section]] == NULL) {
        
    }else{
         self.tempDict = self.dataDict[[NSString stringWithFormat:@"%ld",indexPath.section]];
    }
    GHSubmitGuideCell *cell = [_tableView  cellForRowAtIndexPath:indexPath];
    cell.submitButton.selected = !cell.submitButton.selected;
    if (cell.submitButton.selected ==YES) {
        NSLog(@"选中");
      [cell.submitButton setBackgroundImage:[UIImage imageNamed:@"yueke_select"] forState:UIControlStateNormal];
        [self.tempDict setObject:@{ @"num":[NSString stringWithFormat:@"%ld",indexPath.row],@"title":cell.textLabel.text}  forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
         [self.dataDict setObject:self.tempDict forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
       
    }else{
        NSLog(@"不选中");
         [cell.submitButton setBackgroundImage:[UIImage imageNamed:@"yueke_noselect"] forState:UIControlStateNormal];
        
        [self.tempDict removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
        
        [self.dataDict setObject:self.tempDict forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];    }
 }
-(void)breakButtonAction:(UIButton * )sender{
 self.tempDict = [NSMutableDictionary dictionary];
    NSLog(@"%ld",sender.tag);
    if ([[self.foldDict valueForKey:[NSString stringWithFormat:@"%ld",sender.tag - 100]] isEqualToString:@"0"]) {
        [self.foldDict setValue:@"1" forKey:[NSString stringWithFormat:@"%ld",sender.tag - 100]];
    }else{
        [self.foldDict setValue:@"0" forKey:[NSString stringWithFormat:@"%ld",sender.tag - 100]];
    }
 [self.tableView reloadData];
}
#pragma mark 用户更新
- (void)checkAndShowWithAppID{
    NSString *urlString = [NSString stringWithFormat:@"http://219.159.44.166:39023/Liems/webservice/appendixsList"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSOperationQueue *queue = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if (data) {
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            
                    }
        
        
    }];
    
}


@end

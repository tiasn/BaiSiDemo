//
//  BSAllViewController.m
//  BaiSiDemo
//
//  Created by LTX on 2017/7/12.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSAllViewController.h"
#import "BSTopicViewCell.h"
#import "BSBaseRequest.h"

#import "BSTopicModel.h"
#import "MJExtension.h"

/* cell的重用标识 */
static NSString * const BSTopicCellId = @"BSTopicCellId";

@interface BSAllViewController ()

@property (nonatomic , strong) BSBaseRequest *baseRequest;

@property (nonatomic , strong) NSMutableArray *topicModelsArray;


@end

@implementation BSAllViewController

//网络请求
- (BSBaseRequest *)baseRequest
{
    if (!_baseRequest) {
        _baseRequest = [BSBaseRequest requestWithURL:BSCommonURL];
    }
    return _baseRequest;
}

//model数组
- (NSMutableArray *)topicModelsArray {
    
    if (!_topicModelsArray) {
        _topicModelsArray = [NSMutableArray array];
    }
    return _topicModelsArray;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self setupUI];
    
    [self getAllData];
    
}



// 初始化设置
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabbarH + kNavH, 0);
    
    
    //注册cell
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([BSTopicViewCell class]) bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:BSTopicCellId];
    
}




- (void)getAllData{
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
//    parameters[@"type"] = @"1"; //全部
    parameters[@"type"] = @"29"; // 段子

    
    [self.baseRequest startWithMethod:BSHTTPTypePOST params:parameters completion:^(NSDictionary *responseObject, NSString *message, BOOL success) {
        
        if (success) {
            
            
            NSArray *allTopics = [responseObject objectForKey:@"list"];
            NSLog(@"%@", allTopics);
            
            self.topicModelsArray = [BSTopicModel mj_objectArrayWithKeyValuesArray:allTopics];
            
            NSLog(@"model数量:%zd", self.topicModelsArray.count);
            
        }else{
            
            NSLog(@"%@", message);
            
        }
        
        
    }];
    
    
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BSTopicCellId];
    
    return cell;
}


@end

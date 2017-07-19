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
#import "MJRefresh.h"

/* cell的重用标识 */
static NSString * const BSTopicCellId = @"BSTopicCellId";

@interface BSAllViewController ()

@property (nonatomic , strong) BSBaseRequest *baseRequest;

@property (nonatomic , strong) NSMutableArray *topicModelsArray;

@property (nonatomic, copy)NSString *maxtime;

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

    self.tableView.contentInset = UIEdgeInsetsMake(kNavH, 0, kTabbarH + kNavH, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.topicModelsArray removeAllObjects];
        self.maxtime = @"";
        [self getAllData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self getAllData];
    }];
    
    
    
    //注册cell
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([BSTopicViewCell class]) bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:BSTopicCellId];
    
}




- (void)getAllData{
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1"; //全部
//    parameters[@"type"] = @"29"; // 段子
//    parameters[@"type"] = @"10"; // 图片

//        parameters[@"type"] = @"31"; // 视频

    parameters[@"maxtime"] = self.maxtime;
    parameters[@"page"] = @(self.topicModelsArray.count / 20);
    

    
    [self.baseRequest startWithMethod:BSHTTPTypePOST params:parameters completion:^(NSDictionary *responseObject, NSString *message, BOOL success) {
        
        if (success) {
            
            NSDictionary *info = [responseObject objectForKey:@"info"];
            self.maxtime = [info objectForKey:@"maxtime"];
            
            NSArray *allTopics = [responseObject objectForKey:@"list"];
            NSLog(@"%@", allTopics);
            
            NSArray *modelArray = [BSTopicModel mj_objectArrayWithKeyValuesArray:allTopics];
            
            [self.topicModelsArray addObjectsFromArray:modelArray];
            
            NSLog(@"model数量:%zd", self.topicModelsArray.count);
            
            
            
            if (modelArray.count < 20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
            
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            
            }
            
            [self.tableView reloadData];
            
        }else{
            [self.tableView.mj_header endRefreshing];

            NSLog(@"%@", message);
            
        }
        
        
    }];
    
    
    
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicModelsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopicModel *model = [self.topicModelsArray objectAtIndex:indexPath.row];

    return model.cellHeight;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BSTopicCellId];
    
    
    BSTopicModel *model = [self.topicModelsArray objectAtIndex:indexPath.row];
    cell.model = model;
    
    BSLog(@"%zd----%p", indexPath.row, cell);
    
    return cell;
}

@end

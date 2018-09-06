//
//  ViewController.m
//  fmTemplateLayoutCell
//
//  Created by 柯浩然 on 9/3/18.
//  Copyright © 2018 柯浩然. All rights reserved.
//

#import "ViewController.h"
#import "fmFeedEntity.h"
#import "fmFeedTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) NSMutableArray *feedEntityArray;
@property(nonatomic, strong) NSArray *prototypeEntitiesFromJSON;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableview];
    [self buildTestDataThen:^{
        self.feedEntityArray = [NSMutableArray array];
        [self.feedEntityArray addObject:[self.prototypeEntitiesFromJSON mutableCopy]];
        [self.tableview reloadData];
    }];
}

- (void)setupTableview {

    self.tableview = [[UITableView alloc] init];
    [self.view addSubview:self.tableview];
    self.tableview.frame = self.view.bounds;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self registerNibWithClass:[fmFeedTableViewCell class]];
}
- (void)registerNibWithClass:(Class)class {
    NSString *className = NSStringFromClass([class class]);
    [self.tableview registerNib:[UINib nibWithNibName:className bundle:[NSBundle mainBundle ]] forCellReuseIdentifier:className];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedEntityArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feedEntityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    fmFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([fmFeedTableViewCell class])];
    cell.entity = self.feedEntityArray[indexPath.section][indexPath.row];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([fmFeedTableViewCell class]) cacheByIndexPath:indexPath  configuration:^(fmFeedTableViewCell *cell) {
        cell.entity = self.feedEntityArray[indexPath.section][indexPath.row];
        
    }];
}

- (void)buildTestDataThen:(void (^)(void))then {
    // Simulate an async request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `fmFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[fmFeedEntity alloc] initWithDictionary:obj]];
        }];
        self.prototypeEntitiesFromJSON = entities;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

@end

//
//  ViewController.m
//  Receipts++
//
//  Created by Marc Maguire on 2017-05-25.
//  Copyright © 2017 Marc Maguire. All rights reserved.
//

#import "ViewController.h"
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"
#import "AddReceiptViewController.h"
#import "DataManager.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Tag *> *tags;
@property (nonatomic) DataManager *manager;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [DataManager sharedManager];
//     self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tags = [[NSMutableArray alloc]init];
    
//    self.sections = @[@"Personal", @"Family", @"Business"];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //fetch the tags instead of the receipts
    [self.manager fetchTags];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - TableView Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.manager.tags count];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.manager.tags[section].tagName;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.manager.tags[section].receipts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    cell.textLabel.text = self.manager.tags[indexPath.section].receipts[indexPath.row].receiptDescription;
//    .receipts[indexPath.row].receiptDescription;

    
    return cell;
    
}

#pragma mark - Navigation



@end

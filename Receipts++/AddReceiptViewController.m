//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Marc Maguire on 2017-05-25.
//  Copyright © 2017 Marc Maguire. All rights reserved.
//

#import "AddReceiptViewController.h"

@interface AddReceiptViewController () <UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray <NSString *> *categories;



@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = @[@"Personal", @"Family", @"Business"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.categories[indexPath.row];
    
    return cell;
}

#pragma mark - Table View Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
   
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

    }
        
        
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
   
}


@end

//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Marc Maguire on 2017-05-25.
//  Copyright © 2017 Marc Maguire. All rights reserved.
//

#import "AddReceiptViewController.h"
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"
#import "DataManager.h"

@interface AddReceiptViewController () <UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableDictionary <NSString*, Tag *> *tags;
@property (nonatomic) DataManager *manager;



@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [DataManager sharedManager];
    self.tags = [[NSMutableDictionary alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveReceipt:(UIButton *)sender {
    

    Receipt *receipt = [[Receipt alloc]initWithEntity:[Receipt entity] insertIntoManagedObjectContext:self.manager.persistentContainer.viewContext];
    receipt.amount = (uint16_t)[self.amountTextField.text integerValue];
    receipt.date = self.datePicker.date;
    receipt.receiptDescription = self.descriptionTextField.text;
    NSArray <Tag *> *tags = self.tags.allValues;
    receipt.tags = [NSSet setWithArray:tags];
    

    
    [self.manager saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.manager.tags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.manager.tags[indexPath.row].tagName;
    
    return cell;
}

#pragma mark - Table View Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Tag *selectedTag = self.manager.tags[indexPath.row];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
   
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        
        if ([self.tags objectForKey:selectedTag.tagName] != nil) {
            return;
        } else {
            [self.tags setObject:selectedTag forKey:selectedTag.tagName];
        }
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//        [self.selectedCategories addObject:self.categories[indexPath.row]];
    } else {
        
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [self.tags removeObjectForKey:selectedTag.tagName];

    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Categories";
}

@end

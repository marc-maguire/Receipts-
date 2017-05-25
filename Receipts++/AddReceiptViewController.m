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

@interface AddReceiptViewController () <UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray <NSString *> *categories;
@property (nonatomic) NSMutableArray *selectedCategories;



@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = @[@"Personal", @"Family", @"Business"];
    self.selectedCategories = [[NSMutableArray alloc] init];
    
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

-(IBAction)saveReceipt:(UIButton *)sender {
    
    NSManagedObjectContext *context = self.delegate.persistentContainer.viewContext;
    Receipt *receipt = [[Receipt alloc]initWithEntity:[Receipt entity] insertIntoManagedObjectContext:context];
    receipt.amount = (uint16_t)[self.amountTextField.text integerValue];
    receipt.date = self.datePicker.date;
    receipt.receiptDescription = self.descriptionTextField.text;
    NSSet <Tag *> *categories;
    for (NSString *string in self.categories) {
        Tag *tag = [[Tag alloc]initWithEntity:[Tag entity] insertIntoManagedObjectContext:context];
        tag.tagName = string;
        [categories setByAddingObject:tag];
    }
    receipt.tag = categories;
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    dateFormatter.dateFormat = @"MMMM DDDD, YYY";
//    NSDate *date1 = [dateFormatter stringFromDate:self.datePicker.date];
    //receipt.date = date;
    
    NSError *error;
    [context save:&error];
    if (error) {
        NSLog(@"save failed in AddReciptViewController");
        abort();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


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
        [self.selectedCategories addObject:self.categories[indexPath.row]];
    } else {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        NSString *object = self.categories[indexPath.row];
        [self.selectedCategories removeObject:object];

    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Categories";
}

@end

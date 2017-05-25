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


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Receipt *> *receipts;
@property (nonatomic) NSArray *sections;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.receipts = [[NSMutableArray alloc]init];
    self.sections = @[@"Personal", @"Family", @"Business"];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSManagedObjectContext *managedContext = self.delegate.persistentContainer.viewContext;
    NSError *error;
    NSMutableArray *update = (NSMutableArray <Receipt *>*)[managedContext executeFetchRequest:[Receipt fetchRequest] error:&error];
    if (error) {
        abort();
    } else {
    self.receipts = [update mutableCopy];
        NSLog(@"We in business, baby");
    }
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray <Receipt *> * )loadReceiptsForSections:(int)indexPath {
    
    NSManagedObjectContext *context = self.delegate.persistentContainer.viewContext;
    NSFetchRequest *request = [Receipt fetchRequest];
    NSString *sectionTitle = [self.sections objectAtIndex:indexPath];
    //sort and return receipts based on section
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tagName = %@",sectionTitle];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error performing search with predicate");
        abort();
    }
    return results;
}

#pragma mark - TableView Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sections count];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sections[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return [self.receipts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Receipt *receipt = self.receipts[indexPath.row];
    cell.textLabel.text = receipt.receiptDescription;
    
    return cell;
    
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"add"]) {
        AddReceiptViewController *arvc = [segue destinationViewController];
        arvc.delegate = self.delegate;
    }
    
    
}

@end

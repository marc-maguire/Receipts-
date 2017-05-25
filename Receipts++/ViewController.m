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


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray <Receipt *> *receipts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.receipts = [[NSMutableArray alloc]init];
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"test";
    
    return cell;
    
}

@end

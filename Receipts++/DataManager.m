//
//  DataManager.m
//  Receipts++
//
//  Created by Alex Mitchell on 2017-05-25.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager


-(instancetype) init {
    if (self = [super init]) {
    }
    return self;
}

+(id)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        [sharedMyManager fetchTags];
        if (sharedMyManager.tags.count == 0) {
            sharedMyManager.tags = [sharedMyManager setDefaultTags];
        }
    });
    return sharedMyManager;
}



@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Receipts__"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(NSArray<Tag *> *) setDefaultTags {
    
    Tag *personal = [[Tag alloc] initWithContext:self.persistentContainer.viewContext];
    personal.tagName = @"Personal";
    
    Tag *business = [[Tag alloc] initWithContext:self.persistentContainer.viewContext];
    business.tagName = @"Business";
    
    Tag *family = [[Tag alloc] initWithContext:self.persistentContainer.viewContext];
    family.tagName = @"Family";
    
    NSArray<Tag *> *defaultTags = [NSArray arrayWithObjects:personal, business, family, nil];
    
    return defaultTags;
}


-(void)fetchTags {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    self.tags = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
    
}
//-(NSArray<ToDo *> *)fetchObjects {
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDo"];
//    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"isCompleted" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
//    NSArray<ToDo *> *todoArray = [self.context executeFetchRequest:request error:nil];
//    
//    return todoArray;
//}


@end

//
//  DataManager.h
//  Receipts++
//
//  Created by Alex Mitchell on 2017-05-25.
//  Copyright © 2017 Alex Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
#import "Tag+CoreDataClass.h"
#import "Receipt+CoreDataClass.h"

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) NSArray<Tag *> *tags;

+(id)sharedManager;

-(void)saveContext;

-(void) fetchTags;




@end

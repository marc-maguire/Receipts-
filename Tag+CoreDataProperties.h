//
//  Tag+CoreDataProperties.h
//  Receipts++
//
//  Created by Marc Maguire on 2017-05-25.
//  Copyright © 2017 Marc Maguire. All rights reserved.
//

#import "Tag+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *tagName;
@property (nullable, nonatomic, retain) NSSet<Receipt *> *receipt;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addReceiptObject:(Receipt *)value;
- (void)removeReceiptObject:(Receipt *)value;
- (void)addReceipt:(NSSet<Receipt *> *)values;
- (void)removeReceipt:(NSSet<Receipt *> *)values;

@end

NS_ASSUME_NONNULL_END

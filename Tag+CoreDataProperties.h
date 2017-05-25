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
@property (nullable, nonatomic, retain) NSOrderedSet<Receipt *> *receipts;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)insertObject:(Receipt *)value inReceiptsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromReceiptsAtIndex:(NSUInteger)idx;
- (void)insertReceipts:(NSArray<Receipt *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeReceiptsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInReceiptsAtIndex:(NSUInteger)idx withObject:(Receipt *)value;
- (void)replaceReceiptsAtIndexes:(NSIndexSet *)indexes withReceipts:(NSArray<Receipt *> *)values;
- (void)addReceiptsObject:(Receipt *)value;
- (void)removeReceiptsObject:(Receipt *)value;
- (void)addReceipts:(NSOrderedSet<Receipt *> *)values;
- (void)removeReceipts:(NSOrderedSet<Receipt *> *)values;

@end

NS_ASSUME_NONNULL_END

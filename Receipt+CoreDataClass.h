//
//  Receipt+CoreDataClass.h
//  Receipts++
//
//  Created by Marc Maguire on 2017-05-25.
//  Copyright © 2017 Marc Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;

NS_ASSUME_NONNULL_BEGIN

@interface Receipt : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Receipt+CoreDataProperties.h"

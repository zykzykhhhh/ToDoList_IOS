//
//  EventList.h
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface EventList : NSManagedObject

@property (nonatomic, retain) NSSet *members;
@end

@interface EventList (CoreDataGeneratedAccessors)

- (void)addMembersObject:(Event *)value;
- (void)removeMembersObject:(Event *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

@end

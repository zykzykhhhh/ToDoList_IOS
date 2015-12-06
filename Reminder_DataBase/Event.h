//
//  Event.h
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EventList;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) EventList *list;

@end

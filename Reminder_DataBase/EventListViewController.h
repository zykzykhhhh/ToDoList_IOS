//
//  EventListViewController.h
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventViewController.h"
#import "EditEventViewController.h"
#import "EventList.h"
#import "Event.h"
#import "EventCell.h"

@interface EventListViewController : UITableViewController<addReminderProtocol>

@property (strong, nonatomic) EditEventViewController* editcontroller;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) EventList* currentListObject;
@property (strong, nonatomic) NSArray* ReminderArray;

@end

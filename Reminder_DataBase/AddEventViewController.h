//
//  AddEventViewController.h
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Event.h"

@protocol addReminderProtocol <NSObject>

-(void)addReminder:(Event*) reminder;

@end

@interface AddEventViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Title;
@property (weak, nonatomic) IBOutlet UITextField *Description;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)SaveEvent:(id)sender;

@property (weak, nonatomic) id<addReminderProtocol> delegate;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

-(void) alert:(NSString *)text;

@end

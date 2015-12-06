//
//  EditEventViewController.h
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
@interface EditEventViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Title;
@property (weak, nonatomic) IBOutlet UITextField *Description;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UISwitch *completedSwich;
- (IBAction)SaveEvent:(id)sender;
- (IBAction)switch:(id)sender;

@property (strong, nonatomic) Event* currentReminder;
@property (strong,nonatomic) NSManagedObject* selectedReminder;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
-(void) alert:(NSString *)text;

@end

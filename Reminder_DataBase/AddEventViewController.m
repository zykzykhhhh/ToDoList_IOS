//
//  AddEventViewController.m
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SaveEvent:(id)sender {

    NSString* title = self.Title.text;
    NSString* description = self.Description.text;
    
    if([self.Title.text isEqualToString:@""])
    {
        [self.Title becomeFirstResponder];
        [self alert:@"Please input title!"];
    }else if([self.Description.text isEqualToString:@""])
    {
        [self.Description becomeFirstResponder];
        [self alert:@"Please input description!"];
    }else
    {
        NSDate* date = self.datePicker.date;
        
        
        Event *e = [NSEntityDescription insertNewObjectForEntityForName:@"Event"
                                                           inManagedObjectContext:self.managedObjectContext];
        [e setTitle:title];
        [e setDescriptions:description];
        [e setDueDate:date];
        [e setCompleted:[NSNumber numberWithBool:NO]];
        [self.delegate addReminder:e];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    

}


-(void) alert:(NSString *)text{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:text delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}
@end

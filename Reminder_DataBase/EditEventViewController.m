//
//  EditEventViewController.m
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import "EditEventViewController.h"

@interface EditEventViewController ()

@end

@implementation EditEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.selectedReminder)
    {
        self.Title.text = [self.selectedReminder valueForKey:@"title"];
        self.Description.text = [self.selectedReminder valueForKey:@"descriptions"];
        self.DatePicker.date = [self.selectedReminder valueForKey:@"dueDate"];
    }
    
    if([[self.selectedReminder valueForKey:@"completed"] boolValue])
    {
        [self.completedSwich setOn:YES animated:YES];
    }else{
        [self.completedSwich setOn:NO animated:YES];
    }
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
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
        if (self.selectedReminder) {
            [self.selectedReminder setValue:self.Title.text forKey:@"title"];
            [self.selectedReminder setValue:self.Description.text forKey:@"descriptions"];
            [self.selectedReminder setValue:self.DatePicker.date forKey:@"dueDate"];
            [self.selectedReminder setValue:[NSNumber numberWithBool:self.completedSwich.on ]forKey:@"completed"];
        }
        NSError* saveError;
        // Save the object to persistent store
        if (![self.managedObjectContext save:&saveError]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", saveError, saveError.localizedDescription);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) alert:(NSString *)text{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:text delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
    
}

- (IBAction)switch:(id)sender {
}
@end

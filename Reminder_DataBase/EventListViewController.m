//
//  EventListViewController.m
//  Reminder_DataBase
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import "EventListViewController.h"

@interface EventListViewController ()

@end

@implementation EventListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EventList"];
    NSError* error;
    NSArray* result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(result == nil) {
        NSLog(@"Could not fetch table:\n%@", error.userInfo); }
    else if([result count] == 0)
    {
        self.currentListObject = [NSEntityDescription insertNewObjectForEntityForName:@"EventList"
                                                               inManagedObjectContext:self.managedObjectContext]; }
    else
    {
        self.currentListObject = [result firstObject];
        self.ReminderArray = [self.currentListObject.members allObjects];
        self.ReminderArray = [self.ReminderArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSDate *first = [(Event*)a dueDate];
            NSDate *second = [(Event*)b dueDate];
            return [first compare:second];
        }];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.ReminderArray count];
}


-(void) viewDidAppear:(BOOL)animated{
    
    self.ReminderArray = [self.ReminderArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Event*)a dueDate];
        NSDate *second = [(Event*)b dueDate];
        return [first compare:second];
    }];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    if(indexPath.section == 0)
    {
        EventCell *cell = (EventCell*)[tableView
                                             dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
        Event* r = [self.ReminderArray objectAtIndex:indexPath.row];
        cell.Title.text = r.title;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat =@"yyyy-MM-dd";
        cell.dueDate.text = [dateFormatter stringFromDate:r.dueDate];
        if (r.completed) {
            cell.completed.text=@"completed";
        }else{cell.completed.text=@"uncompleted";}
        return cell;
    }
    return nil;
}


-(void)addReminder:(Event *)reminder
{
    [self.currentListObject addMembersObject:reminder];
    self.ReminderArray = [self.currentListObject.members allObjects];
    self.ReminderArray = [self.ReminderArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(Event*)a dueDate];
        NSDate *second = [(Event*)b dueDate];
        return [first compare:second];
    }];
    NSError* error;
    if(![self.managedObjectContext save:&error])
    {
        NSLog(@"Could not save reminder insertion:\n%@", error.userInfo);
    }
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Event* r = [self.ReminderArray objectAtIndex:indexPath.row];
        [self.currentListObject removeMembersObject:r];
        self.ReminderArray = [self.currentListObject.members allObjects];
        //Delete the row from the table
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSError* error;
        if(![self.managedObjectContext save:&error])
        {
            NSLog(@"Could not save deletion:\n%@", error.userInfo);
        }
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"addReminder"])
    {
        AddEventViewController* controller = segue.destinationViewController;
        controller.managedObjectContext = self.managedObjectContext;
        controller.delegate = self;
        
        
    }else if([segue.identifier isEqualToString:@"editReminder"]){
        self.editcontroller = segue.destinationViewController;
        NSManagedObject* selectedReminder = (NSManagedObject *)[self.ReminderArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
        self.editcontroller.selectedReminder = selectedReminder;
    }
    
}


@end

//
//  EventViewController.m
//  FEFU
//
//  Created by Илья on 10.11.15.
//  Copyright © 2015 FARPOST. All rights reserved.
//

#import "EventViewController.h"
#import "CellView.h"
#import "EventDetailViewController.h"
#import "AFNetworking.h"

@implementation EventViewController{
    
}

static NSArray *data;
/*
- (void) viewDidLoad{
    [super viewDidLoad];
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://31.131.24.188:8080/newsline/0&u" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        data = responseObject;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    CellView *cell = (CellView*)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.header.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.header.text  = [[data objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.content.text = [[data objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[data objectAtIndex:indexPath.row] objectForKey:@"img_src"]  ]];
        if ( imageData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.picture.image = [UIImage imageWithData: imageData];
        });
    });
    return cell;
}

/*

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showEventDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"showEventDetails"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        EventDetailViewController *vc = (EventDetailViewController*)[segue destinationViewController];
        vc.textValue = [[data objectAtIndex:indexPath.row] objectForKey:@"description"];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[data objectAtIndex:indexPath.row] objectForKey:@"img_src"]]];
        vc.imageValue = [UIImage imageWithData:imageData];
        vc.title = [[data objectAtIndex:indexPath.row] objectForKey:@"title"];
    }
}
*/
@end
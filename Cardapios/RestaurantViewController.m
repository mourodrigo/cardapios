//
//  RestaurantViewController.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 15/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "RestaurantViewController.h"
#import "RightArrowCell.h"
#import "AppDelegate.h"
#import "RestaurantDetailViewController.h"
@interface RestaurantViewController (){
    AppDelegate *delegate;
    NSMutableArray *cities;
}

@end

@implementation RestaurantViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    cities = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where ZCITY = '%@'", delegate.CitySelected]]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightArrowCell" forIndexPath:indexPath];
    NSDictionary *dic = [cities objectAtIndex:indexPath.row];
    [cell.outletLblTitle setText:[dic valueForKey:@"ZNAME"]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", [cities objectAtIndex:indexPath.row]);
    delegate.CitySelected = [[cities objectAtIndex:indexPath.row] valueForKey:@"ZNAME"];
    
    RestaurantDetailViewController *rst = (RestaurantDetailViewController*)[delegate getViewControllerWithIdentifier:@"rstDetail"];
    [self presentViewController:rst animated:YES completion:nil];
}


- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end

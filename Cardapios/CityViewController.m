//
//  CityViewController.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 14/01/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "CityViewController.h"
#import "RightArrowCell.h"
#import "AppDelegate.h"
#import "RestaurantViewController.h"
@interface CityViewController (){
    AppDelegate *delegate;
    NSMutableArray *cities;
}

@end

@implementation CityViewController
@synthesize uiTvCity;
@synthesize navBar, navItem;
@synthesize outletLblTitle;
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
    cities = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:@"Select * from ZCITY"]];
	// Do any additional setup after loading the view.
    outletLblTitle.text = [delegate getStr:@"CIDADE"];
}

-(void)viewDidAppear:(BOOL)animated{
    
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
    delegate.CitySelected = [[cities objectAtIndex:indexPath.row] valueForKey:@"ZIDCITY"];
    
    RestaurantViewController *rst = (RestaurantViewController*)[delegate getViewControllerWithIdentifier:@"rst"];
    [self.navigationController pushViewController:rst animated:YES];
    [uiTvCity deselectRowAtIndexPath:[uiTvCity indexPathForSelectedRow] animated:NO];

}

- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

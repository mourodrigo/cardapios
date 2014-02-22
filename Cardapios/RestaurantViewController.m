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
    NSMutableArray *rests;
}

@end

@implementation RestaurantViewController
@synthesize uiTvRest;
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

    rests = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where ZCITY = '%@'", delegate.CitySelected]]];
    
    outletLblTitle.text = [delegate getStr:@"RESTAURANTE"];
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.tabBarController.selectedIndex==1) {
        NSMutableArray *favs = [delegate loadAllFav];
        NSLog(@"favs %@", favs);
        NSString *where = @"";
        NSString *OR = @"";
        for (int x=0; x<favs.count; x++) {
            if (x>0) {
                OR = @"OR";
            }
            NSLog(@"davs %@", [favs objectAtIndex:x]);
            where = [NSString stringWithFormat:@"%@ %@ ZIDREST = %@", where, OR, [favs objectAtIndex:x]];
        }

        rests = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where %@", where]]];
        [uiTvRest reloadData];
        outletLblTitle.text = [delegate getStr:@"FAVORITOS"];
        
    }
    [uiTvRest deselectRowAtIndexPath:[uiTvRest indexPathForSelectedRow] animated:NO];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return rests.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightArrowCell" forIndexPath:indexPath];
    NSDictionary *dic = [rests objectAtIndex:indexPath.row];
    [cell.outletLblTitle setText:[dic valueForKey:@"ZNAME"]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", [rests objectAtIndex:indexPath.row]);
    delegate.idRestSelected = [[[rests objectAtIndex:indexPath.row] valueForKey:@"ZIDREST"] integerValue];
    
    RestaurantDetailViewController *rst = (RestaurantDetailViewController*)[delegate getViewControllerWithIdentifier:@"rstDetail"];
    [uiTvRest deselectRowAtIndexPath:[uiTvRest indexPathForSelectedRow] animated:NO];

    [self.navigationController pushViewController:rst animated:YES];
}


- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end

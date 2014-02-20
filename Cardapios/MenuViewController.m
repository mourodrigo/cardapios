//
//  MenuViewController.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 20/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "RightArrowCell.h"
@interface MenuViewController (){
    AppDelegate *delegate;
    NSMutableArray *menus;
}

@end

@implementation MenuViewController

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
    menus = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZMENU where ZIDRESTAURANT = %d", delegate.idRestSelected]]];
	// Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menus.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightArrowCell" forIndexPath:indexPath];
    NSDictionary *dic = [menus objectAtIndex:indexPath.row];
    [cell.outletLblTitle setText:[dic valueForKey:@"ZNAME"]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@", [menus objectAtIndex:indexPath.row]);
    delegate.idMenu = [[[menus objectAtIndex:indexPath.row] valueForKey:@"ZIDMENU"] integerValue];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBtnVoltar:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end

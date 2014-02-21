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
@synthesize uitvmenu;
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
    menus = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZMENU where ZIDRESTAURANT = %d ORDER BY ZFAVORITE DESC", delegate.idRestSelected]]];
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    if (self.tabBarController.selectedIndex==2) {
        NSMutableArray *favs = [delegate loadAllMenuFav];
        NSLog(@"favs %@", favs);
        NSString *where = @"";
        NSString *OR = @"";
        for (int x=0; x<favs.count; x++) {
            if (x>0) {
                OR = @"OR";
            }
            NSLog(@"davs %@", [favs objectAtIndex:x]);
            where = [NSString stringWithFormat:@"%@ %@ ZIDMENU = %@", where, OR, [favs objectAtIndex:x]];
        }
        
        menus = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZMENU where %@", where]]];
        [uitvmenu reloadData];
    }
    [uitvmenu deselectRowAtIndexPath:[uitvmenu indexPathForSelectedRow] animated:NO];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menus.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [menus objectAtIndex:indexPath.row];
    NSString *identifier;
    
    if ([[dic valueForKey:@"ZFAVORITE"] boolValue]) {
        identifier = @"RightArrowCellDestaque";
    }else{
        identifier = @"RightArrowCell";
        
    }
    RightArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell.outletLblTitle setText:[dic valueForKey:@"ZNAME"]];
    [cell.outletLblSubTitle setText:[NSString stringWithFormat:@"$ %@", [dic valueForKey:@"ZVALUE"]]];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [menus objectAtIndex:indexPath.row];
    
    if ([[dic valueForKey:@"ZFAVORITE"] boolValue]) {
        return 105;
    }else{
        return 44;
    }
}
@end

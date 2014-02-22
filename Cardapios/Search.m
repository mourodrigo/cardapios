//
//  Search.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 17/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "Search.h"
#import "AppDelegate.h"
#import "RightArrowCell.h"
#import "RestaurantDetailViewController.h"
#import "MenuDetailViewController.h"
@interface Search (){
    AppDelegate *delegate;
    NSMutableArray *result;
}

@end

@implementation Search
@synthesize navBar, navItem;
@synthesize outletLblTitle;
    
@synthesize outletBtnMenu, outletBtnRest, outletNavItem, outletSearchBar, uiTVSearch;

-(void)viewDidLoad{
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [outletBtnRest setBackgroundImage:[delegate getImageWithColor:[UIColor colorWithRed:(82.0f/255.0f) green:(82.0f/255.0f) blue:(82.0f/255.0f) alpha:.29]]
                             forState:UIControlStateNormal];
    [outletBtnMenu setBackgroundImage:[delegate getImageWithColor:[UIColor colorWithRed:(82.0f/255.0f) green:(82.0f/255.0f) blue:(82.0f/255.0f) alpha:.29]]
                             forState:UIControlStateNormal];
    
    [outletBtnRest setBackgroundImage:[delegate getImageWithColor:[UIColor colorWithRed:(201.0f/255.0f) green:(54.0f/255.0f) blue:(68.0f/255.0f) alpha:1]]
                             forState:UIControlStateSelected];
    [outletBtnMenu setBackgroundImage:[delegate getImageWithColor:[UIColor colorWithRed:(201.0f/255.0f) green:(54.0f/255.0f) blue:(68.0f/255.0f) alpha:1]]
                             forState:UIControlStateSelected];

    [self actionBtnRest:nil];
    outletLblTitle.text = [delegate getStr:@"BUSCA"];
    self.tabBarItem.title = [delegate getStr:@"BUSCA"];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [uiTVSearch deselectRowAtIndexPath:[uiTVSearch indexPathForSelectedRow] animated:YES];
}

- (IBAction)actionBtnRest:(id)sender {
    
    [outletBtnRest setSelected:TRUE];
    [outletBtnMenu setSelected:FALSE];
    outletSearchBar.placeholder = NSLocalizedString(@"BUSCAR RESTAURANTE", nil);
    [self updateTable];
}
- (IBAction)actionBtnMenu:(id)sender {
    [outletBtnRest setSelected:FALSE];
    [outletBtnMenu setSelected:TRUE];
    outletSearchBar.placeholder = NSLocalizedString(@"BUSCAR PRATO", nil);
    [self updateTable];
}

-(void)updateTable{
    NSString *table;
    if (outletBtnRest.selected) {
        table = @"ZRESTAURANT";
    }else{
        table = @"ZMENU";
    }
    NSString *where;
    if (outletSearchBar.text.length<1) {
        where = @"1";
    }else{
        where = [NSString stringWithFormat:@"ZNAME like '%%%@%%'", outletSearchBar.text];
    }
    result = [[NSMutableArray alloc]initWithArray:[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from %@ where %@", table, where]]];
    if (result.count>0) {
        [uiTVSearch setHidden:FALSE];
    }else{
        [uiTVSearch setHidden:TRUE];
    }
    [uiTVSearch reloadData];
}

- (IBAction)actionBtnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"searchbar %@", searchBar.text );
}

    
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self updateTable];
    [outletSearchBar resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return result.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchRightArrowCell" forIndexPath:indexPath];
    NSDictionary *dic = [result objectAtIndex:indexPath.row];
    [cell.outletLblTitle setText:[dic valueForKey:@"ZNAME"]];
    [outletSearchBar resignFirstResponder];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", [result objectAtIndex:indexPath.row]);

    if (outletBtnRest.selected) {
        delegate.idRestSelected = [[[result objectAtIndex:indexPath.row] valueForKey:@"ZIDREST"] integerValue];
            RestaurantDetailViewController *rstd = (RestaurantDetailViewController*)[delegate getViewControllerWithIdentifier:@"rstDetail"];
          [self.navigationController pushViewController:rstd animated:YES];

    }else{
        delegate.idMenu = [[[result objectAtIndex:indexPath.row] valueForKey:@"ZIDMENU"] integerValue];
        MenuDetailViewController *mnu = (MenuDetailViewController*)[delegate getViewControllerWithIdentifier:@"menuDetail"];
        [self.navigationController pushViewController:mnu animated:YES];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self updateTable];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length==0) {
        [self updateTable];
    }
}

@end

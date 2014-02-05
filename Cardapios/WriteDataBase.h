//
//  ManageData.h
//  Imoveis
//
//  Created by mourodrigo on 21/10/13.
//  Copyright (c) 2013 catalogbrasil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
@interface WriteDataBase : NSObject<NSFetchedResultsControllerDelegate>



@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong) AppDelegate *appdelegate;

-(void)beginWriteData;
-(void)writeRestaurant:(NSDictionary *)dicJson;

@end

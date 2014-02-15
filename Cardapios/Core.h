//
//  ReturnObjectArquivos.h
//  Embraed
//
//  Created by Reinaldo Martins de Padua on 22/02/13.
//  Copyright (c) 2013 catalogbrasil. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <sqlite3.h>
@interface Core : NSObject<NSFetchedResultsControllerDelegate>{
    //sqlite3_stmt *selectstmt;
    
}

//@property(nonatomic,strong) AppDelegate *appdelegate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObject *objectImovel;
@property (strong, nonatomic) NSString *EntityName;
@property (strong, nonatomic) NSString *sortDescriptorKey;
@property (strong, nonatomic) NSPredicate *predicate;
@property (strong, nonatomic) NSString *type;

- (NSArray*)returnArray;
-(void)cleanDB;
//Static methods.
-(NSMutableArray*)sqliteDoQuery:(NSString *)query;

@end

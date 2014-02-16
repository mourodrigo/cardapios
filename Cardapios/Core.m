#import "Core.h"
#import <sqlite3.h>
#import "AppDelegate.h"
@implementation Core{
    sqlite3 *database;
    NSString *dbPath;
    AppDelegate *_appdelegate;
    
}

- (NSArray*)returnArray;
{
    return [self.fetchedResultsController fetchedObjects];

}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    if (!self.managedObjectContext) {
        
        _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        self.managedObjectContext = [_appdelegate managedObjectContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.EntityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:_sortDescriptorKey ascending:NO];
    
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];

    
    if (_predicate) {
        
        [fetchRequest setPredicate:_predicate];
    }
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"cache"];
    
    aFetchedResultsController.delegate = self;
    
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}


-(NSMutableArray*)sqliteDoQuery:(NSString *)query{
	
    @try {
        if (!_appdelegate || dbPath.length==0) {
            _appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            dbPath = [_appdelegate getDBPath];
        }
        NSMutableArray *resultArray = [[NSMutableArray alloc]initWithCapacity:0];
        if (!database) {
            if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK){
                NSLog(@"sqlite3_open OK");
            }else{
                NSLog(@"sqlite3_open FAIL");
                return nil;
            }
        }
            const char *sql = [query UTF8String];
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
                while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                    int colCount = sqlite3_column_count(selectstmt);
                    int x=0;
                    
                    NSMutableDictionary *rowDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
                    while (x<=colCount) {
                        
                        //NSLog(@"%s -> tipo: %d",sqlite3_column_name(selectstmt, x), sqlite3_column_type(selectstmt, x));
                        if (sqlite3_column_bytes(selectstmt, x)!=0) {
                            switch (sqlite3_column_type(selectstmt, x)) {
                                case 1: //integer
                                    [rowDictionary setValue:[NSNumber numberWithInt:sqlite3_column_int(selectstmt, x)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(selectstmt, x)]];
                                    break;
                                case 2: //float
                                    [rowDictionary setValue:[NSNumber numberWithInt:sqlite3_column_int(selectstmt, x)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(selectstmt, x)]];
                                    break;
                                case 3: //text
                                    [rowDictionary setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, x)] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(selectstmt, x)]];
                                    break;
                                case 4: //blob
                                    //NSLog(@"Ao utilizar blob deve haver um campo ZLENGHT informando o tamanho do blob na mesma tabela ANTES do atributo blob");
                                    [rowDictionary setValue:[NSData dataWithBytes:sqlite3_column_blob(selectstmt, x) length:[[rowDictionary valueForKey:@"ZLENGHT"] integerValue]] forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(selectstmt, x)]];
                                    break;
                                case 5: //null
                                    [rowDictionary setValue:nil forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_name(selectstmt, x)]];
                                    break;
                                default:
                                    break;
                            }
                        }
                        x++;
                    }
                    [resultArray addObject:rowDictionary];
                    
                }
            }else{
                NSLog(@"sqlite3_prepare_v2 failed");
                NSLog(@"QUERY -> %@", query);
                return nil;
            
            }
        
        if (resultArray.count!=0) {
            //NSLog(@"resultSQL \n%@", resultArray);
            return resultArray;
        }else{
            return nil;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception ReturnObjects doquery : %@", exception.description);
  
    }
}

-(void)cleanDB{
    sqlite3_free(database);
    sqlite3_close(database);
}
@end

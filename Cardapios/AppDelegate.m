

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Core.h"
#import "AFHTTPClient.h"
#import "AFImageRequestOperation.h"
@implementation AppDelegate{
    Core *db;
}
@synthesize window = _window;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
//@synthesize db;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    // Override point for customization after application launch.
    [self eraseDb];
    [self persistentStoreCoordinator];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma - mark Database
- (void)saveContext
{
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSString *)getDBPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"database.sqlite"];
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"database" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"database.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

-(NSArray*)sqliteDoQuery:(NSString*)query{
    @try {
        //NSLog(@"query -> %@", query);
        if (!db) {
            db= [[Core alloc]init];
        }
        NSArray *arr = [db sqliteDoQuery:query];
        
        if (arr==nil) {
            NSLog(@"exception sqliteDoQuery -> %@", query);
            
            [NSException raise:@"SQLITE_DO_QUERY_ERROR" format:@"SQLITE_DO_QUERY_ERROR"];
        }
        
        return [db sqliteDoQuery:query];
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception sqliteDoQuery -> %@", exception.description);
        return nil;
    }
}



- (void)eraseDb{
    /*
    NSString *dbpath = [[NSString alloc]initWithString:[self getDBPath]];
    NSLog(@"erase db %@", dbpath);

    NSError *error = nil;
    if ([[NSFileManager defaultManager]fileExistsAtPath:dbpath]) {
        [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:dbpath] error:&error];
            [[NSFileManager defaultManager]removeItemAtURL:[NSURL URLWithString:dbpath] error:&error]
        ;
    }*/
    [self sqliteDoQuery:@"DELETE FROM ZCITY WHERE 1"];
    [self sqliteDoQuery:@"DELETE FROM ZFOODCATEGORY WHERE 1"];
    [self sqliteDoQuery:@"DELETE FROM ZRESTAURANT WHERE 1"];
    [self sqliteDoQuery:@"DELETE FROM ZMENU WHERE 1"];

}

-(void)storeFav:(NSMutableArray*)favs{
    [favs writeToFile:[[NSString stringWithFormat:@"~/Documents/fav.plist"] stringByExpandingTildeInPath] atomically:YES];
}

-(NSMutableArray*)loadAllFav{
    return [[NSMutableArray alloc]initWithContentsOfFile:[[NSString stringWithFormat:@"~/Documents/fav.plist"] stringByExpandingTildeInPath]];
}

-(void)storeMenuFav:(NSMutableArray*)favs{
    [favs writeToFile:[[NSString stringWithFormat:@"~/Documents/favMenu.plist"] stringByExpandingTildeInPath] atomically:YES];
}

-(NSMutableArray*)loadAllMenuFav{
    return [[NSMutableArray alloc]initWithContentsOfFile:[[NSString stringWithFormat:@"~/Documents/favMenu.plist"] stringByExpandingTildeInPath]];
}


#pragma - mark Interface


-(UIViewController*)getViewControllerWithIdentifier:(NSString*)identifier{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [mainStoryboard instantiateViewControllerWithIdentifier:identifier];
}

-(UIImage *)getImageWithColor:(UIColor *)color;
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma - mark Constants

-(NSDictionary *)getInfoPlist{
    if (![[NSFileManager defaultManager]fileExistsAtPath:[@"~/Documents/constants.plist" stringByExpandingTildeInPath]]) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"constants" ofType:@"plist"];
        NSDictionary *info = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
        [info writeToFile:[@"~/Documents/constants.plist" stringByExpandingTildeInPath] atomically:YES];
        return info;
    }else{
        NSString *plistPath = [@"~/Documents/constants.plist" stringByExpandingTildeInPath];
        NSDictionary *info = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
        return info;
    }
}

-(NSString *)getStr:(NSString*)string{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"stringz" ofType:@"plist"];
        NSDictionary *info = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    if ([[info valueForKey:string] valueForKey:[[self getInfoPlist] valueForKey:@"idioma"]]) {
     return [[info valueForKey:string] valueForKey:[[self getInfoPlist] valueForKey:@"idioma"]];
    }else{
        return string;
    }
}

-(void)setInfoPlist:(NSDictionary*)constants{
    [constants writeToFile:[@"~/Documents/constants.plist" stringByExpandingTildeInPath] atomically:YES];
}

-(void)setIdiomWithString:(NSString*)idiom{
    NSMutableDictionary *dic = (NSMutableDictionary*)[self getInfoPlist];
    [dic setValue:idiom forKey:@"idioma"];
    [self setInfoPlist:dic];
}


#pragma - mark Download

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
     //NSLog(@"addskipbackup: %@", URL);
     assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
     
     NSError *error = nil;
     BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
     forKey: NSURLIsExcludedFromBackupKey error: &error];
     if(!success){
     NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
     }
     //NSLog(@"%@ backup %i",URL, success);*/
    
    //NSLog(@"ATIVAR ADD SKIP BACKUP");
    return TRUE;
}


- (void)imageRequest:(NSString*)directoryname withFileName:(NSString*)nameFile storeAtpath:(NSString*)downloadPath{
    NSString *api = [[self getInfoPlist]valueForKey:@"api"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:[api stringByAppendingString:@"%@%@"],directoryname,nameFile]]];
    
     NSLog(@"getFile url %@", request.URL);
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,
                                                 (unsigned long)NULL), ^(void) {
            
            NSString *pathToWriteFile = [[NSString stringWithFormat:@"~/Documents/%@%@",downloadPath,nameFile] stringByExpandingTildeInPath];
            
            NSError *erro;
            if (![[NSFileManager defaultManager] fileExistsAtPath:[[NSString stringWithFormat:@"~/Documents/%@",downloadPath] stringByExpandingTildeInPath]]){
                [[NSFileManager defaultManager] createDirectoryAtPath:[[NSString stringWithFormat:@"~/Documents/%@",downloadPath] stringByExpandingTildeInPath] withIntermediateDirectories:NO attributes:nil error:&erro];
            }
            
            if ([[nameFile pathExtension]isEqualToString:@"png"]) {
                [UIImagePNGRepresentation(image) writeToFile:pathToWriteFile atomically:YES];
                
            }else{
                [UIImageJPEGRepresentation(image, 1.0) writeToFile:pathToWriteFile atomically:YES];
            }
            
            [self addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:pathToWriteFile]];
            
            NSLog(@"\n\nGetFileRequest: %@", request.URL);
            NSLog(@"downloadpath %@\n\n", pathToWriteFile);
            
            
        });
        
    }  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [self imageRequest:directoryname withFileName:nameFile storeAtpath:downloadPath];
        NSLog(@"%@ responsefailcode %d", nameFile, error.code);
    }];

    [operation start];
}



@end

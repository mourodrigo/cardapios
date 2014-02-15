//
//  AppDelegate.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 24/11/13.
//  Copyright (c) 2013 mourodrigo. All rights reserved.
//
// :D
#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(UIViewController*)getViewControllerWithIdentifier:(NSString*)identifier;
-(NSDictionary *)getInfoPlist;
-(void)setInfoPlist:(NSDictionary*)constants;
-(void)setIdiomWithString:(NSString*)idiom;
- (void)saveContext;
- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (void)eraseAllDataBAse;
- (NSString *)getDBPath;
@property (strong, nonatomic) NSMutableArray *infoToSync;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
-(NSArray*)sqliteDoQuery:(NSString*)query;
@end

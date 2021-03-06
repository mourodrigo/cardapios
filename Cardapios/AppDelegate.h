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
-(NSMutableDictionary *)getInfoPlist;
-(void)setInfoPlist:(NSMutableDictionary*)constants;
-(void)setIdiomWithString:(NSString*)idiom;
- (void)saveContext;
- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (void)eraseDb;
- (NSString *)getDBPath;
@property (strong, nonatomic) NSMutableArray *infoToSync;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSString *CitySelected;
@property (nonatomic) int idRestSelected;
@property (nonatomic) int idMenu;
-(void)storeFav:(NSMutableArray*)favs;
-(NSMutableArray*)loadAllFav;
-(NSArray*)sqliteDoQuery:(NSString*)query;
-(UIImage *)getImageWithColor:(UIColor *)color;
- (void)imageRequest:(NSString*)directoryname withFileName:(NSString*)nameFile storeAtpath:(NSString*)downloadPath;
-(NSMutableArray*)loadAllMenuFav;
-(void)storeMenuFav:(NSMutableArray*)favs;
-(NSString *)getStr:(NSString*)string;
-(BOOL)verificaConexao;
@end

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
-(void)writeDataBaseEmpresa:(NSDictionary*)dicJson;
-(void)writeDataBaseImovel:(NSDictionary *)dicJson;
-(void)writeImages:(NSDictionary*)dicJson;
-(void)writePlantas:(NSDictionary*)dicJson;
- (void)writeDataImovel:(NSDictionary *)dicJson;
-(void)writePhotos3d:(NSArray*)arrayPhotos3d :(int)idImovel;
-(void)writeArquivos:(NSString*)campo deTipo:(NSString*)tipo paraImovelId:(int)idImovel userId:(int)userId;
@end

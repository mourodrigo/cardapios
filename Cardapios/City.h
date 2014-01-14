//
//  City.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 14/01/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;

@end

//
//  AppDelegate.h
//  SaveEat
//
//  Created by  on 10/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) HomeViewController *homeVCobj;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController1;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController2;

@property (nonatomic, strong) IBOutlet UITabBarController *tabcontroller;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

//
//  SLTableViewContent.h
//  iCuisineAPI
//
//  Created by Oliver Letterer on 11.03.13.
//  Copyright 2013 SparrowLabs. All rights reserved.
//

@class SLTableViewContentController;



/**
 @abstract  <#abstract comment#>
 */
@interface SLTableViewContent : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) UINavigationItem *navigationItem;

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, weak, readonly) SLTableViewContentController *tableViewController;

- (id)initWithTableViewController:(SLTableViewContentController *)tableViewController;

- (void)contentWillAppearAnimated:(BOOL)animated;
- (void)contentDidAppearAnimated:(BOOL)animated;

- (void)contentWillDisappearAnimated:(BOOL)animated;
- (void)contentDidDisappearAnimated:(BOOL)animated;

@end

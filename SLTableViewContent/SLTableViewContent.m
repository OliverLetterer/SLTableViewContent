//
//  SLTableViewContent.m
//  iCuisineAPI
//
//  Created by Oliver Letterer on 11.03.13.
//  Copyright 2013 SparrowLabs. All rights reserved.
//

#import "SLTableViewContent.h"
#import "SLTableViewContentController.h"



@interface SLTableViewContent () {
    
}

@end



@implementation SLTableViewContent
@synthesize navigationItem = _navigationItem;

#pragma mark - setters and getters

- (UITableView *)tableView
{
    if (self.tableViewController.content == self) {
        return self.tableViewController.tableView;
    }
    
    return nil;
}

- (void)setTitle:(NSString *)title
{
    if (title != _title) {
        _title = title.copy;
        
        self.navigationItem.title = _title;
    }
}

- (UINavigationItem *)navigationItem
{
    if (!_navigationItem) {
        _navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    }
    
    return _navigationItem;
}

- (void)setRefreshControl:(UIRefreshControl *)refreshControl
{
    if (_refreshControl != refreshControl) {
        _refreshControl = refreshControl;
        
        if (self.tableViewController.content == self) {
            [self.tableViewController.refreshControl endRefreshing];
            self.tableViewController.refreshControl = refreshControl;
        }
    }
}

#pragma mark - Initialization

- (id)initWithTableViewController:(SLTableViewContentController *)tableViewController
{
    if (self = [super init]) {
        _tableViewController = tableViewController;
    }
    
    return self;
}

#pragma mark - Content appearance

- (void)contentWillAppearAnimated:(BOOL)animated
{
    
}

- (void)contentDidAppearAnimated:(BOOL)animated
{
    
}

- (void)contentWillDisappearAnimated:(BOOL)animated
{
    
}

- (void)contentDidDisappearAnimated:(BOOL)animated
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end

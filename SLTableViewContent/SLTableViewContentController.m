//
//  SLTableViewContentController.m
//  iCuisineAPI
//
//  Created by Oliver Letterer on 11.03.13.
//  Copyright 2013 SparrowLabs. All rights reserved.
//

#import "SLTableViewContentController.h"
#import "SLTableViewContent.h"



@interface SLTableViewContentController () {
    
}

@property (nonatomic, strong) SLTableViewContent *content;

@end



@implementation SLTableViewContentController

#pragma mark - setters and getters

- (UINavigationItem *)navigationItem
{
    return self.content.navigationItem ?: [super navigationItem];
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        _pushAnimation = UITableViewRowAnimationRight;
        _popAnimation = UITableViewRowAnimationLeft;
        
        if ([self respondsToSelector:@selector(setRestorationIdentifier:)]) {
            self.restorationIdentifier = NSStringFromClass(self.class);
            self.restorationClass = self.class;
        }
    }
    return self;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Instance methods

- (void)pushContent:(SLTableViewContent *)content animated:(BOOL)animated
{
    if (self.content == content) {
        return;
    }
    
    SLTableViewContent *previousContent = self.content;
    
    [self.refreshControl endRefreshing];
    self.refreshControl = nil;
    
    [previousContent contentWillDisappearAnimated:animated];
    [content contentWillAppearAnimated:animated];
    
    if (animated) {
        [self.navigationController.navigationBar pushNavigationItem:content.navigationItem animated:animated];
    } else {
        [self.navigationController.navigationBar setItems:@[ content.navigationItem ] animated:animated];
    }
    
    [self.tableView beginUpdates];
    
    UITableViewRowAnimation deleteAnimation = UITableViewRowAnimationNone;
    UITableViewRowAnimation insertAnimation = UITableViewRowAnimationNone;
    if (animated) {
        deleteAnimation = self.popAnimation;
        insertAnimation = self.pushAnimation;
    }
    
    self.content = content;
    self.refreshControl = self.content.refreshControl;
    
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections)]
                  withRowAnimation:deleteAnimation];
    
    [self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self numberOfSectionsInTableView:self.tableView])]
                  withRowAnimation:insertAnimation];
    
    [self.tableView endUpdates];
    
    if (animated) {
        [CATransaction setCompletionBlock:^{
            [previousContent contentDidDisappearAnimated:animated];
            [content contentDidAppearAnimated:animated];
            
            [self scrollViewDidScroll:self.tableView];
        }];
    } else {
        [previousContent contentDidDisappearAnimated:animated];
        [content contentDidAppearAnimated:animated];
        
        [self scrollViewDidScroll:self.tableView];
    }
}

- (void)popToContent:(SLTableViewContent *)content animated:(BOOL)animated
{
    if (self.content == content) {
        return;
    }
    
    if (animated) {
        [self.navigationController.navigationBar setItems:@[ content.navigationItem, self.content.navigationItem ]
                                                       animated:NO];
        [self.navigationController.navigationBar popNavigationItemAnimated:animated];
    } else {
        [self.navigationController.navigationBar setItems:@[ content.navigationItem ] animated:animated];
    }
    
    [self.refreshControl endRefreshing];
    self.refreshControl = nil;
    
    SLTableViewContent *previousContent = self.content;
    
    [previousContent contentWillDisappearAnimated:animated];
    [content contentWillAppearAnimated:animated];
    
    [self.tableView beginUpdates];
    
    UITableViewRowAnimation deleteAnimation = UITableViewRowAnimationNone;
    UITableViewRowAnimation insertAnimation = UITableViewRowAnimationNone;
    if (animated) {
        deleteAnimation = self.pushAnimation;
        insertAnimation = self.popAnimation;
    }
    
    self.content = content;
    self.refreshControl = self.content.refreshControl;
    
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections)]
                  withRowAnimation:deleteAnimation];
    
    [self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self numberOfSectionsInTableView:self.tableView])]
                  withRowAnimation:insertAnimation];
    
    [self.tableView endUpdates];
    
    if (animated) {
        [CATransaction setCompletionBlock:^{
            [previousContent contentDidDisappearAnimated:animated];
            [content contentDidAppearAnimated:animated];
            
            [self scrollViewDidScroll:self.tableView];
        }];
    } else {
        [previousContent contentDidDisappearAnimated:animated];
        [content contentDidAppearAnimated:animated];
        
        [self scrollViewDidScroll:self.tableView];
    }
}

#pragma mark - View lifecycle

//- (void)loadView
//{
//    [super loadView];
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.tableView respondsToSelector:@selector(setRestorationIdentifier:)]) {
        self.tableView.restorationIdentifier = NSStringFromClass(self.tableView.class);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.content contentWillAppearAnimated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.items = @[ self.content.navigationItem ];
    
    [self.content contentDidAppearAnimated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.content contentWillDisappearAnimated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.content contentDidDisappearAnimated:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_content numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_content tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_content tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.content respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.content tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.content respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        return [self.content tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//
//}

// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_content tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_content respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [_content tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_content respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [_content tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_content tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.content respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.content tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.content respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.content scrollViewDidScroll:scrollView];
    }
}

#pragma mark - UIViewControllerRestoration

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    return [[self alloc] init];
}

#pragma mark - UIStateRestoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];
    
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];
    
}

#pragma mark - UIDataSourceModelAssociation

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)indexPath inView:(UIView *)view
{
    if (indexPath) {
        
    }
    
    return nil;
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view
{
    if (identifier) {
        
    }
    
    return nil;
}

#pragma mark - Private category implementation ()

@end

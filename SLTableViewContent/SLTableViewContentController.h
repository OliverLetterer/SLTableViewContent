//
//  SLTableViewContentController.h
//  iCuisineAPI
//
//  Created by Oliver Letterer on 11.03.13.
//  Copyright 2013 SparrowLabs. All rights reserved.
//

@class SLTableViewContent;



/**
 @abstract  <#abstract comment#>
 */
@interface SLTableViewContentController : UITableViewController <UIViewControllerRestoration, UIDataSourceModelAssociation>

@property (nonatomic, assign) UITableViewRowAnimation pushAnimation;
@property (nonatomic, assign) UITableViewRowAnimation popAnimation;

@property (nonatomic, readonly) SLTableViewContent *content;

- (void)pushContent:(SLTableViewContent *)content animated:(BOOL)animated;
- (void)popToContent:(SLTableViewContent *)content animated:(BOOL)animated;

@end

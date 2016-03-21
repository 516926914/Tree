//
//  BinaryTreeNode.h
//  Tree
//
//  Created by jyd on 16/3/7.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

@property(nonatomic,assign)NSInteger value;

@property(nonatomic,strong)BinaryTreeNode *LeftNode;

@property(nonatomic,strong)BinaryTreeNode *RightNode;

@end

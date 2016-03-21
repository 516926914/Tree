//
//  BinaryTreeNode.m
//  Tree
//
//  Created by jyd on 16/3/7.
//  Copyright © 2016年 jyd. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode


+(BinaryTreeNode *)creatTreeWithValue:(NSArray *)values{
    BinaryTreeNode *root = nil;
    for(NSInteger i = 0; i < values.count; i++){
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [BinaryTreeNode addTreeNode:root value:value];
    }
    return root;
}

+(BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value{
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
    }else if (value <= treeNode.value){
        treeNode.LeftNode = [BinaryTreeNode addTreeNode:treeNode.LeftNode value:value];
    }else{
        treeNode.RightNode = [BinaryTreeNode addTreeNode:treeNode.RightNode value:value];
    }
    return treeNode;
}

-(BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTreeNode:(BinaryTreeNode *)rootNode{
    if (!rootNode || index < 0) {
        return nil;
    }
    NSMutableArray * queueArray = [[NSMutableArray  alloc] init];
    [queueArray addObject:rootNode];
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        if (index == 0) {
            return node;
        }
        [queueArray removeObjectAtIndex:0];
        index --;
        if (node.LeftNode) {
            [queueArray addObject:node.LeftNode];
        }
        if (node.RightNode) {
            [queueArray addObject:node.RightNode];
        }
    }
    return nil;
}


+(void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle{
    if (rootNode) {
        if (handle) {
            handle(rootNode);
        }
    }
    [self preOrderTraverseTree:rootNode.LeftNode handle:handle];
    [self preOrderTraverseTree:rootNode.RightNode handle:handle];
}

+(void)levelTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle{
    if (!rootNode) {
        return;
    }
    NSMutableArray *queue = [[NSMutableArray alloc] init];
    [queue addObject:rootNode];
    while (queue.count >0) {
        BinaryTreeNode *node = [[BinaryTreeNode alloc] init];
        if (handle) {
            handle(node);
        }
        [queue removeObjectAtIndex:0];
        
        if (node.LeftNode) {
            [queue addObject:node.LeftNode];
        }
        if (node.RightNode) {
            [queue addObject:node.RightNode];
        }
    }
    
}
///二叉树的深度
+(NSInteger)depthOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.LeftNode && !rootNode.RightNode) {
        return 1;
    }
    NSInteger leftDepth = [self depthOfTree:rootNode.LeftNode];
    NSInteger rightDepth = [self depthOfTree:rootNode.RightNode];
    return MAX(leftDepth, rightDepth) +1;
}
///二叉树的宽度
+(NSInteger)widthOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return 0;
    }
    NSMutableArray *queueArray = [[NSMutableArray alloc] init];
    [queueArray addObject:rootNode];
    NSInteger maxWidth = 1;
    NSInteger curWidth = 0;
    while (queueArray.count > 0) {
        curWidth = queueArray.count;
        for (NSInteger i = 0; i < curWidth; i++) {
            BinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0];
            if (node.LeftNode) {
                [queueArray addObject:node.LeftNode];
            }
            if (node.RightNode) {
                [queueArray addObject:node.RightNode];
            }
        }
        maxWidth = MAX(maxWidth, queueArray.count);
        
    }
    return maxWidth;
}

+(NSInteger)numberOfNodeOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return 0;
    }
    return [self numberOfNodeOfTree:rootNode.LeftNode] + [self numberOfNodeOfTree:rootNode.RightNode];
}

+(NSInteger)numberOfNodeOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode{
    if (!rootNode || level <1) {
        return 0;
    }
    if (level == 1) {
        return 1;
    }
    return [self numberOfNodeOnLevel:level -1 inTree:rootNode.LeftNode] + [self numberOfNodeOnLevel:level -1 inTree:rootNode.RightNode];
}

+(instancetype)shareInstance{
    static BinaryTreeNode * treeNode;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (treeNode) {
            treeNode = [[BinaryTreeNode alloc] init];
        }
    });
    return treeNode;
}


@end

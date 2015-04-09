//
//  PPPMessageTableViewController.m
//  PaperPlane
//
//  Copyright (c) 2014 Matt Rubin
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "PPPMessageTableViewController.h"
#import "PPPConversation.h"
#import "PPPMessage.h"


@interface PPPMessageTableViewController () <UICollectionViewDelegateFlowLayout>

@end


@implementation PPPMessageTableViewController

- (instancetype)init
{
    return [self initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Message Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.conversation.messages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Message Cell" forIndexPath:indexPath];

//    cell.frame = CGRectMake(0, 0, 100, 100);
    cell.backgroundColor = [UIColor redColor];
    PPPMessage *message = self.conversation.messages[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", message.text];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.view.bounds), 50);
}


#pragma mark - Conversation

- (void)setConversation:(PPPConversation *)conversation
{
    if (_conversation != conversation) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:PPPConversationDidAddMessageNotification
                                                      object:_conversation];
        _conversation = conversation;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(conversationDidAddMessage)
                                                     name:PPPConversationDidAddMessageNotification
                                                   object:_conversation];
    }
}

- (void)conversationDidAddMessage
{
    // TODO: more granular update
    [self.collectionView reloadData];
}

@end

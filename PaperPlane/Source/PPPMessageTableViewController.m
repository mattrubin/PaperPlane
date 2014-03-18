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


@interface PPPMessageTableViewController () <PPPConversationDelegate>

@property (nonatomic, strong) PPPConversation *conversation;

@end


@implementation PPPMessageTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.conversation = [PPPConversation new];
        self.conversation.delegate = self;
        [self.conversation sendMessage:[PPPMessage messageWithText:@"Hello!"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Message Cell"];

    // Pretend a new message comes in after five seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.conversation sendMessage:[PPPMessage messageWithText:@"Goodbye!"]];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversation.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Message Cell" forIndexPath:indexPath];
    
    PPPMessage *message = self.conversation.messages[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", message.text];
    
    return cell;
}


#pragma mark - Conversation delegate

- (void)conversation:(PPPConversation *)conversation didAddMessage:(PPPMessage *)message
{
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(conversation.messages.count - 1)
                                                                inSection:0]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end

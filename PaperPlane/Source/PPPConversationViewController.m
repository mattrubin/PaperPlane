//
//  PPPConversationViewController.m
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

#import "PPPConversationViewController.h"
#import "PPPMessageTableViewController.h"
#import "PPPConversation.h"
#import "PPPMessage.h"


@interface PPPConversationViewController ()

@property (nonatomic, strong) PPPMessageTableViewController *messageTableViewController;

@end


@implementation PPPConversationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _messageTableViewController = [PPPMessageTableViewController new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addChildViewController:self.messageTableViewController];
    [self.view addSubview:self.messageTableViewController.view];
    self.messageTableViewController.view.frame = self.view.bounds;
    [self.messageTableViewController didMoveToParentViewController:self];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMessage)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Conversation

- (void)setConversation:(PPPConversation *)conversation
{
    if (_conversation != conversation) {
        _conversation = conversation;

        self.messageTableViewController.conversation = conversation;
    }
}

- (void)addMessage
{
    [self.conversation sendMessage:[PPPMessage messageWithText:@"New message!"]];
}

@end

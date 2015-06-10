//
//  SearchViewController.m
//  Test
//
//  Created by Killua Liu on 6/2/15.
//  Copyright (c) 2015 Syzygy. All rights reserved.
//

#import "SearchViewController.h"

#define kSearchCell @"searchCell"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPodcast];
    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"podcast" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)loadPodcast
{
    self.podcast = [[NSUserDefaults standardUserDefaults] objectForKey:@"podcast"];
}

- (void)setPodcast:(NSDictionary *)podcast
{
    if (_podcast != podcast) {
        _podcast = podcast;
        [self updateView];
    }
}

- (void)updateView
{
    self.title = self.podcast[@"collectionName"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"podcast"]) {
        self.podcast = [object objectForKey:@"podcast"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)dealloc
{
    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"podcast"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
}

- (NSURLSession *)session
{
    if (!_session) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfig setHTTPAdditionalHeaders:@{ @"Accept":@"application/json" }];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig];
    }
    return _session;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.podcasts ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.podcasts ? self.podcasts.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCell forIndexPath:indexPath];
    NSDictionary *podcast = self.podcasts[indexPath.row];
    cell.textLabel.text = podcast[@"collectionName"];
    cell.detailTextLabel.text = podcast[@"artistName"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *podcast = self.podcasts[indexPath.row];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:podcast forKey:@"podcast"];
    [userDefaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (!searchText) return;
    if (searchText.length <= 3) {
        [self resetSearch];
    } else {
        [self performSearch];
    }
}

- (void)resetSearch
{
    [self.podcasts removeAllObjects];
    [self.tableView reloadData];
}

- (void)performSearch
{
    NSString *query = self.searchBar.text;
    
    if (self.dataTask) {
        [self.dataTask cancel];
    }
    
    self.dataTask = [self.session dataTaskWithURL:[self urlForQuery:query] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (-999 != error.code) {
                NSLog(@"%@", error);
            }
        } else {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *results = result[@"results"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (results) {
                    [self processResults:results];
                }
            });
        }
    }];
    
    if (self.dataTask) {
        [self.dataTask resume];
    }
}

- (NSURL *)urlForQuery:(NSString *)query
{
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?media=podcast&entity=podcast&term=%@", query]];
}

- (void)processResults:(NSArray *)results
{
    if (!self.podcasts) {
        self.podcasts = [NSMutableArray array];
    }
    
    [self.podcasts removeAllObjects];
    [self.podcasts addObjectsFromArray:results];
    
    [self.tableView reloadData];
}

@end

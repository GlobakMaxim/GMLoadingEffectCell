# Loading effect for Table view cell

![alt sample](./sample.gif "Sample")

### Cell has:
+ animation duration
+ complition block
+ failure block

#### cellForRowAtIndexPath method look like this
```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GMLoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GMLoadingTableViewCell cellIdentifier]];
    cell.label.text = @"Cell text"
    cell.animationDuration = 2;
    cell.completionBlock = ^{
        NSLog(@"Done!");
    };
    cell.failureBlock = ^{
      NSLog(@"Fail!");
    };
    return cell;
}
```

#### Important
```objective-c
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
```
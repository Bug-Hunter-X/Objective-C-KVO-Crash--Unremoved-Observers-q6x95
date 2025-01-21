To fix this, always remove observers in the `-dealloc` method of your observer class and/or using the `removeObserver:forKeyPath:` method when appropriate.  This ensures that the observer is no longer referencing the deallocated object.

```objectivec
@interface MyObserver : NSObject
@end

@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // ... your KVO handling code ...
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"observedProperty"];
    [super dealloc];
}
@end

// Or better in modern Objective-C using blocks and automatic removal:

[myObservedObject addObserver:self forKeyPath:@"observedProperty" options:NSKeyValueObservingOptionNew context:NULL];

// ... later...
[myObservedObject removeObserver:self forKeyPath:@"observedProperty"];

```
By using `removeObserver:forKeyPath:` within a block or in `-dealloc`, this will solve most of the issues.  Also consider using weak references where possible to break retain cycles.
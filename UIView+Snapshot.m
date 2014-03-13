#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)snapshotLegacy {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [self.layer renderInContext:ctx];
    
    UIImage *shapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return shapshotImage;
}

- (UIImage *)screenshotModern {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    
    UIImage *shapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return shapshotImage;
}

- (UIImage *)snapshot {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // About 1.8x faster ~50ms
        return [self screenshotModern];
    } else {
        // Slow ~90ms
        return [self snapshotLegacy];
    }
}

@end

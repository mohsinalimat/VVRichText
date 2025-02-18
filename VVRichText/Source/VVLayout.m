
#import "VVLayout.h"

#import <objc/runtime.h>


@interface VVLayout ()

@property(nonatomic, strong) NSMutableArray<VVTextStorage *> *textStorages;
@property(nonatomic, strong) NSMutableArray<VVImageStorage *> *imageStorages;
@property(nonatomic, strong) NSMutableArray<VVStorage *> *totalStorages;

@end

@implementation VVLayout

- (void)addStorage:(nullable VVStorage *)storage {
    if (!storage) {
        return;
    }

    if ([storage isMemberOfClass:[VVTextStorage class]]) {
        VVTextStorage *textStorage = (VVTextStorage *) storage;
        [textStorage vv_layout];
        [self.textStorages addObject:textStorage];
    } else if ([storage isMemberOfClass:[VVImageStorage class]]) {
        [self.imageStorages addObject:(VVImageStorage *) storage];
    }

    [self.totalStorages addObject:storage];
}

- (void)addStorages:(nullable NSArray <VVStorage *> *)storages {
    if (!storages) {
        return;
    }

    for (VVStorage *storage in storages) {
        [self addStorage:storage];
    }

    [self.totalStorages addObjectsFromArray:storages];
}


- (void)removeStorage:(nullable VVStorage *)storage {
    if (!storage) {
        return;
    }

    if ([storage isMemberOfClass:[VVTextStorage class]]) {
        if ([self.textStorages containsObject:storage]) {
            [self.textStorages removeObject:storage];
            [self.totalStorages removeObject:storage];
        }
    } else if ([storage isMemberOfClass:[VVImageStorage class]]) {
        if ([self.imageStorages containsObject:storage]) {
            [self.imageStorages removeObject:storage];
            [self.totalStorages removeObject:storage];
        }
    }
}

- (void)removeStorages:(nullable NSArray <VVStorage *> *)storages {
    if (!storages) {
        return;
    }

    for (VVStorage *storage in storages) {
        [self removeStorage:storage];
    }
}

- (CGFloat)suggestHeightWithBottomMargin:(CGFloat)bottomMargin {
    CGFloat suggestHeight = 0.0f;
    for (VVStorage *storage in self.totalStorages) {
        suggestHeight = suggestHeight > storage.bottom ? suggestHeight : storage.bottom;
    }

    return suggestHeight + bottomMargin;
}

#pragma mark - Getter

- (nullable NSMutableArray *)textStorages {
    if (_textStorages) {
        return _textStorages;
    }

    _textStorages = [NSMutableArray new];
    return _textStorages;
}

- (nullable NSMutableArray *)imageStorages {
    if (_imageStorages) {
        return _imageStorages;
    }

    _imageStorages = [NSMutableArray new];
    return _imageStorages;
}

- (nullable NSMutableArray *)totalStorages {
    if (_totalStorages) {
        return _totalStorages;
    }

    _totalStorages = [NSMutableArray new];
    return _totalStorages;
}

@end

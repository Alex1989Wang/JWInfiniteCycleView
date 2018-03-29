# JWInfiniteCollectionView

[![CI Status](http://img.shields.io/travis/Alex1989Wang/JWInfiniteCollectionView.svg?style=flat)](https://travis-ci.org/Alex1989Wang/JWInfiniteCollectionView)
[![Version](https://img.shields.io/cocoapods/v/JWInfiniteCollectionView.svg?style=flat)](http://cocoapods.org/pods/JWInfiniteCollectionView)
[![License](https://img.shields.io/cocoapods/l/JWInfiniteCollectionView.svg?style=flat)](http://cocoapods.org/pods/JWInfiniteCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/JWInfiniteCollectionView.svg?style=flat)](http://cocoapods.org/pods/JWInfiniteCollectionView)

Sometimes, your app’s UX designer wants infinite scroll for one of your collection views when the data displayed is limited. When a user scrolls to the very end of the data set, the first piece of data reappears on screen; if the use scrolls the other way, the last piece of data reappears.Traditionally, the solution for an infinite UICollectionView is to have a large duplicated data set (for example, 1000 * original data set) to trick the user into believing the collection view is infinite. 

But, a large duplicated data will inevitably introduce extra overhead by having a large amount of UICollectionViewLayoutAttributes. Besides, what if the user is bored to death and just sits there for a day to scroll your collection view? The chance for this to happen might be small, but, after all, having a large duplicated data set is not a very elegant solution.

JWInfiniteCollectionView pads only a few extra duplicated items both at the start and end of your data set. In this way, it avoids most of the overhead introduced by having a large duplicated data set, if not all. 

## How Infinite-scrolling Works 

The infinite scrolling is made possible by padding extra items at both the left and right side (brown rectangles) of the original data set (black rectangles) to achieve larger scrollable area; This is similar to having a large duplicated data set, but difference is the amount.

- At start, the collection view’s contentOffset is calculated to show only the original data set (drawn in black rectangles);
- When the user scrolls right and contentOffset hits the trigger value, we reset contentOffset to show same visual results; but actually padded data set;
- When the user scrolls left, the same logic is used.

<div align='center'>
<img 
src="https://raw.githubusercontent.com/Alex1989Wang/JWInfiniteCollectionView/master/Example/SceenShots/infinite_scroll_collection_view.png" 
width="680" 
title = "infinite scrolling"
alt = "infinite scrolling"
align = center
/>
</div>

For more details, you can [read this blog post](http://www.awsomejiang.com/2018/03/24/Infinite-Scrolling-and-the-Tiling-Logic/).

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<div align='center'>
<img 
src="https://raw.githubusercontent.com/Alex1989Wang/JWInfiniteCollectionView/master/Example/SceenShots/infinite_scroll.gif" 
width="350" 
title = "infinite scrolling"
alt = "infinite scrolling"
align = center
/>
</div>

## Requirements

- iOS 8.0+
- ARC

## Features

### Done 

- [x] horizontal infinite scrolling 
- [x] simple custom flow layout 

### To do 

- [ ] custom flow layout subclass to customize collection view cell layout attributes
- [ ] add a infinite switch flag so that switch between normal collection view and infinitely-scrolling collection view is possible 
- [ ] add more possible tests

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for developing iOS or OSX apps, which automates and simplifies the process of using 3rd-party libraries in your projects. See the ["Getting Started" guide for more information](https://guides.cocoapods.org/using/getting-started.html). You can install it with the following command:

```bash
$ gem install cocoapods
```

### Podfile

To integrate JWWaveView into your Xcode project using [CocoaPods](http://cocoapods.org), simply add the following line to your Podfile:

```ruby
pod 'JWInfiniteCollectionView'
```

Then, run the following command:

```bash
$ pod install
```

## Author

Alex1989Wang, alex1989wang@gmail.com

## License

JWInfiniteCollectionView is available under the MIT license. See the LICENSE file for more info.

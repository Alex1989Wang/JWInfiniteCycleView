//
//  JWInfiniteCollectionView_ExampleUITests.m
//  JWInfiniteCollectionView_ExampleUITests
//
//  Created by JiangWang on 2018/4/17.
//  Copyright © 2018 Alex1989Wang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JWInfiniteCollectionView_ExampleUITests : XCTestCase

@end

@implementation JWInfiniteCollectionView_ExampleUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInfiniteScroll {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"Random Data Count"]/*[[".cells.staticTexts[@\"Random Data Count\"]",".staticTexts[@\"Random Data Count\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *element = [[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Random Data Count"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *collectionView = [element childrenMatchingType:XCUIElementTypeCollectionView].element;
    //swipe left and right
    [collectionView swipeLeft];
    [collectionView swipeRight];
}

@end

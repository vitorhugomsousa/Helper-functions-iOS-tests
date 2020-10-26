extension XCTestCase {
    
    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 20,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout, handler: nil)

    }

    func enterText(_ text: String, in element: XCUIElement) {
        element.tap()
        wait(for: [expectation(for: NSPredicate(format: "hasKeyboardFocus == TRUE"), evaluatedWith: element, handler: nil)], timeout: 60)
        element.typeText(text)
    }
    
    func removeText(in element: XCUIElement, for app: XCUIApplication) {
        element.tap()
        wait(for: [expectation(for: NSPredicate(format: "hasKeyboardFocus == TRUE"), evaluatedWith: element, handler: nil)], timeout: 60)
        let textValue = element.value as? String  ?? ""
        element.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: textValue.count))
    }

}

extension XCUIApplication {
    
    func launchWithOutAnimations() {
        launchArguments.append("--disable-animations")
        launchArguments.append("--disable-in-app-messages")
        launch()
    }
    
}

extension XCUIElementQuery {
    
    func matching(label: String) -> XCUIElement {
        return matching(NSPredicate(format: "label == %@", label)).firstMatch
    }
    
}


import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TD_Qvec_post_processTests.allTests),
    ]
}
#endif

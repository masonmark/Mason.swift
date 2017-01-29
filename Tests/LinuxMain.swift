// LinuxMain.swift Created by mason on 2017-01-29. 

// Mason 2017-01-29: This fuckery is still required for running tests on Linux...
import XCTest
@testable import MasonTests

XCTMain([
    testCase(MasonTests.allTests),
    testCase(TestCaseTests.allTests),
    testCase(WastingTimeOnStackOverflowTests.allTests)
    ])

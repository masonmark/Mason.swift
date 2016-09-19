// WastingTimeOnStackOverflowTests.swift Created by mason on 2016-09-18.

import XCTest

/// Measures performance of two different ways of checking whether an index is valid
/// for a given array (the variable "a" is an array of 1,000,000 unique strings, and
/// "val" is the index to be checked):
///
///     a.indices.contains(val)
/// vs:
///     val > 0 && val < (a.count - 1)
//
/// Each test checks the validity of 2,192 different integers, using one of the two
/// methods. The end result is that both ways are fast and any difference is extremely
/// marginal. Therfore, I will use the first (IMO less puke-looking) method henceforth.
///
/// Related SO discussion: http://stackoverflow.com/a/35512668/164017

class WastingTimeOnStackOverflowTests: XCTestCase {
    
    
    func makeArray(_ count: Int) -> [String] {
        var a: [String] = []
        for _ in 0..<count {
            a.append(UUID().uuidString)
        }
        return a;
    }
    
    func test_performance_of_array_indices_contains() {
        
        let a = makeArray(1_000_000)
        var results: [Bool] = []
        
        self.measure {
            
            for val in self.testValues {
                
                let indexIsValid = a.indices.contains(val)
                results.append(indexIsValid)
            }
        }
    }
    
    func test_performance_of_manual_index_check() {
        
        let a = makeArray(1_000_000)
        var results: [Bool] = []
        
        self.measure {
            
            for val in self.testValues {
                
                let indexIsValid = val > 0 && val < (a.count - 1)
                results.append(indexIsValid)
            }
        }
    }
    
    // The testValues array contains 2192 integers:
    let testValues  = [8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, 8, 6, 7, 5, 3, 0, 9, 483989, 100_000_000, 453453, 43, 34535, 6456566, 234433242, ]
    
}
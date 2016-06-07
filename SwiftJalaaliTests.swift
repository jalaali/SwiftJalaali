//
//  SwiftJalaaliTests.swift
//  SwiftJalaaliTests
//
//  Created by Behrang Noruzi Niya on 3/18/1395 AP.
//
//

import XCTest
@testable import SwiftJalaali

class SwiftJalaaliTests: XCTestCase {
  
  let n = 100_000
  
  func testToJalaali() {
    XCTAssert(toJalaali(1981, 8, 17) == (1360, 5, 26))
    XCTAssert(toJalaali(2013, 1, 10) == (1391, 10, 21))
    XCTAssert(toJalaali(2014, 9, 8) == (1393, 6, 17))
  }
  
  func testToGregorian() {
    XCTAssert(toGregorian(1360, 5, 26) == (1981, 8, 17))
    XCTAssert(toGregorian(1391, 10, 21) == (2013, 1, 10))
    XCTAssert(toGregorian(1393, 6, 17) == (2014, 9, 8))
  }
  
  func testIsValidJalaaliDate() {
    XCTAssert(!isValidJalaaliDate(-62, 12, 29))
    XCTAssert(!isValidJalaaliDate(-62, 12, 29))
    XCTAssert(isValidJalaaliDate(-61, 1, 1))
    XCTAssert(!isValidJalaaliDate(3178, 1, 1))
    XCTAssert(isValidJalaaliDate(3177, 12, 29))
    XCTAssert(!isValidJalaaliDate(1393, 0, 1))
    XCTAssert(!isValidJalaaliDate(1393, 13, 1))
    XCTAssert(!isValidJalaaliDate(1393, 1, 0))
    XCTAssert(!isValidJalaaliDate(1393, 1, 32))
    XCTAssert(isValidJalaaliDate(1393, 1, 31))
    XCTAssert(!isValidJalaaliDate(1393, 11, 31))
    XCTAssert(isValidJalaaliDate(1393, 11, 30))
    XCTAssert(!isValidJalaaliDate(1393, 12, 30))
    XCTAssert(isValidJalaaliDate(1393, 12, 29))
    XCTAssert(isValidJalaaliDate(1395, 12, 30))
  }
  
  func testIsLeapJalaaliYear() {
    XCTAssert(!isLeapJalaaliYear(1393))
    XCTAssert(!isLeapJalaaliYear(1394))
    XCTAssert(isLeapJalaaliYear(1395))
    XCTAssert(!isLeapJalaaliYear(1396))
  }
  
  func testLastDayOfJalaaliMonth() {
    XCTAssert(lastDayOfJalaaliMonth(1393, 1) == 31)
    XCTAssert(lastDayOfJalaaliMonth(1393, 4) == 31)
    XCTAssert(lastDayOfJalaaliMonth(1393, 6) == 31)
    XCTAssert(lastDayOfJalaaliMonth(1393, 7) == 30)
    XCTAssert(lastDayOfJalaaliMonth(1393, 10) == 30)
    XCTAssert(lastDayOfJalaaliMonth(1393, 12) == 29)
    XCTAssert(lastDayOfJalaaliMonth(1394, 12) == 29)
    XCTAssert(lastDayOfJalaaliMonth(1395, 12) == 30)
  }
  
  func testToJalaaliBench() {
    self.measureBlock({
      var count = self.n
      while true {
        for y in 560...3560 {
          for m in 1...12 {
            for d in 1...30 {
              toJalaali(y, m, d)
              count -= 1
              if count == 0 {
                return
              }
            }
          }
        }
      }
    })
  }
  
  func testToGregorianBench() {
    self.measureBlock({
      var count = self.n
      while true {
        for y in 1...3000 {
          for m in 1...12 {
            for d in 1...30 {
              toGregorian(y, m, d)
              count -= 1
              if count == 0 {
                return
              }
            }
          }
        }
      }
    })
  }
  
  func testIsLeapJalaaliYearBench() {
    self.measureBlock({
      var count = self.n
      while true {
        for y in 1...3000 {
          isLeapJalaaliYear(y)
          count -= 1
          if count == 0 {
            return
          }
        }
      }
    })
  }
  
  func testIsValidJalaaliDateBench() {
    self.measureBlock({
      var count = self.n
      while true {
        for y in 1...3000 {
          for m in 1...13 {
            for d in 1...32 {
              isValidJalaaliDate(y, m, d)
              count -= 1
              if count == 0 {
                return
              }
            }
          }
        }
      }
    })
  }
  
}

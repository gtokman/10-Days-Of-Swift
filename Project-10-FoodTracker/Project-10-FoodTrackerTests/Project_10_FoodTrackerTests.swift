//
//  Project_10_FoodTrackerTests.swift
//  Project-10-FoodTrackerTests
//
//  Created by g tokman on 4/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//
// Unit tests are used for testing small, self-contained pieces of code to make sure they behave correctly.

import XCTest
@testable import Project_10_FoodTracker

class Project_10_FoodTrackerTests: XCTestCase {

	// MARK: - FoodTracker Tests

	// Tests to confirm that the Meal initializer returns when no name or a negative rating is provided
	func testMealInitialization() {
		// Success case.
		let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
		XCTAssertNotNil(potentialItem)

		// Failure cases.
		let noName = Meal(name: "", photo: nil, rating: 0)
		XCTAssertNil(noName, "Empty name is invalid")

		let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
		XCTAssertNil(badRating, "Negative ratings are invalid, be positive!")
	}
}

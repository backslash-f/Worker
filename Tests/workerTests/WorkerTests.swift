import XCTest
@testable import Worker

final class WorkerTests: XCTestCase {

    // MARK: - Public Properties

    static var allTests = [
        ("testCodeRunInMainThread", testCodeRunInMainThread),
        ("testCodeRunInBackgroundThread", testCodeRunInBackgroundThread),
        ("testCodeRunInMainThreadFromBackgroundThread", testCodeRunInMainThreadFromBackgroundThread)
    ]

    // MARK: - Private Properties

    private var mainThreadExpectation: XCTestExpectation!
    private var backgroundThreadExpectation: XCTestExpectation!

    // MARK: - Lifecycle

    override func setUp() {
        setupExpectations()
    }
}

// MARK: - Tests

extension WorkerTests {

    func testCodeRunInMainThread() {
        backgroundThreadExpectation.isInverted = true
        Worker.doMainThreadWork { [weak self] in
            self?.fulfillMainThreadExpectation()
            self?.fulfillBackgroundThreadExpectation()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCodeRunInBackgroundThread() {
        mainThreadExpectation.isInverted = true
        Worker.doBackgroundWork { [weak self] in
            self?.fulfillBackgroundThreadExpectation()
            self?.fulfillMainThreadExpectation()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testCodeRunInMainThreadFromBackgroundThread() {
        Worker.doBackgroundWork { [weak self] in
            self?.fulfillBackgroundThreadExpectation()
            Worker.doMainThreadWork {
                self?.fulfillMainThreadExpectation()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}

// MARK: - Private

private extension WorkerTests {

    func setupExpectations() {
        mainThreadExpectation = expectation(description: "Code executed in the main thread.")
        backgroundThreadExpectation = expectation(description: "Code executed in a background thread.")
    }

    func fulfillMainThreadExpectation() {
        if Thread.isMainThread {
            mainThreadExpectation.fulfill()
        }
    }

    func fulfillBackgroundThreadExpectation() {
        if !Thread.isMainThread {
            backgroundThreadExpectation.fulfill()
        }
    }
}

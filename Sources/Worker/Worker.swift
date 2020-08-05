import Foundation

/// Executes code in background threads or in the main thread.
public struct Worker {

    /// Runs code in the main thread asynchronously (`DispatchQueue.asyncAfter...` or `DispatchQueue.async...`).
    ///
    /// - Parameter mainThreadWork: The code block to be executed in the main thread.
    public static func doMainThreadWork(after time: Double? = nil, mainThreadWork: @escaping () -> Void) {
        if let givenTime = time {
            DispatchQueue.main.asyncAfter(deadline: .now() + givenTime) {
                mainThreadWork()
            }
        } else {
            DispatchQueue.main.async {
                mainThreadWork()
            }
        }
    }

    /// Runs code in a background thread asynchronously (`DispatchQueue.asyncAfter...` or `DispatchQueue.async...`. using
    /// (`.userInitiated`) quality-of-service.
    ///
    /// - Parameter backgroundWork: The code block to be executed in the background thread.
    public static func doBackgroundWork(after time: Double? = nil, backgroundWork: @escaping () -> Void) {
        if let givenTime = time {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + givenTime) {
                backgroundWork()
            }
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                backgroundWork()
            }
        }
    }
}

import Foundation

/// Executes code in background threads or in the main thread.
public struct Worker {

    /// Runs code in a background thread (`.userInitiated`) asynchronously.
    ///
    /// - Parameter backgroundWork: The code block to be executed in the background thread.
    public static func doBackgroundWork(_ backgroundWork: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            backgroundWork()
        }
    }

    /// Runs code in the main thread asynchronously (`DispatchQueue.main.async`).
    ///
    /// - Parameter mainThreadWork: The code block to be executed in the main thread.
    public static func doMainThreadWork(_ mainThreadWork: @escaping () -> Void) {
        DispatchQueue.main.async {
            mainThreadWork()
        }
    }
}

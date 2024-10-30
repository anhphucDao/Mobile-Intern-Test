import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue

    @Published var isConnected: Bool = true

    init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitor")

        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
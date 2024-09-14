//
//  Logger.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
enum LogLevel : String {
    case debug = "Debug"
    case info = "Info"
    case warning = "Warning"
    case error = "Error"
}

final class Logger {
    
    private init() {}
    static let sharedInstance = Logger()
    
    private let concurrentQueue = DispatchQueue(label: "concurrentQueue",
                                                attributes: .concurrent)
    private var logEvents: [String: Any] = [:]
    
    func log(key: String = UUID().uuidString, message: String, logLevel : LogLevel = .info) {
        concurrentQueue.asyncAndWait(flags: .barrier, execute: {
            let timestamp = DateFormatter.localizedString(from: Date(),
                                                          dateStyle: .short, timeStyle: .long)
            logEvents[key] = message
            debugPrint("\(timestamp) \(logLevel.rawValue) \(message)")
        })
    }
    func readValue(key: String) -> String? {
        var value: String?
        concurrentQueue.sync {
            value = logEvents[key] as? String
        }
        return value
    }
}

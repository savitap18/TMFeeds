//
//  Logger.swift
//  TMFeeds
//
//  Created by Savi on 10/11/20.
//

import Foundation
public class Logger {
    static func log(message: String) {
        #if DEBUG
        print(message)
        #endif
    }
}

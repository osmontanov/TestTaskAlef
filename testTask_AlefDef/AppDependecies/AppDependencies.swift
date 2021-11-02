//
//  AppDependencies.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 2/11/21.
//

import Foundation
import Swinject


class AppDependencies {
    
    static let shared = AppDependencies()
    let container = Container()
    
    private init() {
        setupDependencies()
    }
    
    private func setupDependencies() {
        container.register(InfoStorageProtocol.self) { r in
            return InfoStorageManager()
        }
    }
}

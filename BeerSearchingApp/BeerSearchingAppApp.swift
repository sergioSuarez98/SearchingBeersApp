//
//  BeerSearchingAppApp.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import SwiftUI

@main
struct BeerSearchingAppApp: App {
    var body: some Scene {
        WindowGroup {
            BeerCoordinator.buildView()
        }
    }
}

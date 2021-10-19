//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Dhruva Srinivas on 17/10/21.
//

import SwiftUI

// View's entry-point
@main
struct TicTacToeApp: App {
    private let game: GameHandler = GameHandler()
    
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}

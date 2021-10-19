//
//  GameHandler.swift
//  TicTacToe
//
//  Created by Dhruva Srinivas on 17/10/21.
//

import SwiftUI

class GameHandler: ObservableObject {
    typealias Square = TicTacToeGame.Square
    
    public static func createTTTGame() -> TicTacToeGame {
        return TicTacToeGame()
    }
    
    @Published private var model: TicTacToeGame = createTTTGame()
    
    var squares: Array<Square> {
        return model.squares
    }
    
    var winner: String {
        return model.winner
    }
    
    // MARK: Intents
    func choose(_ square: TicTacToeGame.Square) {
        model.choose(index: square.id, isPlayer: true)
    }
    
    func createGame() {
        model = GameHandler.createTTTGame()
    }
}

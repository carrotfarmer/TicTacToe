//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Dhruva Srinivas on 17/10/21.
//

import Foundation

struct TicTacToeGame {
    private(set) var squares: Array<Square>
    private var previousPlayer: String = "none"
    private(set) var winner: String = "none"
    private var areAllSquaresOccupied: Bool {
        var res: Bool = false
        var arr: Array<Square> = Array<Square>()
        
        for square in squares {
            if square.isEmpty == false {
                arr.append(square)
            }
        }
        
        if arr.count == squares.count {
            res = true
        }
        
        return res
    }
    
    var remainingSquares: Array<Square> {
        var remaining: Array<Square> = Array<Square>()
        for square in squares {
            if square.isEmpty {
                remaining.append(square)
            }
        }
        
        return remaining
    }
    
    func checkDiagonals(squares: Array<Square>) -> Bool {
        var isWin: Bool = false
        if (squares[0].content == squares[4].content && squares[4].content == squares[8].content && squares[8].content == squares[0].content) {
           isWin = true
        } else if (squares[2].content == squares[4].content && squares[4].content == squares[6].content && squares[6].content == squares[2].content) {
            isWin = true
        }

        return isWin
    }

    func checkVerticals(squares: Array<Square>) -> Bool {
        var isWin: Bool = false

        if (squares[0].content == squares[3].content && squares[3].content == squares[6].content && squares[6].content == squares[0].content) && (squares[0].content != "_") {
            isWin = true
        } else if (squares[1].content == squares[4].content && squares[4].content == squares[7].content && squares[7].content == squares[1].content) {
            isWin = true
        } else if (squares[2].content == squares[5].content && squares[5].content == squares[8].content && squares[8].content == squares[2].content) {
            isWin = true
        }

        return isWin
    }

    func checkHorizontals(squares: Array<Square>) -> Bool {
        var isWin: Bool = false

        if (squares[0].content == squares[1].content && squares[1].content == squares[2].content && squares[2].content == squares[0].content) {
            isWin = true
        } else if (squares[3].content == squares[4].content && squares[4].content == squares[5].content && squares[5].content == squares[3].content) {
            isWin = true
        } else if (squares[6].content == squares[7].content && squares[7].content == squares[8].content && squares[8].content == squares[6].content) {
            isWin = true
        }

        return isWin
    }
    
    mutating func makeComputerMove() -> Void {
        if !remainingSquares.isEmpty {
            let randomSquare: Square = remainingSquares.randomElement()!
            
            for index in 0..<squares.count {
                if randomSquare.id == squares[index].id {
                    squares[index].isPlayable = false
                    squares[index].isEmpty = false
                    squares[index].content = "O"
                    squares[index].color = "red"
                }
            }
            
            let horizontals: Bool = checkHorizontals(squares: squares)
            let verticals: Bool = checkVerticals(squares: squares)
            let diagonals: Bool = checkDiagonals(squares: squares)
            var isGameOver: Bool = false
            
            previousPlayer = "O"
            if horizontals || verticals || diagonals {
                isGameOver = true
                winner = previousPlayer
            }
            
            if areAllSquaresOccupied && winner == "none" {
                winner = "draw"
            }
            
            if isGameOver {
                for index in 0..<squares.count {
                    squares[index].isPlayable = false
                    squares[index].isEmpty = false
                }
            }
        }
    }
    
    mutating func choose(index: Int, isPlayer: Bool) -> Void {
        var sqrContent: String = "_"
        var isGameOver: Bool = false

        
        var squaresThatAreEmpty = [Square]()
        for square in squares {
            if square.isEmpty == true {
                squaresThatAreEmpty.append(square)
            }
        }
        
        if squaresThatAreEmpty.count == 0 {
            isGameOver = true
        }
        
        if isPlayer {
            sqrContent = "X"
            previousPlayer = "X"
        }
        
        squares[index].isPlayable = false
        squares[index].isEmpty = false
        squares[index].content = sqrContent
        
        let horizontals: Bool = checkHorizontals(squares: squares)
        let verticals: Bool = checkVerticals(squares: squares)
        let diagonals: Bool = checkDiagonals(squares: squares)
        
        if horizontals || verticals || diagonals {
            isGameOver = true
            winner = previousPlayer
        }
        
        if areAllSquaresOccupied && winner == "none" {
            winner = "draw"
        }
        
        if !isGameOver && !remainingSquares.isEmpty {
            makeComputerMove()
        }
        
        if isGameOver {
            for index in 0..<squares.count {
                squares[index].isPlayable = false
                squares[index].isEmpty = false
            }
        }
        print(winner)
    }
    
    
    init() {
        squares = Array<Square>()
        
        for index in 0..<9 {
            squares.append(Square(content: String(index), id: index, color: "black"))
        }
    }
    
    struct Square: Identifiable, Equatable {
        var isEmpty = true
        var content: String
        var isPlayable: Bool = true
        let id: Int
        var color: String
    }
}

// MARK: Example Board Array
// [
//    x, o, x
//    x, o, x,
//    x, o, x,
// ]

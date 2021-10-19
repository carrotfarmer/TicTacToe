//
//  ContentView.swift
//  TicTacToe
//
//  Created by Dhruva Srinivas on 17/10/21.
//

import SwiftUI

// Constants used for the magic numbers used in the UI
struct DrawingConstants {
    static let cornerRadius: CGFloat = 10
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.7
    static let squareWidth: CGFloat = 100
    static let squareHeight: CGFloat = 150
    static let fgHue: CGFloat = 0.756
    static let fgSaturation:CGFloat = 0.047
    static let fgBrightness: CGFloat = 0.858
    static let buttonWidth: CGFloat = 200
    static let buttonHeight: CGFloat = 75
    static let buttonOpacity: CGFloat = 0.5
}

struct ContentView: View {
    @ObservedObject var game: GameHandler
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .bold()
                .font(.title2)
            Text(getText(game: game))
                .font(.system(size: 35, design: .monospaced))
                .foregroundColor(.blue)
                .bold()
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(game.squares) { square in
                    SquareView(square: square)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            if square.isPlayable {
                                game.choose(square)
                            }
                        }
                }
            }
            Spacer()
            Button(action: {
                game.createGame()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                        .fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                        .opacity(DrawingConstants.buttonOpacity)
                        .frame(width: DrawingConstants.buttonWidth, height: DrawingConstants.buttonHeight)
                    Text("New Game")
                        .font(.headline)
                        .foregroundColor(Color.black)
                }
            })
            Spacer()
        }.padding(.horizontal)
    }
    
    private func getText(game: GameHandler) -> String {
        var finalText: String = "none"
        
        if game.winner == "none" {
            finalText = ""
        }
        if game.winner == "X" || game.winner == "O" {
            finalText = "Game Over! Winner: \(game.winner)"
        }
        if game.winner == "draw" {
            finalText = "It was a draw!"
        }
        
        return finalText
    }
}

struct SquareView: View {
    let square: TicTacToeGame.Square
    func getSqrContent() -> String {
        var sqrContent: String = ""
        if square.content != "X" && square.content != "O" {
            sqrContent = "_"
        } else {
            sqrContent = square.content
        }
        
        return sqrContent
    }
    
    var body: some View {
        let sqrContent: String = getSqrContent()
        GeometryReader(content: { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(Color(hue: DrawingConstants.fgHue, saturation: DrawingConstants.fgSaturation, brightness: DrawingConstants.fgBrightness))
                    .foregroundColor(getColor(color: square.color))
                    .frame(width: DrawingConstants.squareWidth, height: DrawingConstants.squareHeight)
                
                Text(sqrContent).font(font(in: geometry.size))
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private func getColor(color: String) -> Color {
        var newColor: Color
        
        switch color {
        case "black":
            newColor = Color.black
        case "red":
            newColor = Color.red
        default:
            newColor = Color.black
        }
        
        return newColor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game: GameHandler = GameHandler()
        ContentView(game: game)
    }
}

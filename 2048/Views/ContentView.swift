//
//  ContentView.swift
//  2048
//
//  Created by Denis Fouchard on 04/06/2025.
//

import SwiftUI


struct ContentView: View {
    @StateObject var model : GridModel
    @StateObject var scoreManager : ScoreManager = ScoreManager()
    @State var gameOver = false
    
    @ViewBuilder
    func gameOverOverlay() -> some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Button("Restart") {
                    model.reset()
                    gameOver = false
                }.buttonStyle(TileButtonStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }

    var body: some View {
        VStack {
            Spacer(minLength: 10)
            HStack{
                Text("2048")
                    .font(.custom("Helvetica", size: 70))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    
                
                Spacer()
                ScoreView(title: "Score", model: model)
                BestScoreView(title:"Best Score", scoreManager: scoreManager)
                
                
                
            }.padding()
            Spacer(minLength: 10)
            HStack{
                Text("Join the numbers and get to 2048 tile !")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
        
                Button(action: {
                    model.reset()
                    gameOver = false
                }) {
                    Text("New Game")
                        .font(.title2)
                        .foregroundColor(.white)
                       .padding(8)
                    
                }
                .buttonStyle(TileButtonStyle()
                    )
            }.padding()
            
            Spacer(minLength: 10)
            
            KeyEventHandlingView(onKeyDown: handleKey)
            TileGridView(model: model).overlay(gameOverOverlay().opacity(gameOver ? 1 : 0))
                .frame(minWidth: 410, minHeight: 410)  // minimum size to avoid shrinking too much
                .aspectRatio(1, contentMode: .fit)
            
            Spacer(minLength: 20)
            
    
        }

        .frame(width:430, height:630)
    }
    
    func handleKey(_ event: NSEvent) {
            switch event.keyCode {
            case 123: gameOver = model.moveLeft()
            case 124: gameOver = model.moveRight()
            case 125: gameOver = model.moveDown()
            case 126: gameOver = model.moveUp()
            default: gameOver = false
            }
        scoreManager.updateIfBetter(model.score)
        }
}

#Preview {
    ContentView(model:GridModel(test: true))
}

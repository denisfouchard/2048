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
                }.buttonStyle(TileButtonStyle())
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func winOverlay() -> some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack {
                Text("Congratulations !")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Button("Restart") {
                    model.reset()
                }.buttonStyle(TileButtonStyle())
                .padding()
                Button("Continue playing") {
                    model.gameState = GameState.playing
                    
                }.buttonStyle(TileButtonStyle())
                .padding()
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
            TileGridView(model: model)
                .overlay(gameOverOverlay().opacity(model.gameState == GameState.loose ? 1 : 0))
                .overlay(winOverlay().opacity(model.gameState == GameState.win ? 1 : 0))
                .frame(minWidth: 410, minHeight: 410)  // minimum size to avoid shrinking too much
                .aspectRatio(1, contentMode: .fit)
            
            Spacer(minLength: 20)
            
    
        }

        .frame(width:430, height:630)
    }
    
    func handleKey(_ event: NSEvent) {
        if (model.gameState == GameState.playing){
            switch event.keyCode {
            case 123:  model.moveLeft()
            case 124:  model.moveRight()
            case 125:  model.moveDown()
            case 126:  model.moveUp()
            default:  GameState.playing
            }
            scoreManager.updateIfBetter(model.score)
        }
    }
}

#Preview {
    ContentView(model:GridModel(test: true))
}

//
//  Grid.swift
//  2048
//
//  Created by Denis Fouchard on 04/06/2025.
//

import Foundation

func getColumn(matrix: [[Int]], index i: Int) -> [Int] {
    return matrix.map { $0[i] }
}

func setColumn(matrix: inout [[Int]], index i: Int, newColumn: [Int]) {
    for row in 0..<matrix.count {
        matrix[row][i] = newColumn[row]
    }
}

class GridModel : ObservableObject {
    @Published var score : Int
    @Published var gridMatrix : Array<Array<Int>>
    var dimensions: (rows: Int, cols: Int)
    
    init(test:Bool) {
        // Initialize with zeros
        let matrix: [[Int]]
        let _score : Int
            if test {
                matrix = [
                    [0, 0, 2, 0],
                    [0, 2, 4, 0],
                    [0, 0, 8, 2048],
                    [0, 0, 16, 4096]
                ]
                _score = 69
            } else {
                matrix = GridModel.createMatrix()
                _score = 0
            }
            
            self.gridMatrix = matrix
            self.dimensions = (rows:matrix.count, cols:matrix[0].count)
            self.score = _score
        }
        
        
    
    
    func reset() {
        self.gridMatrix = GridModel.createMatrix()
        self.score = 0
    }
    
    private func updateTiles(tilesInRow : [Int]) ->[Int]{
        if tilesInRow.count == 0 {return tilesInRow}
        
        var tilesInRow = tilesInRow
        if (tilesInRow.count >= 2) {
            var i = tilesInRow.count - 1
            while i > 0 {
                if (tilesInRow[i] == tilesInRow[i-1]){
                    tilesInRow[i-1] = tilesInRow[i-1] * 2
                    tilesInRow.remove(at: i)
                    return tilesInRow
                }
                else {
                    i-=1
                }
            }
                
        }
        self.score = self.score + 2
        return tilesInRow
    }
    
    func moveLeft() -> Bool {
        var gameOver = false
        var numTilesPerRow = [0,0,0,0]
        for i in 0..<4 {
            let row = self.gridMatrix[i]
            var tilesInRow = [] as [Int]
            for tile in row{
                if (tile != 0){
                    tilesInRow.append(tile)
                }
            }
            
            tilesInRow = updateTiles(tilesInRow: tilesInRow)
            var newRow = Array(repeating: 0, count: 4)
            for (j, el) in tilesInRow.enumerated() {
                newRow[j] = el
            }
            numTilesPerRow[i] = tilesInRow.count
            self.gridMatrix[i] = newRow
            
        }
        // Add new tile to an available row
        let availableRows = numTilesPerRow.enumerated().compactMap { (index, value) in
            value < 4 ? index : nil
        }
        
        if availableRows.isEmpty {
            gameOver = true
            return gameOver
        }
        let rowToAdd = availableRows.randomElement()
        self.gridMatrix[rowToAdd!][3] = (Float.random(in: 0...1) > 0.8 ? 4: 2) // 20% chance of getting a 4
        
        
        return gameOver
        
    }
    
    func moveRight() -> Bool {
        var gameOver = false
        var numTilesPerRow = [0,0,0,0]
        for i in 0..<4 {
            let row = self.gridMatrix[i]
            var tilesInRow = [] as [Int]
            for tile in row{
                if (tile != 0){
                    tilesInRow.append(tile)
                }
            }
            
            tilesInRow = updateTiles(tilesInRow: tilesInRow)
            var newRow = Array(repeating: 0, count: 4)
            for (j, el) in tilesInRow.enumerated() {
                newRow[4 - tilesInRow.count  + j ] = el
            }
            numTilesPerRow[i] = tilesInRow.count
            self.gridMatrix[i] = newRow
            
        }
        // Add new tile to an available row
        let availableRows = numTilesPerRow.enumerated().compactMap { (index, value) in
            value < 4 ? index : nil
        }
        
        if availableRows.isEmpty {
            gameOver = true
            return gameOver
        }
        let rowToAdd = availableRows.randomElement()
        self.gridMatrix[rowToAdd!][0] = (Float.random(in: 0...1) > 0.8 ? 4: 2) // 20% chance of getting a 4
        
        
        return gameOver
        
    }
    
    func moveDown() -> Bool {
        var gameOver = false
        var numTilesPerCol = [0,0,0,0]
        for i in 0..<4 {
            let col = getColumn(matrix: self.gridMatrix, index: i)
            var tilesInCol = [] as [Int]
            for tile in col{
                if (tile != 0){
                    tilesInCol.append(tile)
                }
            }
            
            tilesInCol = updateTiles(tilesInRow: tilesInCol)
            var newCol = Array(repeating: 0, count: 4)
            for (j, el) in tilesInCol.enumerated() {
                newCol[4 - tilesInCol.count  + j ] = el
            }
            numTilesPerCol[i] = tilesInCol.count
            setColumn(matrix: &self.gridMatrix, index:i, newColumn:newCol)
            
        }
        // Add new tile to an available row
        let availableCols = numTilesPerCol.enumerated().compactMap { (index, value) in
            value < 4 ? index : nil
        }
        
        if availableCols.isEmpty {
            gameOver = true
            return gameOver
        }
        let colToAdd = availableCols.randomElement()
        self.gridMatrix[0][colToAdd!] = (Float.random(in: 0...1) > 0.8 ? 4: 2) // 20% chance of getting a 4
        
        
        return gameOver
        
    }
    
    func moveUp() -> Bool {
        var gameOver = false
        var numTilesPerCol = [0,0,0,0]
        for i in 0..<4 {
            let col = getColumn(matrix: self.gridMatrix, index: i)
            var tilesInCol = [] as [Int]
            for tile in col{
                if (tile != 0){
                    tilesInCol.append(tile)
                }
            }
            
            tilesInCol = updateTiles(tilesInRow: tilesInCol)
            var newCol = Array(repeating: 0, count: 4)
            for (j, el) in tilesInCol.enumerated() {
                newCol[j] = el
            }
            numTilesPerCol[i] = tilesInCol.count
            setColumn(matrix: &self.gridMatrix, index:i, newColumn:newCol)
            
        }
        // Add new tile to an available row
        let availableCols = numTilesPerCol.enumerated().compactMap { (index, value) in
            value < 4 ? index : nil
        }
        
        if availableCols.isEmpty {
            gameOver = true
            return gameOver
        }
        let colToAdd = availableCols.randomElement()
        self.gridMatrix[3][colToAdd!] = (Float.random(in: 0...1) > 0.8 ? 4: 2) // 20% chance of getting a 4
        
        
        return gameOver
        
    }
    
    static func createMatrix() -> Array<Array<Int>> {
        var gridmatrix = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        gridmatrix[2][2] = 2
        return gridmatrix
    }
    

        
     
    
}



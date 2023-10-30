//
//  Ghost.swift
//  PackMan
//
//  Created by Даниил Крымлов on 26.10.2023.
//

import Foundation

struct Position: Equatable, Hashable {
    var row: Int
    var column: Int
}
struct Ghost{
    var column : Int
    var row : Int
    var image : String = "ghost"
    
    mutating func moveGreedy(field : inout Map, packMan : inout PackMan){
        
        let packManPosition : Position = Position(row: packMan.row, column: packMan.column)
        let bestMove = getBestMoveGreedy(field: field, pacmanPosition: packManPosition)
        
        field.canvas[self.row][self.column] = 0
        let rowBefore = self.row
        let columnBefore = self.column
        
        self.row = bestMove.row
        self.column = bestMove.column
        
        if field.canvas[self.row][self.column] == 2{
            field.canvas[self.row][self.column] = 3
            field.canvas[rowBefore][columnBefore] = 2
        }else {
            field.canvas[self.row][self.column] = 3
        }
        
        
        if packManPosition.row == bestMove.row && packManPosition.column == bestMove.column {
            packMan.facedGhost(field: &field)
        }
        
    }

    
    
    mutating func getBestMoveGreedy(field: Map, pacmanPosition: Position) -> Position {
        // Определяем возможные направления движения для призрака
            let possibleMoves: [Position] = [
                Position(row: -1, column: 0),  // Вверх
                Position(row: 1, column: 0),   // Вниз
                Position(row: 0, column: -1),  // Влево
                Position(row: 0, column: 1)    // Вправо
            ]

        var bestMove = Position(row: self.row, column: self.column)
            var minDistance = Int.max

            // Проверяем, находятся ли призрак и Пакман в соседних позициях
        if abs(self.row - pacmanPosition.row) + abs(self.column - pacmanPosition.column) == 1 {
                // Если они соседние, призрак въезжает в Пакмана
                return pacmanPosition
            } else {
                // Если не соседние, выбираем наилучшее направление для призрака
                for move in possibleMoves {
                    let newPosition = Position(row: self.row + move.row, column: self.column + move.column)

                    // Проверяем, что новая позиция находится в пределах игрового поля
                    if newPosition.row >= 0 && newPosition.row < field.canvas.count &&
                       newPosition.column >= 0 && newPosition.column < field.canvas[0].count {
                        // Проверяем, что новая позиция пуста (не стена и не Пакман)
                        if field.canvas[newPosition.row][newPosition.column] != 1 &&
                            field.canvas[newPosition.row][newPosition.column] != 4 {
                            // Рассчитываем расстояние между новой позицией призрака и Пакманом
                            let distance = abs(newPosition.row - pacmanPosition.row) + abs(newPosition.column - pacmanPosition.column)
                            if distance < minDistance {
                                minDistance = distance
                                bestMove = newPosition
                            }
                        }
                    }
                }
            }

            return bestMove
    }
    
//    struct Move{
//        var direction : Direction
//        var points : Int
//    }
//    
//    mutating func changeDirection(newDirection : Direction){
//        self.direction = newDirection
//    }
//    
//    
//    mutating func move(field : inout Map){
//        
//        if self.direction == .UP && checkMove(field: field, direction: .UP){
//            field.canvas[self.row][self.column] = 0
//            field.canvas[self.row - 1][self.column] = 3
//            self.row -= 1
//        }else if self.direction == .DOWN && checkMove(field: field, direction: .DOWN){
//            field.canvas[self.row][self.column] = 0
//            field.canvas[self.row + 1][self.column] = 3
//            self.row += 1
//        }else if self.direction == .RIGHT && checkMove(field: field, direction: .RIGHT){
//            field.canvas[self.row][self.column] = 0
//            field.canvas[self.row][self.column + 1] = 3
//            self.column += 1
//        }else if self.direction == .LEFT && checkMove(field: field, direction: .LEFT){
//            field.canvas[self.row][self.column] = 0
//            field.canvas[self.row][self.column - 1] = 3
//            self.column -= 1
//        }
//        
//    }
//    
//    func moveTowardsPackMan(packMan : PackMan, field : inout Map){
//        
//        
//        
//    }
//    
//    func checkMove(field : Map, direction : Direction) -> Bool{
//        if direction == .UP{
//            if field.canvas[self.row - 1][self.column] == 1{
//                return false
//            }
//        }
//        if direction == .DOWN{
//            if field.canvas[self.row + 1][self.column] == 1{
//                return false
//            }
//        }
//        if direction == .RIGHT{
//            if field.canvas[self.row][self.column + 1] == 1{
//                return false
//            }
//        }
//        if direction == .LEFT{
//            if field.canvas[self.row][self.column - 1] == 1{
//                return false
//            }
//        }
//        return true
//    }
    
//    mutating func move(field : inout Map, packMan : PackMan){
//        
//        var bestMove : Move = getMove(packManRow: packMan.row, packManColumn: packMan.column, field: field)
//        field.canvas[self.row][self.column] = 0
//        
//        if bestMove.direction == .UP {
//            field.canvas[self.row - 1][self.column] = 3
//            row -= 1
//        }else if bestMove.direction == .DOWN {
//            field.canvas[self.row + 1][self.column] = 3
//            row += 1
//        }else if bestMove.direction == .RIGHT {
//            field.canvas[self.row][self.column + 1] = 3
//            column += 1
//        }else if bestMove.direction == .LEFT {
//            field.canvas[self.row][self.column - 1] = 3
//            column -= 1
//        }
//        
//    }
//    
//    private func getMove(packManRow : Int, packManColumn: Int, field : Map) -> Move{
//        
//        var availableDirections = getAvailableDirections(field: field)
//        var bestMove : Move = Move(direction: .UP, points: 0)
//        var moves : [Move] = []
//        
//        for direction in availableDirections {
//            
//            if direction == .UP{
//                
//                let points = calculatePath(packManRow: packManRow, packManColumn: packManColumn, ghostRow: self.row - 1, ghostColumn: self.column)
//                moves.append(Move(direction: .UP, points: points))
//                
//            }else if direction == .DOWN{
//                
//                let points = calculatePath(packManRow: packManRow, packManColumn: packManColumn, ghostRow: self.row + 1, ghostColumn: self.column)
//                moves.append(Move(direction: .DOWN, points: points))
//                
//            }else if direction == .RIGHT{
//                
//                let points = calculatePath(packManRow: packManRow, packManColumn: packManColumn, ghostRow: self.row, ghostColumn: self.column - 1)
//                moves.append(Move(direction: .RIGHT, points: points))
//                
//            }else if direction == .LEFT{
//                
//                let points = calculatePath(packManRow: packManRow, packManColumn: packManColumn, ghostRow: self.row, ghostColumn: self.column + 1)
//                moves.append(Move(direction: .LEFT, points: points))
//                
//            }
//            
//        }
//        
//        for move in moves {
//            if bestMove.points < move.points {
//                bestMove = move
//            }
//        }
//        
//        return bestMove
//        
//    }
//    
//    func getAvailableDirections(field : Map) -> [Direction]{
//        
//        var directionsToMove : [Direction] = []
//        
//        if (field.canvas[row - 1][column] == 0 || field.canvas[row - 1][column] == 2){
//            directionsToMove.append(.UP)
//        }
//        if(field.canvas[row + 1][column] == 0 || field.canvas[row + 1][column] == 2){
//            directionsToMove.append(.DOWN)
//        }
//        if(field.canvas[row][column - 1] == 0 || field.canvas[row][column - 1] == 2){
//            directionsToMove.append(.RIGHT)
//        }
//        if(field.canvas[row][column + 1] == 0 || field.canvas[row][column + 1] == 2){
//            directionsToMove.append(.LEFT)
//        }
//        
//        return directionsToMove
//        
//        
//    }
//    
//    func calculatePath(packManRow : Int, packManColumn : Int, ghostRow : Int, ghostColumn : Int) -> Int {
//        if packManRow > ghostRow {
//            print("packManRow > ghost")
//            if packManColumn > ghostColumn {
//                print("packManCol > ghost")
//                print((packManRow - ghostRow) + (packManColumn - ghostColumn))
//                return (packManRow - ghostRow) + (packManColumn - ghostColumn)
//            }else {
//                print("packManCol < ghost")
//                print((packManRow - ghostRow) + (ghostColumn - packManColumn))
//                return (packManRow - ghostRow) + (ghostColumn - packManColumn)
//            }
//        }else if packManRow < ghostRow{
//            print("packManRow < ghost")
//            if packManColumn > ghostColumn {
//                print("packManCol > ghost")
//                print((ghostRow - packManRow) + (packManColumn - ghostColumn))
//                return (ghostRow - packManRow) + (packManColumn - ghostColumn)
//            }else {
//                print("packManCol < ghost")
//                print((ghostRow - packManRow) + (ghostColumn - packManColumn))
//                return (ghostRow - packManRow) + (ghostColumn - packManColumn)
//            }
//        }else {
//            print("packManRow == ghost")
//            if packManColumn > ghostColumn {
//                return (packManColumn - ghostColumn)
//            }else {
//                return (ghostColumn - packManColumn)
//            }
//        }
//    }
    
    
}

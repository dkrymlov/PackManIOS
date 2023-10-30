//
//  GameViewModel.swift
//  PackMan
//
//  Created by Даниил Крымлов on 02.10.2023.
//

import Foundation
import SwiftUI

enum Direction {
    case UP
    case DOWN
    case LEFT
    case RIGHT
}

class GameVM : ObservableObject{
    
    @Published private var packMan = PackMan(column: 12, row: 12)
    @Published private var ghost1 = Ghost(column: 6, row: 5)
    @Published private var ghost2 = Ghost(column: 21, row: 5)
    @Published private var ghost3 = Ghost(column: 16, row: 13)
    @Published private var field = gameMap
    
    var map : Map{
        return field
    }
    
    var player : PackMan{
        return packMan
    }
    
    var ghost1Computed : Ghost{
        return ghost1
    }
    
    var ghost2Computed : Ghost{
        return ghost2
    }
    
    func setLives(lives : Int){
        
    }
    
    func ghost1Move(){
        withAnimation(.easeInOut(duration: 0.1)){
            ghost1.moveGreedy(field: &field, packMan: &packMan)
        }
    }
    
    func ghost2Move(){
        withAnimation(.easeInOut(duration: 0.1)){
            ghost2.moveGreedy(field: &field, packMan: &packMan)
        }
    }
    
    func ghost3Move(){
        withAnimation(.easeInOut(duration: 0.1)){
            ghost3.moveGreedy(field: &field, packMan: &packMan)
        }
    }
    
    private func changePackManDirection(newDirection : Direction){
        packMan.changeDirection(newDirection: newDirection, field: field)
    }
    
    func calculateDirectionMove(value: DragGesture.Value){
        print(value.translation)
        switch(value.translation.width, value.translation.height) {
        case (...0, -30...30): do {
                changePackManDirection(newDirection: Direction.LEFT)
            //ghost1.changeDirection(newDirection: Direction.LEFT)
        }
        case (0..., -30...30):  do {
            changePackManDirection(newDirection: Direction.RIGHT)
            //ghost1.changeDirection(newDirection: Direction.RIGHT)
        }
        case (-100...100, ...0):  do {
            changePackManDirection(newDirection: Direction.UP)
            //ghost1.changeDirection(newDirection: Direction.UP)
        }
        case (-100...100, 0...):  do {
            changePackManDirection(newDirection: Direction.DOWN)
            //ghost1.changeDirection(newDirection: Direction.DOWN)
        }
        default:  print("no clue")
        }
    }
    
    func spawnPlayer(){
        field.canvas[packMan.row][packMan.column] = 4
    }
    
    func spawnGhost1(){
        field.canvas[ghost1.row][ghost1.column] = 3
    }
    
    func spawnGhost2(){
        field.canvas[ghost2.row][ghost2.column] = 3
    }
    
    func spawnGhost3(){
        field.canvas[ghost3.row][ghost3.column] = 3
    }
    
    func packManMove(){
        
        withAnimation(.snappy){
            packMan.move(field: &field)
        }
        
        
    }
    
}

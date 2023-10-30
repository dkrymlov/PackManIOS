//
//  PackMan.swift
//  PackMan
//
//  Created by Даниил Крымлов on 26.10.2023.
//

import Foundation

struct PackMan{
    var column : Int
    var row : Int
    var score : Int = 0
    var direction : Direction = Direction.UP
    var image : String = "packman_up"
    var alive : Bool = true
    var lives : Int = 0
    
    mutating func setLives(lives : Int){
        self.lives = lives
    }
    
    mutating func changeDirection(newDirection : Direction, field : Map){
        
        if self.direction == Direction.UP || self.direction == Direction.DOWN{
            if newDirection == Direction.RIGHT{
                if field.canvas[self.row][self.column + 1] == 0 || field.canvas[self.row][self.column + 1] == 2{
                    self.direction = newDirection
                    self.image = "packman_rt"
                }
            }else if newDirection == Direction.LEFT{
                if field.canvas[self.row][self.column - 1] == 0 || field.canvas[self.row][self.column - 1] == 2{
                    self.direction = newDirection
                    self.image = "packman_lt"
                }
            }
        }else if self.direction == Direction.RIGHT || self.direction == Direction.LEFT{
            if newDirection == Direction.UP{
                if field.canvas[self.row - 1][self.column] == 0 || field.canvas[self.row - 1][self.column] == 2{
                    self.direction = newDirection
                    self.image = "packman_up"
                }
            }else if newDirection == Direction.DOWN{
                if field.canvas[self.row + 1][self.column] == 0 || field.canvas[self.row + 1][self.column] == 2{
                    self.direction = newDirection
                    self.image = "packman_dw"
                }
            }
        }
        
    }
    
    private mutating func eat(){
        self.score += 1
    }
    
    private mutating func die(){
        self.alive = false
    }
    
    mutating func facedGhost(field : inout Map){
        
        if self.alive == true {
            if self.lives == 1 {
                self.lives -= 1
                field.canvas[self.row][self.column] = 0
                self.die()
            }else {
                field.canvas[self.row][self.column] = 0
                self.lives -= 1
                self.column = 13
                self.row = 13
            }
        }
        
    }
    
    mutating private func go(field : inout Map){

            if self.direction == Direction.UP{
                field.canvas[self.row][self.column] = 0
                field.canvas[self.row - 1][self.column] = 4
                self.row -= 1
            }else if self.direction == Direction.DOWN{
                field.canvas[self.row][self.column] = 0
                field.canvas[self.row + 1][self.column] = 4
                self.row += 1
            }else if self.direction == Direction.RIGHT{
                field.canvas[self.row][self.column] = 0
                field.canvas[self.row][self.column + 1] = 4
                self.column += 1
            }else if self.direction == Direction.LEFT{
                field.canvas[self.row][self.column] = 0
                field.canvas[self.row][self.column - 1] = 4
                self.column -= 1
            }
        
    }
    
    mutating private func stay(field : inout Map){
        field.canvas[self.row][self.column] = 4
    }
    
    mutating func move(field : inout Map){
        
        if alive {
            if self.direction == Direction.UP{
                if field.canvas[self.row - 1][self.column] == 1{
                    self.stay(field: &field)
                }else if field.canvas[self.row - 1][self.column] == 2 {
                    self.eat()
                    self.go(field: &field)
                }else if field.canvas[self.row - 1][self.column] == 3{
                    self.facedGhost(field: &field)
                }else {
                    self.go(field: &field)
                }
                
            }else if self.direction == Direction.DOWN{
                
                if field.canvas[self.row + 1][self.column] == 1{
                    self.stay(field: &field)
                }else if field.canvas[self.row + 1][self.column] == 2 {
                    self.eat()
                    self.go(field: &field)
                }else if field.canvas[self.row + 1][self.column] == 3{
                    self.facedGhost(field: &field)
                }else {
                    self.go(field: &field)
                }
            }else if self.direction == Direction.RIGHT{
                
                if field.canvas[self.row][self.column + 1] == 1{
                    self.stay(field: &field)
                }else if field.canvas[self.row][self.column + 1] == 2 {
                    self.eat()
                    self.go(field: &field)
                }else if field.canvas[self.row][self.column + 1] == 3{
                    self.facedGhost(field: &field)
                }else {
                    self.go(field: &field)
                }
                
            }else if self.direction == Direction.LEFT{
                
                if field.canvas[self.row][self.column - 1] == 1{
                    self.stay(field: &field)
                }else if field.canvas[self.row][self.column - 1] == 2{
                    self.eat()
                    self.go(field: &field)
                }else if field.canvas[self.row][self.column - 1] == 3{
                    self.facedGhost(field: &field)
                }else {
                    self.go(field: &field)
                }
            
            }
        }
        
    }
    
}

//
//  GameView.swift
//  PackMan
//
//  Created by Даниил Крымлов on 02.10.2023.
//

import SwiftUI
import Combine

struct GameView: View {
    
    @ObservedObject var viewModel : GameVM
    var tileWidth : CGFloat
    let timer : Publishers.Autoconnect<Timer.TimerPublisher>
    
    let speed : CGFloat
    let lives : Int
    let ghosts : Int
    
    init(speed: CGFloat, lives: Int, ghosts: Int) {
        self.viewModel = GameVM()
        self.tileWidth = UIScreen.main.bounds.width / 30
        self.speed = speed
        self.lives = lives
        self.ghosts = ghosts
        self.timer = Timer.publish(every: self.speed, on: .main, in: .common).autoconnect()
    }
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack(spacing: 0){
                ForEach(0..<viewModel.map.canvas.count){ index in
                    HStack(spacing: 0){
                        ForEach(0..<viewModel.map.canvas[index].count) { index2 in
                            
                            if viewModel.map.canvas[index][index2] == 0{
                                Rectangle().fill(.clear).frame(width: tileWidth, height: tileWidth)
                            }else if viewModel.map.canvas[index][index2] == 1{
                                Rectangle().fill(Color.teal).frame(width: tileWidth, height: tileWidth)
                            }else if viewModel.map.canvas[index][index2] == 2{
                                Circle().fill(.white).padding(4).frame(width: tileWidth, height: tileWidth)
                            }else if viewModel.map.canvas[index][index2] == 3{
                                Image("ghost").resizable().frame(width: tileWidth, height: tileWidth)
                            }else if viewModel.map.canvas[index][index2] == 4{
                                Image(viewModel.player.image).resizable().frame(width: tileWidth, height: tileWidth)
                            }
                        }
                    }
                }
                Rectangle()
                    .fill(.gray)
                    .frame(height: 150)
                    .cornerRadius(20)
                    .padding()
                    .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onEnded { value in
                            viewModel.calculateDirectionMove(value: value)
                        }
                    )
                HStack{
                    Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    Text("Points: \(viewModel.player.score)").foregroundColor(Color.white).bold()
                    Image(systemName: "heart.fill").foregroundColor(Color.red)
                    Text("Lives: \(viewModel.player.lives)").foregroundColor(Color.white).bold()
                }
            }
            .onAppear{
                viewModel.spawnPlayer()
                viewModel.setLives(lives: lives)
                if ghosts == 3{
                    viewModel.spawnGhost1()
                    viewModel.spawnGhost2()
                    viewModel.spawnGhost3()
                }else if ghosts == 2{
                    viewModel.spawnGhost1()
                    viewModel.spawnGhost2()
                }else {
                    viewModel.spawnGhost1()
                }
            }
            .onReceive(timer) { time in
                viewModel.packManMove()
                if ghosts == 3{
                    viewModel.ghost1Move()
                    viewModel.ghost2Move()
                    viewModel.ghost3Move()
                }else if ghosts == 2{
                    viewModel.ghost1Move()
                    viewModel.ghost2Move()
                }else {
                    viewModel.ghost1Move()
                }
                
            }
        }
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

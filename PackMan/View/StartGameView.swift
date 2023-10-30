//
//  StartGameView.swift
//  PackMan
//
//  Created by Даниил Крымлов on 30.10.2023.
//

import SwiftUI

struct StartGameView: View {
    
    @State var numOfGhosts = 1
    @State var numOfLives = 2
    @State var speed : CGFloat = 0.5
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack(alignment: .center){
                    Image("packman_rt")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    Text("Define game difficulty:")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                    HStack{
                        Text("Number of lives: \(numOfLives)")
                            .font(.title)
                        
                        Button(action: {
                            numOfLives += 1
                        }, label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                                .font(.title2)
                        })
                        Button(action: {
                            if numOfLives != 1 {
                                numOfLives -= 1
                            }
                        }, label: {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                                .font(.title2)
                        })
                    }
                    HStack{
                        Text("Number of ghosts: \(numOfGhosts)")
                            .font(.title)
                            
                        Button(action: {
                            if numOfGhosts != 3 {
                                numOfGhosts += 1
                            }
                        }, label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                                .font(.title2)
                        })
                        Button(action: {
                            if numOfGhosts != 1 {
                                numOfGhosts -= 1
                            }
                        }, label: {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                                .font(.title2)
                        })
                    }
                    HStack{
                        Text("Turn speed: \(speed, specifier: "%.2f")s")
                            .font(.title)
                            
                        Button(action: {
                            if speed != 1 {
                                speed += 0.25
                            }
                        }, label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                                .font(.title2)
                        })
                        Button(action: {
                            if speed != 0.25 {
                                speed -= 0.25
                            }
                        }, label: {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                                .font(.title2)
                        })
                    }
                    NavigationLink(destination: GameView(speed: speed, lives: numOfLives, ghosts: numOfGhosts), label: {
                        HStack{
                            Text("Start Game")
                                .font(.title)
                                .foregroundColor(.white)
                            Image("ghost")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25).fill(.green)
                        )
                    })
                    
                }
            }.navigationTitle("Pack Man")
        }
    }
}

#Preview {
    StartGameView()
}

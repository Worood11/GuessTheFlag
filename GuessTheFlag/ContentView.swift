//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Worood on 26/09/2026.
//

import SwiftUI

struct FlagImage : View {
    var country: String
    var body: some View{
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK","Ukraine" , "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreNumber = 0
    @State private var questionCount = 1
    @State private var gameOver = false
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold ))
                    
                }
                ForEach(0..<3) { number in
                    Button {
                        //flag was tapped
                        flagTapped(number)
                    } label: {
                        FlagImage(country: countries[number])
                          
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreNumber)")
        }
        .alert("Game Over!" , isPresented: $gameOver){
            Button("Reset The Game" , action: resetTheGame)
        } message: {
            Text("Your overall score is \(scoreNumber) out of 8")
        }
        
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            scoreNumber += 1
        } else{
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        if questionCount >= 8 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
    }
    func resetTheGame(){
        scoreNumber = 0
        questionCount = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}

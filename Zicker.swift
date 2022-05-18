//
//  Zicker.swift
//  FireBaseTest
//
//  Created by Aditiya Saisiva & Soham Kaje on 5/10/22.
//

import SwiftUI
import Firebase


struct Zicker: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showZic = false
    @State private var Count: Double = 0
    @State private var HS: Double = 0
    @State var timeLeft = 10
    func  saveToDatabase()  {
        
        let uid = Auth.auth().currentUser?.uid ?? "test"
        Database.database().reference().child("users").child(uid).updateChildValues(["Count": Count])
    }
    func buttonPressed (){
        self.Count += 1
        print(Count)
    }
    let timer = Timer.publish(every: 1,
                              on: .main,
                              in: .common)
        .autoconnect()
    func convertSecondsToTime(timeInSeconds : Int) ->  String {
        
        let minutes = timeInSeconds / 60
        
        let seconds = timeInSeconds % 60
        
        return String(format: "%02i:%02i",
                      minutes,
                      seconds)
    }
    var body: some View {
        VStack{
            Text(convertSecondsToTime(timeInSeconds: timeLeft))
                .padding()
                .font(.system(size: 25))
                .onReceive(timer) { _ in
                    if(timeLeft>0){
                        timeLeft -= 1
                    }
                    else if(timeLeft==0){
                        
                        saveToDatabase()
                        
                    }
                    }
        }
                NavigationView{
                    if(timeLeft>0){
                    Button(action:{
                        buttonPressed()
                    }) {
                        VStack{
                            Text("Click on Zickert's face as many times as you can in 10 seconds")
                                .offset(y:-100)
                            Image("zickertpic")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250.0, height: 250.0, alignment: .center)
                                .clipShape(Circle())
                                .offset(y: -90)
                            let bruh = String(describing: Count )
                            Text("Times Clicked: " + bruh)
                                .offset(y:-70)
                        }
                                            }
                    }
                    else if(timeLeft==0){
                        
                        VStack{
                        let bruh = String(describing: Count )
                       Spacer()
                            Text("Times Clicked: " + bruh)
                        Spacer()
                            Text("CPS: \(Count/10)")
                            Spacer()
                           
                        }
                        
                    }
                    Text("Click on Zickert's face as many times as you can in 10 seconds")
            .multilineTextAlignment(.center)
            .offset(y: -350 )
                  }
        .navigationTitle("Zicker Clicker")
        .navigationBarTitleDisplayMode(.inline).offset(y:10)
    }
}
struct Zicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Zicker()
        }
    }
}


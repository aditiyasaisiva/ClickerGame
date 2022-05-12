//
//  Zicker.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 5/10/22.
//

import SwiftUI

struct Zicker: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showZic = false
    @State private var Count = 0
    func buttonPressed (){
        self.Count += 1
        print(Count)
    }

    @State var timeLeft = 10
    
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
                        buttonPressed()
                    
                    }
            
        }

        
                NavigationView{
                    let bruh = Int(Count)
                    Text("Times Clicked: " + type(of: bruh))

                    if(timeLeft>0){
                    Button(action:{
                        buttonPressed()
                    }) {
                        Image("zickertpic")
                    }
                    }
          
            Image("zickertpic")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250.0, height: 250.0, alignment: .center)
                .clipShape(Circle())
                .offset(y: -125)
                    
                    
            
                        Text("Click on Zickert's face as many times as you can in 10 seconds")
                .multilineTextAlignment(.center)
                .offset(y: -265 )

        }
        
        

        .navigationTitle("Zicker Clicker")
       
            .navigationBarTitleDisplayMode(.inline)

            

        

                
    }
}

struct Zicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Zicker()
        }
    }


}
}

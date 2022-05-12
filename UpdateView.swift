//
//  UpdateView.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 12/14/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Combine

enum updateValueKeys{
    case firstName
    case lastName
    case city
}

struct UpdateView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showUpdate = false
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var city = ""

    func updateValues(){
        
        print(RegistrationKeys.firstName)
        
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                InputTextFieldView(text: $firstName, placeholder: "Update first Name", keyboardType: .default, sfSymbol: "person")
                InputTextFieldView(text: $lastName, placeholder: "Update last Name", keyboardType: .default, sfSymbol: "person.fill")
                InputTextFieldView(text: $city, placeholder: "Update city", keyboardType: .default, sfSymbol: "building")
            
                
                ButtonView(title: "Update Your Information"){
                    let uid = Auth.auth().currentUser?.uid ?? "test"
                    Database.database().reference().child("users").child(uid).updateChildValues(["firstName": firstName, "lastName": lastName, "city": city])
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
            
        }.applyClose()
        
    }
    
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}

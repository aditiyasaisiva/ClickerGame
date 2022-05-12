//
//  RegisterView.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 11/3/21.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var vm = RegistrationViewModelImpl (service: RegistrationServiceImpl())
    var body: some View {
    
        NavigationView{
            VStack(spacing: 32){
                VStack(spacing: 16){
                    InputTextFieldView(text: $vm.userDetails.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       sfSymbol: "envelope")
                    
                    InputPasswordView(password: $vm.userDetails.password,
                                      placeholder: "Password",
                                      sfSymbol: "lock")
                    Divider()//divides the view
                    
                    InputTextFieldView(text: $vm.userDetails.firstName,
                                       placeholder: "First Name",
                                       keyboardType: .namePhonePad,
                                       sfSymbol: nil)
                    
                    InputTextFieldView(text: $vm.userDetails.lastName,
                                       placeholder: "Last Name",
                                       keyboardType: .namePhonePad,
                                       sfSymbol: nil)
                    
                    InputTextFieldView(text: $vm.userDetails.city,
                                       placeholder: "City",
                                       keyboardType: .namePhonePad,
                                       sfSymbol: nil)
                }
                ButtonView(title: "Sign Up"){
                    vm.register()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Register")
            .applyClose()//runs the apply close method in CloseModifier
            .alert(isPresented: $vm.hasError,
                   content: {
                if case .failed(let error) = vm.state {
                    return Alert(title: Text("Error"), message: Text(error.localizedDescription))
                } else {
                    return Alert(
                        title: Text("Error"),
                        message: Text("Something went wrong"))
                }
            })
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

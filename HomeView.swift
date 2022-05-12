//
//  HomeView.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 11/3/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State private var showUpdate = false
    @State private var showZic = false
    
    var body: some View{
        VStack(alignment: .leading, spacing: 16){
            VStack(alignment: .leading, spacing: 16){
                Text("First Name: \(sessionService.userDetails?.firstName ?? "N/A")")
                Text("Last Name: \(sessionService.userDetails?.lastName ?? "N/A")")
                Text("City: \(sessionService.userDetails?.city ?? "N/A")")
            }
            ButtonView(title: "Update Your Infomation"){
                showUpdate.toggle()
            }
            .sheet(isPresented: $showUpdate,
                    content: {
                        UpdateView();
                    })
            
            
            ButtonView(title: "Log Out"){
                sessionService.logout()
            }
            ButtonView(title: "Zicker Clicker"){
                showZic.toggle()
            }
            .sheet(isPresented: $showZic,
                    content: {
                        Zicker();
                    })
        }
        .padding(.horizontal, 16).navigationTitle("Zicker Clicker")
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .environmentObject(SessionServiceImpl())//so the preview won't crash
        }
    }
}

//
//  Onboarding.swift
//  LittleLemon-iOS
//
//  Created by Eugene Sibinski on 07.04.2025.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"
struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    var body: some View {
        NavigationView {
        VStack {
            NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                EmptyView()
            }
            
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
            Button("Register"){
                if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                }
                else if !email.contains("@") {print("Email is not valid")}
                else {print("Fill all fields")}
                isLoggedIn = true
            }
        }.onAppear(){if UserDefaults.standard.bool(forKey: kIsLoggedIn) {isLoggedIn = true}}
        }
    }
}

#Preview {
    Onboarding()
}

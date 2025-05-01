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
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    @State var isLoggedIn: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Header()
                    Hero()
                        .padding()
                        .background(Color.primaryColor1)
                        .frame(maxWidth: .infinity, maxHeight: 240)
                    VStack {
                        NavigationLink(destination: Home(), isActive: $isLoggedIn) { }
                        Text("First name *")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                        Text("Last name *")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                        Text("E-mail *")
                            .onboardingTextStyle()
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .padding()
                        Button("Register"){
                            if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                                UserDefaults.standard.set(firstName, forKey: kFirstName)
                                UserDefaults.standard.set(lastName, forKey: kLastName)
                                UserDefaults.standard.set(email, forKey: kEmail)
                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                isLoggedIn = true
                            }
                            else if !email.contains("@") {print("Email is not valid")}
                            else {print("Fill all fields")}
                        }.buttonStyle(ButtonStyleYellowColorWide())
                    }.onAppear(){if UserDefaults.standard.bool(forKey: kIsLoggedIn) {isLoggedIn = true}}
                }
            }
        .navigationBarBackButtonHidden()
        }
    }

#Preview {
    Onboarding(firstName: "", lastName: "", email: "")
}

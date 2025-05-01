//
//  UserProfile.swift
//  LittleLemonApp
//

import SwiftUI

struct UserProfile: View {

    @Environment(\.presentationMode) var presentation

    let kFirstName = "first name key"
    let kLastName = "last name key"
    let kEmail = "email key"
    let kIsLoggedIn = "kIsLoggedIn"


    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(firstName: "", lastName: "", email: ""), isActive: $isLoggedIn) { }

            VStack(spacing: 5) {
                VStack {
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change") { }
                            .buttonStyle(ButtonStylePrimaryColor1())
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                }

                VStack{
                    Text("First name")
                        .onboardingTextStyle()
                    TextField("First Name", text: $firstName)
                }.onAppear{firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "" }

                VStack {
                    Text("Last name")
                        .onboardingTextStyle()
                    TextField("Last Name", text: $lastName)
                }.onAppear{lastName = UserDefaults.standard.string(forKey: kLastName) ?? "" }

                VStack {
                    Text("E-mail")
                        .onboardingTextStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                }.onAppear{email = UserDefaults.standard.string(forKey: kEmail) ?? "" }
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .padding()


            Button("Log out") {
                UserDefaults.standard.set(false, forKey: "kIsLoggedIn") // Use the correct key
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                isLoggedIn = true
            }
            .buttonStyle(ButtonStyleYellowColorWide())
            Spacer(minLength: 20)
            HStack {
                Button("Discard Changes") {
                    firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                    lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                    email = UserDefaults.standard.string(forKey: kEmail) ?? ""

                    self.presentation.wrappedValue.dismiss()
                }
                .buttonStyle(ButtonStylePrimaryColorReverse())
                Button("Save changes") {

                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)

                    self.presentation.wrappedValue.dismiss()
                }
            }
            .buttonStyle(ButtonStylePrimaryColor1())
        }
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
            lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
            email = UserDefaults.standard.string(forKey: kEmail) ?? ""
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }


    struct UserProfile_Previews: PreviewProvider {
        static var previews: some View {
            UserProfile()
        }
    }
}

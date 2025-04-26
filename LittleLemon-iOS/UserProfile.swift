//
//  UserProfile.swift
//  LittleLemon-iOS
//
//  Created by Eugene Sibinski on 07.04.2025.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: "firstName")
    let lastName = UserDefaults.standard.string(forKey: "lastName")
    let email = UserDefaults.standard.string(forKey: "Email")
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text("First Name:  \(String(describing: firstName ?? "N/A"))")
            Text("Last Name:  \(String(describing: lastName ?? "N/A"))")
            Text("Email: \(String(describing: email ?? "N/A"))")
        }
        Button("Logout"){UserDefaults.standard.set(false, forKey: kIsLoggedIn)
            self.presentation.wrappedValue.dismiss()
        }
        Spacer()
        }
    }


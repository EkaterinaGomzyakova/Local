//
//  CustomTitle.swift
//  Local
//
//  Created by Kate on 29.10.2024.
//

import Foundation
import SwiftUI

struct CustomTitle: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.custom("TT Commons Pro Edu Cnd", size: 60))
            .textCase(.uppercase)
            .foregroundColor(Color("AlmostBlack"))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }


        }




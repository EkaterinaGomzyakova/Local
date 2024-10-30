//
//  MissionItem.swift
//  Local
//
//  Created by Kate on 29.10.2024.
//

import Foundation
import SwiftUI

struct MissionItem: View {
    let number: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(number)
                .font(.custom("TT Commons Pro Edu Cnd", size: 60))
                .foregroundColor(Color("AlmostBlack"))
                .padding(.horizontal)
                .multilineTextAlignment(.leading)

            Text(description)
                .font(.custom("TT Interphases Edu", size: 18))
                .foregroundColor(Color("AlmostBlack"))
                .multilineTextAlignment(.leading) 
                .padding(.horizontal)
        }
        .frame(width: 173)
    }
}

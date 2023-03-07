//
//  RMSettingsView.swift
//  RickMort
//
//  Created by Mashuf Chowdhury on 3/7/23.
//

import SwiftUI

struct RMSettingsView: View {
    
    let viewModel: RMSettingsViewViewModel
    
    init (viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical) {
            List(viewModel.cellViewModels) {
                viewModel in
                HStack {
                    if let image = viewModel.image
                    { Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(8)
                            .background(Color(viewModel.iconContainerColor))
                            .cornerRadius(6)
                    }
                    Text(viewModel.titles)
                        .padding(.leading, 10)
                }
                .padding(.bottom, 3)
            }
        }
     }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOptions.allCases.compactMap( {
            return RMSettingsCellViewModel(type: $0)
        })))
    }
}

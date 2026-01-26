//
//  SortPopup.swift
//  NFT Market
//
//  Created by Dmitry on 26.01.2026.
//

import SwiftUI

struct SortPopup: View {
    let currentSort: BasketSortOption
    let onSelect: (BasketSortOption) -> Void
    let onClose: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.ypModalOverlay)
                .ignoresSafeArea(.all, edges: .all)
                .contentShape(Rectangle())
                .onTapGesture {
                    onClose()
                }
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 8) {
                    VStack(spacing: 0) {
                        Text("Сортировка")
                            .font(.footnoteRegular13)
                            .foregroundColor(.ypSortTitle)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                        
                        Rectangle()
                            .fill(Color.ypSeparator)
                            .frame(height: 0.3)
                        
                        Button(action: {
                            onSelect(.price)
                        }) {
                            Text("По цене")
                                .font(.title3Regular)
                                .foregroundColor(.ypBlue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                        }
                        
                        Rectangle()
                            .fill(Color.ypSeparator)
                            .frame(height: 0.5)
                        
                        Button(action: {
                            onSelect(.rating)
                        }) {
                            Text("По рейтингу")
                                .font(.title3Regular)
                                .foregroundColor(.ypBlue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                        }
                        
                        Rectangle()
                            .fill(Color.ypSeparator)
                            .frame(height: 0.5)
                        
                        Button(action: {
                            onSelect(.name)
                        }) {
                            Text("По названию")
                                .font(.title3Regular)
                                .foregroundColor(.ypBlue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                        }
                    }
                    .background(Color.ypSmokyWhite)
                    .cornerRadius(13)
                    
                    Button(action: onClose) {
                        Text("Закрыть")
                            .font(.title3Regular)
                            .foregroundColor(.ypBlue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.ypWhite)
                            .cornerRadius(13)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .contentShape(Rectangle())
                .onTapGesture { }
            }
        }
    }
}

#Preview {
    SortPopup(
        currentSort: .name,
        onSelect: { _ in },
        onClose: {}
    )
}

//
//  ContentView.swift
//  DynamicStyling
//
//  Created by Ajit Nevhal on 19/08/24.
//

import SwiftUI

class CarRentalViewState: ObservableObject, Equatable {
    @Published var addressText: String = "Pyramidvägen 9, 169 56\nStockholm"
    @Published var isAddressChanged: Bool = false

    init() {
        print("CarRentalViewState Initialized")
    }

    static func == (lhs: CarRentalViewState, rhs: CarRentalViewState) -> Bool {
        lhs.isAddressChanged == rhs.isAddressChanged && lhs.addressText == rhs.addressText
    }

    func handleTap() {
        if !isAddressChanged {
            isAddressChanged = true
            addressText = "29Km Away"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.addressText = "Pyramidvägen 9, 169 56\nStockholm"
                self.isAddressChanged = false
            }
        }
    }
}

struct CarRentalCardView: View {
    @ObservedObject private var viewState: CarRentalViewState
    @Binding var isTapped: Bool

    init(isTapped: Binding<Bool>, viewState: CarRentalViewState) {
        self._isTapped = isTapped
        self.viewState = viewState
        print("CarRentalCardView Initialized")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "car.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)

                Image("icoCheckmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .applyStyleToView("ImageBackColorStyle")

                Spacer()

                Text("Toyota Corolla Touring")
                    .applyStyle("menuTitle")
            }
            Divider()

            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Solna")
                        .applyStyle("PrimaryText")
                        .onTapGesture {
                            viewState.handleTap()
                        }

                    Text(viewState.addressText)
                        .applyStyle(isTapped ? "PrimaryText" : "SecondaryText")
                }
                Spacer()
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pickup")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Tue, Sep 8, 14:30")
                }

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Return")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Tue, Sep 8, 16:30")
                        .font(.headline)
                }
            }
        }
        .padding()
        .applyStyleToView("cardView")
        .padding()
        .onChange(of: viewState.isAddressChanged) { oldValue, newValue in
            isTapped = newValue
        }
    }
}

class TextViewModel: ObservableObject {
    @Published var string: String = "This is a string from ViewModel"
    @Published var toggle: Bool = false
    
    init() {
        print("TextViewModel initialized")
    }

    func toggleString() {
        toggle.toggle()
        string = toggle ? "The string has been updated!" : "This is a string from ViewModel"
    }
}

struct TextView: View {
    @StateObject private var textViewModel = TextViewModel()

    init() {
        print("TextView Initialized")
    }

    var body: some View {
        VStack {
            Text(textViewModel.string)
                .padding()
                .applyStyle(textViewModel.toggle ? "SecondaryText" : "PrimaryText")
            Button("Change Text") {
                textViewModel.toggleString()
            }
            .padding()
            .applyStyle("PrimaryButton")
            
        }
    }
}

struct ContentView: View {
    @State private var isTapped: Bool = false
    @StateObject private var viewState = CarRentalViewState()
    
    var body: some View {
        VStack {
            CarRentalCardView(isTapped: $isTapped, viewState: viewState)
            Button("Primary Button") {
                isTapped.toggle()
            }
            .padding()
            .applyStyle(isTapped ? "PrimaryButton" : "SecondaryButton")
            textView
                .applyStyle("cardView")
        }
        .padding()
    }
    
    @ViewBuilder
    private var textView: some View {
        TextView()
    }
    
}

#Preview {
    ContentView()
}

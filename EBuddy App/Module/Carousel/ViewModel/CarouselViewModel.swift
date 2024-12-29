//
//  CarouselViewModel.swift
//  EBuddy App
//
//  Created by Elmo on 27/12/24.
//  Copyright © 2024 Elmysf. All rights reserved.
//


import Combine
import SwiftUI
import Foundation

final class CarouselViewModel: ObservableObject {
    @Published var slidersData: [SliderModel] = []
    @Published private(set) var stateModel: UIStateModel = UIStateModel()
    @Published private(set) var activeCard: Int = 0
    @Published var progress: Float = 0
    @Published var errorMessage: String? = nil
    private let firebaseManager: FirebaseManagers
    private var cancellables = Set<AnyCancellable>()
    
    init(firebaseManager: FirebaseManagers = FirebaseManagers()) {
        self.firebaseManager = firebaseManager
        
        self.stateModel.$activeCard.sink { completion in
            switch completion {
            case let .failure(error):
                print("finished with error: ", error.localizedDescription)
            case .finished:
                print("finished")
            }
        } receiveValue: { [weak self] activeCard in
            self?.carouselChange(for: activeCard)
        }.store(in: &cancellables)
    }
    
    private func carouselChange(for activeCard: Int) {
        self.activeCard = activeCard
    }
    
    func animateProgress() {
        self.progress = 0
        withAnimation(Animation.linear(duration: 5.0)) {
            progress = 1.0
        }
    }
    
    func fetchSlider() {
        firebaseManager.fetchSliders()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] sliders in
                self?.slidersData = sliders
            
            })
            .store(in: &cancellables)
    }
}

//
//  RegistrationViewModel.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 11/9/21.
//

import Foundation
import Combine
//create an enum to handle the different states
enum RegistrationState {
    case successful
    case failed(error: Error)
    case na
}

protocol RegistrationViewModel {
    func register()//handles registration
    var hasError: Bool { get}
    var service: RegistrationService { get}
    var state: RegistrationState { get}//handles state changes
    var userDetails: RegistrationDetails { get}//bind to the view model
    init(service: RegistrationService)
}

final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
    
    @Published var hasError: Bool = false
    @Published var state: RegistrationState = .na
    
    let service: RegistrationService
    
    var userDetails: RegistrationDetails = RegistrationDetails.new
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: RegistrationService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func register(){
        
        service
            .register(with: userDetails)//call the register function
            .sink{ [weak self] res in
                switch res {//if failed set state to failure
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
                //if success set state to successful
            } receiveValue: { [weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions)
    }
}

private extension RegistrationViewModelImpl{
    
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                case .successful,
                        .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}

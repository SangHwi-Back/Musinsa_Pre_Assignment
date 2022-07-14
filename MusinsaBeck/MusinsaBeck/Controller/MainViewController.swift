//
//  MainViewController.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usecase = UseCaseContainer.shared.getUseCase(RequestInterviewUseCase.self) as? RequestInterviewUseCase
        
        usecase?.request({ result in
            switch result {
            case .success(let list):
                print(list)
            case .failure(let error):
                print(error)
            }
        })
    }
}

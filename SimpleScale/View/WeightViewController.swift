//
//  ViewController.swift
//  SimpleScale
//
//  Created by Yuki Matsushita on 10/27/18.
//  Copyright © 2018 Yuki Matsushita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeightViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = WeightViewModel()
        
        dateLabel.text = viewModel.date.value.description
        
        viewModel.weight.asObservable().bind(to: weightTextField.rx.text).disposed(by: bag)
        viewModel.isValid.bind(to: saveButton.rx.isEnabled).disposed(by: bag)
        
        weightTextField.rx.text.orEmpty.asObservable().bind(to: viewModel.weight).disposed(by: bag)
        saveButton.rx.tap.subscribe({ _ in viewModel.save() }).disposed(by: bag)
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewWillDisappear(_ animated: Bool) {
    }

}

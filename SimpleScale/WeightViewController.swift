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
   var  a: UISearchBar!
    
    var viewModel = WeightViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        weightTextField.rx.text.orEmpty.asObservable().bind(to: viewModel.weight).disposed(by: disposeBag)
        let _ = viewModel.isValid.bind(to: saveButton.rx.isEnabled)
    }

}


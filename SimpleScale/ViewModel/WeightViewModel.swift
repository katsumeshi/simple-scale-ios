//
//  WeightViewModel.swift
//  SimpleScale
//
//  Created by Yuki Matsushita on 10/27/18.
//  Copyright © 2018 Yuki Matsushita. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseFirestore
import FirebaseAuth
import CodableFirebase

class WeightViewModel {
    var date = Variable<RxTime>(RxTime.init())
    var weight = BehaviorRelay<String>(value: "")
    var isValid: Observable<Bool>
    var data: Driver<User>
    let disposeBag = DisposeBag()
    
    init() {
        isValid = weight.asObservable().map {
            let weight = Double($0) ?? 0.0
            return 0.0 < weight && weight < 300.0
        }
        data = WeightViewModel.fetch()
        data.map { user in return user.scale.last?.weight ?? 0 }
            .filter { $0 > 0 }
            .map { "\($0)" }
            .drive(self.weight)
            .disposed(by: disposeBag)
    }
    enum HeightError: Error {
        case maxHeight
        case minHeight
    }
    static func fetch() -> Driver<User> {
        return Single<User>.create(subscribe: { single in
            Firestore.firestore().collection("users").document("UarU5lTKy5TwT74R0pWY").getDocument { (document, error) in
                guard error == nil, let doc = document, doc.exists == true else {
                    single(.error(error!))
                    return
                }
                if let dict = doc.data(), let user = try? FirestoreDecoder().decode(User.self, from: dict) {
                    single(.success(user))
                    return
                }
            }
            return Disposables.create { }
        }).asDriver(onErrorJustReturn: User())
    }
    func save() {
         data.drive(onNext: {
            var user = User(user: $0)
            user.scale.append(Scale(weight: Double(self.weight.value) ?? 0, date: Date()))
            let docData = try! FirestoreEncoder().encode(user)
            Firestore.firestore().collection("users").document("UarU5lTKy5TwT74R0pWY").updateData(docData)
         })
        .disposed(by: disposeBag)
    }
}

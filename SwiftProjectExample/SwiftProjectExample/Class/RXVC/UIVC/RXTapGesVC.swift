//
//  RXTapGesVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/16.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RXTapGesVC: TBBaseVC {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UISwipeGestureRecognizer()
        tap.direction = .up
        view.addGestureRecognizer(tap)
        
        tap.rx.event.bind { [weak self] recognizer in
            let point = recognizer.location(in: recognizer.view)
            self?.showAlert(title: "滑动", message: "\(point.x) \(point.y)")
        }.disposed(by: disposeBag)
        
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        self.present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

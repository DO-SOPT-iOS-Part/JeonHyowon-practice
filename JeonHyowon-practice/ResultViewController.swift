//
//  ResultViewController.swift
//  JeonHyowon-practice
//
//  Created by Hyowon Jeon on 10/7/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    var delegate: GetDataProtocol?
    var loginDataCompletion: (([String]) -> Void)? //스트링 타입의 배열을 매개변수로 전달 할거고, 리턴타입은 void다!
    
    var email: String = ""
    var password: String = ""
    var date: String = ""
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private func bindText() {
        self.emailLabel.text = "email : \(email)"
        self.passwordLabel.text = "password : \(password)"
        self.dateLabel.text = "생년월일 : \(date)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindText()
    }

    @IBAction func backButtonTap(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
        
        delegate?.getLoginData(email: self.email, password: self.password, date: self.date)
        
        guard let loginDataCompletion else {return}
        loginDataCompletion([self.email, self.password, self.date])
    }
    
    func setLabelText(id: String,
                      password: String,
                      date: String) {
        self.email = id
        self.password = password
        self.date = date
    }
}

//
//  ViewController.swift
//  JeonHyowon-practice
//
//  Created by Hyowon Jeon on 10/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var idText: String = ""
    private var passwordText: String = ""
    private var dateText: String = ""

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 8
        canLogin()
    }

    @IBAction func idTextFieldDidEditing(_ sender: Any) {
        guard let textField = sender as? UITextField else {return}
        if let idText = textField.text {
            self.idText = idText
        }
        canLogin()
    }
    
    @IBAction func passwordTextFieldDidEditing(_ sender: Any) {
        guard let textField = sender as? UITextField else {return}
        if let passwordText = textField.text {
            self.passwordText = passwordText
        }
        canLogin()
    }
    
    @IBAction func datePickerDidEditing(_ sender: Any) {
        guard let datePicker = sender as? UIDatePicker else {return}
        let format = DateFormatter()
        format.dateFormat = "yyyy년 M월 d일"
                
        var dateText = format.string(from: datePicker.date)
        self.dateText = dateText
    }
    
    @IBAction func loginButtonTap(_ sender: Any) {
        print("\(idText)\n\(passwordText)\n\(dateText)")
        pushToResultVC()
    }
    
    func canLogin() { // id와 password가 입력되었을 때만 로그인 버튼을 활성화시키는 함수
        if (idText.count > 0 && passwordText.count > 0) {
            loginButton.backgroundColor = .systemBlue
            loginButton.tintColor = .white
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .systemGray6
            loginButton.tintColor = .systemGray2
            loginButton.isEnabled = false
        }
    }
    
    func pushToResultVC() {
        guard let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else {return}
        resultVC.setLabelText(id: idText,
                              password: passwordText,
                              date: dateText)
        resultVC.delegate = self
        resultVC.loginDataCompletion = { data in
            print("클로저로 받아온 email : \(data[0]), 클로저로 받아온 password : \(data[1]), 클로저로 받아온 생년월일 : \(data[2])")
        }
//        self.navigationController?.pushViewController(resultVC, animated: true)
        self.present(resultVC, animated: true)
    }
}

extension ViewController: GetDataProtocol {
    func getLoginData(email: String, password: String, date: String) {
        print("받아온 email : \(email), 받아온 password : \(password), , 받아온 생년월일 : \(date)")
    }
}

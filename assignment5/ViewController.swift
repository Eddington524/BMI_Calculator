//
//  ViewController.swift
//  assignment5
//
//  Created by Sammy Jung on 2024/01/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var resultButton: UIButton!
    
    @IBOutlet var warningMessageLabel: UILabel!
    
    @IBOutlet var secureButton: UIButton!
    
    var weightVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningMessageLabel.text = ""
        let systemEyeImg = UIImage(systemName: "eye.slash")
        secureButton.setImage(systemEyeImg, for: .normal)
    }
   
    var info : [String: Int] = ["height":0, "weight":0]
    
    @IBAction func textFieldValidate(_ sender: UITextField) {
        
        guard let heightTest = heightTextField.text
        else {
            warningMessageLabel.text = "잘못 입력했습니다"
            return
        }
       
        if let height = Int(heightTest){
            validateTextField(height, infoType: "height")
        }else{
            warningMessageLabel.text = "숫자가 아닙니다"
        }

//        guard let checkType = Int(heightTextFeild.text) else {
//            warningMessageLabel.text = "잘못 입력했습니다"
//            return
//        }
        
//        guard let height = Int(heightText) else {
//            warningMessage = "문자는 입력할 수 없습니다"
//            return
//        }
    }
    
    @IBAction func weightValidate(_ sender: UITextField) {
        
        guard let weightTest = weightTextField.text
        else {
            warningMessageLabel.text = "잘못 입력했습니다"
            return
        }
        
        if let weight = Int(weightTest)  {
            validateTextField(weight, infoType: "weight")
            warningMessageLabel.text = ""
        }else{
            warningMessageLabel.text = "숫자가 아닙니다"
        }
    }
    
    
    @IBAction func keyBoardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func showResultButton(_ sender: UIButton) {
        
//        let result = info["weight"] / info["height"]*(info["height"]
        
        guard let weight = info["weight"], let height = info["height"] else {
            warningMessageLabel.text = "값을 입력해주세요"
            return
        }
        
        let doubleWeight:Double = Double(weight)
        let doubleHeight:Double = Double(height)/100
        
        let Bmi = Float(doubleWeight / (doubleHeight * doubleHeight))
        
        var message = ""
        
//        if BMI < 18.5 {
//            message = "저체중입니다"
//        }else if 18.5 <= BMI || BMI < 23.0 {
//            message = "정상체중입니다"
//        }else if 23 <= BMI || BMI < 25{
//            message = "과체중입니다"
//        }else{
//            message = "비만입니다"
//        }
        switch Bmi {
        case ...18.5: message = "저체중입니다"
        case 18.5..<23: message = "정상체중입니다"
        case 23..<25: message = "과체중입니다"
        case 25...: message = "비만입니다"
        default: message = "오류입니다"
        }
        
        let alert = UIAlertController(title: "BMI 결과는\(Bmi)으로", message: "\(message)", preferredStyle: .alert)
        
        let confirmButton = UIAlertAction(title: "확인", style: .default)
        let retryButton = UIAlertAction(title: "다시하기", style: .cancel)
        
        alert.addAction(confirmButton)
        alert.addAction(retryButton)
       
        present(alert, animated: true)
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        let randomHeight = Int.random(in: 100...300)
        let randomWeight = Int.random(in: 10...300)
        heightTextField.text = "\(randomHeight)"
        weightTextField.text = "\(randomWeight)"
        info["height"] = randomHeight
        info["weight"] = randomWeight
    }
    
    @IBAction func visibleToggle(_ sender: UIButton) {
        let slashEyeImg = UIImage(systemName: "eye.slash")
        let EyeImg = UIImage(systemName: "eye")
       
        
        if weightVisible {
            secureButton.setImage(EyeImg, for: .normal)
            weightTextField.isSecureTextEntry = true
        }else{
            secureButton.setImage(slashEyeImg, for: .normal)
            weightTextField.isSecureTextEntry = false
        }
        weightVisible.toggle()
    }
    
    func validateTextField (_ value: Int?, infoType: String){
        
        guard let v = value else{
            warningMessageLabel.text = "올바른 값을 입력해주세요"
            return
        }
        
        switch infoType {
        case "height":
            if v < 100 || v >= 300 {
                warningMessageLabel.text = "키에 올바른 값을 입력해주세요"
            }else{
                info["height"] = v
                warningMessageLabel.text = ""
            }
        case "weight":
            if v < 10 || v >= 300 {
                warningMessageLabel.text = "몸무게에 올바른 값을 입력해주세요"
            }else{
                info["weight"] = v
                warningMessageLabel.text = ""
            }
        default:
            return
        }
        
    }
}


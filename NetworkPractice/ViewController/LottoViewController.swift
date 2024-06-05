//
//  LottoViewController.swift
//  NetworkPractice
//
//  Created by 박성민 on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

class LottoViewController: UIViewController {
    let numberTextField = UITextField()
    let informationLabel = UILabel()
    let dateLabel = UILabel()
    let line = UIView()
    
    let resultRound = UILabel()
    let resultLabel = UILabel()
    
    let num1 = UILabel()
    let num2 = UILabel()
    let num3 = UILabel()
    let num4 = UILabel()
    let num5 = UILabel()
    let num6 = UILabel()
    let plusImage = UIImageView()
    let bonusLabel = UILabel()
    let num7 = UILabel()
    
    let picker = UIPickerView()
    let toolbar = UIToolbar()
    
    var pickerData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHierarch()
        setUpLayout()
        setUpUI()
        setUpPicker()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        num1.layer.cornerRadius = num1.frame.width / 2
        num2.layer.cornerRadius = num1.frame.width / 2
        num3.layer.cornerRadius = num1.frame.width / 2
        num4.layer.cornerRadius = num1.frame.width / 2
        num5.layer.cornerRadius = num1.frame.width / 2
        num6.layer.cornerRadius = num1.frame.width / 2
        num7.layer.cornerRadius = num1.frame.width / 2
    }
    
    // MARK: - Connect 부분
    func setUpHierarch() {
        view.addSubview(numberTextField)
        view.addSubview(informationLabel)
        view.addSubview(dateLabel)
        view.addSubview(line)
        view.addSubview(resultRound)
        view.addSubview(resultLabel)
        
        view.addSubview(num1)
        view.addSubview(num2)
        view.addSubview(num3)
        view.addSubview(num4)
        view.addSubview(num5)
        view.addSubview(num6)
        view.addSubview(plusImage)
        view.addSubview(num7)
        view.addSubview(bonusLabel)
    }
    
    // MARK: - Layout 부분
    func setUpLayout() {
        numberTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(40)
        }
        informationLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(numberTextField.snp.bottom).offset(25)
        }
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(numberTextField.snp.bottom).offset(25)
        }
        line.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(dateLabel.snp.bottom).inset(-15)
            make.height.equalTo(1)
        }
        resultRound.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(180)
            make.top.equalTo(line.snp.bottom).offset(35)
        }
        resultLabel.snp.makeConstraints { make in
            make.leading.equalTo(resultRound.snp.trailing).offset(5)
            make.top.equalTo(line.snp.bottom).offset(35)
        }
        num1.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.top.equalTo(resultRound.snp.bottom).offset(35)
            make.size.equalTo(45)
        }
        setUpNum(me: num2, target: num1)
        setUpNum(me: num3, target: num2)
        setUpNum(me: num4, target: num3)
        setUpNum(me: num5, target: num4)
        setUpNum(me: num6, target: num5)
        
        plusImage.snp.makeConstraints { make in
            make.top.equalTo(resultRound.snp.bottom).offset(50)
            make.leading.equalTo(num6.snp.trailing).offset(10)
            //make.trailing.equalTo(num7.snp.leading).offset(20)
            make.size.equalTo(15)
        }
        num7.snp.makeConstraints { make in
            make.top.equalTo(resultRound.snp.bottom).offset(35)
            make.size.equalTo(45)
            make.leading.equalTo(plusImage.snp.trailing).offset(10)
        }
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(num7.snp.bottom).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-13)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        view.backgroundColor = .white
        
        numberTextField.backgroundColor = .red
        
        informationLabel.backgroundColor = .blue
        informationLabel.text = "ddd"
        informationLabel.tintColor = .white
        
        dateLabel.backgroundColor = .gray
        dateLabel.text = "ddd"
        
        line.backgroundColor = .lightGray
        
        resultRound.text = "11"
        resultRound.backgroundColor = .red
        
        resultLabel.text = "22"
        resultLabel.backgroundColor = .brown
        
        num1.text = "22"
        num1.textAlignment = .center
        num1.backgroundColor = .red
        num1.clipsToBounds = true
        
        plusImage.image = UIImage(systemName: "plus")
        plusImage.tintColor = .black
        
        num7.text = "22"
        num7.textAlignment = .center
        num7.backgroundColor = .red
        num7.clipsToBounds = true
        
        bonusLabel.text = "보너스"
    }
    
    // MARK: - 피커 세팅 부분
    func setUpPicker() {
        picker.delegate = self
        picker.dataSource = self
        numberTextField.inputView = picker
        
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        numberTextField.inputAccessoryView = toolbar
        
        numberTextField.delegate = self
        for i in 1...1100{
            pickerData.append(String(i))
        }
    }
    
    // MARK: - setupNumLabel Func
    func setUpNum(me: UILabel, target: UILabel) {
        me.snp.makeConstraints { make in
            make.top.equalTo(resultRound.snp.bottom).offset(35)
            make.leading.equalTo(target.snp.trailing).offset(5)
            make.size.equalTo(45)
        }
        me.text = "11"
        me.textAlignment = .center
        me.backgroundColor = .red
        me.layer.cornerRadius = me.frame.width / 2
        me.clipsToBounds = true
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = pickerData[row]
    }
}

extension LottoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

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
        callRequest(turn: "1111")
        
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
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(120)
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
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-18)
        }
    }
    
    // MARK: - UI 세팅 부분
    func setUpUI() {
        view.backgroundColor = .white
        
        numberTextField.backgroundColor = .white
        numberTextField.textAlignment = .center
        numberTextField.layer.cornerRadius = 10
        numberTextField.textColor = .black
        numberTextField.font = .systemFont(ofSize: 18)
        numberTextField.layer.borderColor = UIColor.lightGray.cgColor
        numberTextField.layer.borderWidth = 1
        
        informationLabel.backgroundColor = .white
        informationLabel.text = "당첨번호 안내"
        informationLabel.textColor = .black
        informationLabel.font = .systemFont(ofSize: 15)
        
        dateLabel.backgroundColor = .white
        dateLabel.text = "추첨 날짜 넣어줘야됨"
        dateLabel.font = .boldSystemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        
        line.backgroundColor = .lightGray
        
        resultRound.backgroundColor = .white
        resultRound.text = "땡땡회"
        resultRound.textColor = .systemYellow
        resultRound.font = .boldSystemFont(ofSize: 24)
        
        resultLabel.backgroundColor = .white
        resultLabel.text = "당첨결과"
        resultLabel.font = .boldSystemFont(ofSize: 24)
        
        
        num1.text = "88"
        num1.textAlignment = .center
        num1.backgroundColor = .red
        num1.clipsToBounds = true
        num1.textColor = .white
        
        plusImage.image = UIImage(systemName: "plus")
        plusImage.tintColor = .black
        
        num7.text = "22"
        num7.textAlignment = .center
        num7.backgroundColor = .red
        num7.clipsToBounds = true
        num7.textColor = .white
        
        bonusLabel.text = "보너스"
        bonusLabel.font = .systemFont(ofSize: 13)
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
        for i in 1...1121{
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
        me.textColor = .white
    }
    func callRequest(turn: String) {
        APIKey.lottoURL = turn
        AF.request(APIKey.lottoURL).responseDecodable(of: LottoModel.self) { respons in
            switch respons.result{
            case .success(let data):
                self.succesNetworkAndSetView(lotto: data)
                
            case .failure(let error):
                dump(error)
                
            }
        }
    }
    // MARK: - 네트워크 진행 후 값을 통해 뷰 업데이트 함수
    func succesNetworkAndSetView(lotto: LottoModel) {
        resultRound.text = "\(String(lotto.drwNo))회"
        dateLabel.text = "\(lotto.drwNoDate) 추첨"
        num1.text = String(lotto.drwtNo1)
        num1.backgroundColor = changeNumColor(num: lotto.drwtNo1)
        num2.text = String(lotto.drwtNo2)
        num2.backgroundColor = changeNumColor(num: lotto.drwtNo2)
        num3.text = String(lotto.drwtNo3)
        num3.backgroundColor = changeNumColor(num: lotto.drwtNo3)
        num4.text = String(lotto.drwtNo4)
        num4.backgroundColor = changeNumColor(num: lotto.drwtNo4)
        num5.text = String(lotto.drwtNo5)
        num5.backgroundColor = changeNumColor(num: lotto.drwtNo5)
        num6.text = String(lotto.drwtNo6)
        num6.backgroundColor = changeNumColor(num: lotto.drwtNo6)
        num7.text = String(lotto.bnusNo)
        num7.backgroundColor = changeNumColor(num: lotto.bnusNo)
    }
    func changeNumColor(num: Int) -> UIColor {
        switch num{
        case ...10:
            return .systemYellow
        case 11...20:
            return .systemBlue
        case 21...30:
            return .systemRed
        case 31...40:
            return .systemGray5
            
        default:
            return .darkGray
        }
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

//
//  ModifyProfileViewController.swift
//  Recody
//
//  Created by Glory Kim on 2022/12/01.
//

import Foundation
import UIKit

class ModifyProfileViewController : CommonVC {
    let viewModel = ModifyProfileViewModel()
    @IBOutlet weak var etNickName: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var lbGuide: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    enum UseCase: Int, OrderType {
        case back = 100 // 뒤로가기
        case changeNickNameText = 101
        case changeProfileImage = 102
        case cancel = 103
        case update = 104
        var number: Int {
            return self.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        update()
    }
    override func display(orderNumber: Int) {
        guard let useCase = UseCase(rawValue: orderNumber) else { return }
        switch useCase {
        case .back:
            self.dismiss(animated: true)
        default:
            self.presenter?.alertService.showToast("\(useCase)")
        }
        update()
    }
    override func displayErorr(orderNumber: Int, msg: String?) {
        update()
    }
    override func displaySuccess(orderNumber: Int, dataStore: DataStoreType?) {
        update()
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer){
        if let tag = sender.view?.tag {
            guard let useCase = UseCase(rawValue: tag) else { return }
            switch useCase {
            default:
                self.interactor?.just(useCase).drop()
            }
        }
    }
    func setup(){
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.view.tag = UseCase.back.rawValue
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnBack.tag = UseCase.back.rawValue
        btnCancel.tag = UseCase.cancel.rawValue
        btnUpdate.tag = UseCase.update.rawValue
        imgProfile.tag = UseCase.changeProfileImage.rawValue
        imgProfile.isUserInteractionEnabled = true
        [btnBack, btnCancel, btnUpdate,imgProfile].forEach({
            $0?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        })
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2.0
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.layer.borderWidth = 0.5
        etNickName.resignFirstResponder()
        etNickName.delegate = self
    }
    func update(){
        
    }
}
extension ModifyProfileViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection  \(textField.text)")
    }
}
class ModifyProfileViewModel {
    var profileImg = "" // 프로필 이미지 url
    var newNickName = "" // 새로운 닉네임
}

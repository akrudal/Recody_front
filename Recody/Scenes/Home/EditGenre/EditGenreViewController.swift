//
//  EditGenreViewController.swift
//  Recody
//
//  Created by 마경미 on 2022/09/05.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxCocoa
import RxSwift

protocol EditGenreViewControllerAttribute {
    func bind()
    func configure()
    func setFlowlayout()
}

class EditGenreViewController: UIViewController {
    
    @IBOutlet weak var category: CustomCategory!
    @IBOutlet weak var nextCategotyBtn: UIButton!
    @IBOutlet weak var beforeCategotyBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backBarBtn: UIBarButtonItem!
    @IBOutlet weak var addGenreBtn: UIButton!
    @IBOutlet weak var saveBarBtn: UIBarButtonItem!

    private var editViewModel = EditGenreViewModel()
    private let disposeBag = DisposeBag()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
        setFlowlayout()
    }
    
    static func getInstanse() -> EditGenreViewController {
        guard let vc =  UIStoryboard(name: "CategorySetting2", bundle: nil).instantiateViewController(withIdentifier: "CategorySetting") as? EditGenreViewController else {
            fatalError()
        }
        return vc
    }
}

extension EditGenreViewController: EditGenreViewControllerAttribute {
    func bind() {
        let input = EditGenreViewModel.Input(nextBtnTapped: nextCategotyBtn.rx.tap,
                                             beforeBtnTapped: beforeCategotyBtn.rx.tap,
                                             saveBtnTapped: saveBarBtn.rx.tap,
                                             addGenreTapped: addGenreBtn.rx.tap)
        
        backBarBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: disposeBag)
        
        saveBarBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.isNavigationBarHidden = false
            }
            .disposed(by: disposeBag)
        
        let output = editViewModel.transform(from: input)
        
        output.customCategory
            .bind { [weak self] item in
                //                self?.category.categoryImage.image = UIImage(named: item.imageStr)
                self?.category.categoryName.text = item.name
                self?.category.setInEditView()
                let image = UIImage(named: item.imageStr)?.withRenderingMode(.alwaysTemplate)
                self?.category.categoryImage.image = image
                self?.category.categoryImage.tintColor = UIColor.white
            }
            .disposed(by: disposeBag)
        
        output.genres
            .bind(to: collectionView.rx.items(cellIdentifier: EditGenreCollectionViewCell.cellID, cellType: EditGenreCollectionViewCell.self)) { index, item, cell in
                
                cell.cellDataObs.onNext(item)
                
                cell.button.rx.tap
                    .subscribe(onNext: { [weak self] in
                        self?.editViewModel.toggleGenre.accept(index)
                    }).disposed(by: cell.disposeBag)
                
                cell.button.rx.tap
                    .bind(onNext: { _ in
                        cell.touchToggleBtn2()
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        editViewModel.nowState.accept(0)
    }
    
    func configure() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationBar.shadowImage = UIImage()
        navigationBar.topItem?.title = "편집"
    }
    
    func setFlowlayout() {
        let flowlayout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width
        let itemsPerRow: CGFloat = 2
        let cellWidth = (width) / itemsPerRow
        flowlayout.itemSize = CGSize(width: cellWidth - 20, height: 46)
        collectionView.collectionViewLayout = flowlayout
    }
}

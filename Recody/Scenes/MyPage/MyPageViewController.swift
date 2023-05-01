//
//  MyPageViewController.swift
//  Recody
//
//  Created by 마경미 on 19.10.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController, ObservingCollectionCellEvent {

    var viewModel = MyPageViewModel()
    
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnAlarm: UIButton!
    @IBOutlet weak var btnProfile: UIImageView!
    @IBOutlet weak var lbNickName: UILabel!
    @IBOutlet weak var lbRecordCount: UILabel!
    @IBOutlet weak var lbThisMonthAppreciationWorksTitle: UILabel! // 9월 감상 작품
    @IBOutlet weak var lbThisMonthAppreciationWorksCount: UILabel! // 9월 감상 작품수
    @IBOutlet weak var lbMonthNickNameTitle: UILabel! // 9월의 당신은
    @IBOutlet weak var lbMonthNickName: UILabel! // 영화 매니아
    @IBOutlet weak var viewMonthInfomation: UIView! // 9월의 당신은,영화 매니아를 포함한 컨테이너뷰, 코너 원형 처리를위해 추가
    @IBOutlet weak var btnRecordedWorks: UILabel! // 기록 중인 작품
    @IBOutlet weak var btnDibsOnWorks: UILabel! // 찜한 작품
    @IBOutlet weak var bottomIndicatorConstraint: NSLayoutConstraint! // 하단 메뉴 강조 블럭
    @IBOutlet weak var viewChart:UIView!
    @IBOutlet weak var collectionView : UICollectionView!
    
    var recordedWorksList = [CollectionCellViewModel]() //기록 중인 작품리스트
    var dibsOnWorksList = [CollectionCellViewModel]() // 찜한 작품리스트
    enum UseCase: Int {
        case setting = 100 // 셋팅 버튼 클릭시 -> 화면이동
        case alarm = 101 // 우상단 알림 버튼 클릭시 -> 화면이동
        case nextBottomPgae = 102 // 하단 다음 페이지전환
        case previousBottomPage = 103 // 하단 이전 페이지전환
        case changeProfileImage = 104 // 프로필 사진 클릭시 -> 화면이동
        case moveWorkDetail = 105 // 작품 클릭시 상세보기 화면
        var number: Int {
            return self.rawValue
        }
    }
    @objc func clickEvent(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            guard let useCase = UseCase(rawValue: tag) else { return }
            switch useCase {
            case .setting:
                self.navigationController?.pushViewController(InsightViewController.getInstanse(), animated: true)
            case .nextBottomPgae:
                self.viewModel.nextPage()
            case .previousBottomPage:
                self.viewModel.previousPage()
            case .changeProfileImage:
//                self.navigationController?.pushViewController(ModifyProfileViewController.getInstanse(), animated: true)
                //todo
//                self.router?.presentWithRootViewcontroller(RoutingLogic.Navigation.modifyProfile, nil,.overCurrentContext)
            break
            default:
            break
            }
            update()
        }
    }
    func eventFromTableCell(code: Int, index: Int) {
        print("code : \(code) / index : \(index)")
    }
    private func setup(){
        //MARK: - UI
        viewMonthInfomation.cornerRadius = 15
        viewMonthInfomation.borderColor = .gray.withAlphaComponent(0.5)
        viewMonthInfomation.borderWidth = 0.5
        
        btnProfile.cornerRadius = 58/2
        btnProfile.backgroundColor = UIColor(hexString: "#D9D9D9")
        btnSetting.setTitle("", for: .normal)
        btnAlarm.setTitle("", for: .normal)
        //MARK: - ClickEvent
        btnSetting.setTag(UseCase.setting.rawValue)
        btnSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnAlarm.setTag(UseCase.alarm.rawValue)
        btnAlarm.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnProfile.setTag(UseCase.changeProfileImage.rawValue)
        btnProfile.isUserInteractionEnabled = true
        btnProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        
        btnRecordedWorks.setTag(UseCase.previousBottomPage.rawValue)
        btnRecordedWorks.isUserInteractionEnabled = true
        btnRecordedWorks.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        btnDibsOnWorks.setTag(UseCase.nextBottomPgae.rawValue)
        btnDibsOnWorks.isUserInteractionEnabled = true
        btnDibsOnWorks.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickEvent)))
        
        let com = TimeUtil.nowDateComponent()
        viewModel.month = com.month!
        viewModel.year = com.year!
        
    }
    private func setupCollectionView(){
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(cells: [(MyPageWorkCollectionCell.Xib,MyPageWorkCollectionCell.Name)])
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        recordedWorksList = (0...10).map { idx -> CollectionCellViewModel in
            return CollectionCellViewModel(type: -1, data: nil)
        }
        dibsOnWorksList = (0...8).map { idx -> CollectionCellViewModel in
            return CollectionCellViewModel(type: -1, data: nil)
        }
    }
    
    private func update() {
        lbNickName.text = viewModel.nickName
        lbRecordCount.text = "\(viewModel.totalRecordCount)"
        lbThisMonthAppreciationWorksTitle.text = "\(viewModel.month)월 감상 작품수"
        lbThisMonthAppreciationWorksCount.text = "\(viewModel.thisMonthAppreciationWorksCount)"
        lbMonthNickNameTitle.text = "\(viewModel.month)월의 당신은"
        lbMonthNickName.text = "\(viewModel.monthNickName)"
        if viewModel.bottomPageIndex == 0 { // 기록 중인 작품
            btnRecordedWorks.textColor = UIColor(hexString: "#51453D")
            btnDibsOnWorks.textColor = UIColor(hexString: "#CECECE")
            self.bottomIndicatorConstraint.constant = 0
            UIView.animate(withDuration: 0.3, delay: 0.0,options:[.beginFromCurrentState], animations: {
                self.view.layoutIfNeeded()
            })
        }else if (viewModel.bottomPageIndex == 1){ // 찜한 작품
            btnDibsOnWorks.textColor = UIColor(hexString: "#51453D")
            btnRecordedWorks.textColor = UIColor(hexString: "#CECECE")
            self.bottomIndicatorConstraint.constant = self.view.frame.width/2
            UIView.animate(withDuration: 0.3, delay: 0.0,options:[.beginFromCurrentState], animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        let chart1 = MyPageChartView()
        chart1.setColor(totalColor: viewModel.cicleChartColorTotal, bestColor: viewModel.cicleChartColorBest)
        chart1.setDataCount(total:100,best: viewModel.mostAppreciationGenrePer)
        self.viewChart.addSubview(chart1)
        chart1.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        update()
    }
}

extension MyPageViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var list = [CollectionCellViewModel]()
        if viewModel.bottomPageIndex == 0 {
            list = recordedWorksList
        } else if ( viewModel.bottomPageIndex == 1 ) {
            list = dibsOnWorksList
        }
        print("count = \(list.filter({$0.visible}).count)")
        
        return list.filter({$0.visible}).count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var list = [CollectionCellViewModel]()
        var cell = UICollectionViewCell()
        
        if viewModel.bottomPageIndex == 0 {
            list = recordedWorksList.filter({$0.visible})
        } else if ( viewModel.bottomPageIndex == 1 ) {
            list = dibsOnWorksList.filter({$0.visible})
        }
        
        var mCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageWorkCollectionCell.Name, for: indexPath) as? UICollectionViewCell & ObservingCollectionCell
            // Viewmodel 주입x
            mCell?.viewmodel = list[indexPath.row]
            mCell?.viewmodel?.index = indexPath.row
            // Cell 내의 클릭이벤트 구독 -> eventFromTableCell() 함수로전달
            mCell?.eventDelegate = self
        
        if mCell != nil { cell = mCell! }
        list[indexPath.row].viewHeight = cell.frame.height
        list[indexPath.row].viewWidth = cell.frame.width
//        cell.contentView.cornerRadius = 12
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(viewModel.collectionViewCellHorizontalSpacing))
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
////        return UIEdgeInsets(top: 0, left: 0, bottom: CGFloat(viewModel.collectionViewCellVerticalSpacing), right: CGFloat(viewModel.collectionViewCellHorizontalSpacing))
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width / CGFloat(viewModel.collectionViewMaxHorizontalItemCount)
        let margin = viewModel.collectionViewCellVerticalSpacing * (viewModel.collectionViewMaxLineCount + 1)
        let verticalPadding = 20
        let height = (Int(collectionView.frame.height) - margin - verticalPadding) / viewModel.collectionViewMaxLineCount
        let width = height / 2
        print("cell하나당 width=\(width)")
        print("cell하나당 height=\(height)")
        print("collectionView width = \(collectionView.frame.width)")
        print("collectionView height = \(collectionView.frame.height)")
        return CGSize(width:width , height: height)
    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return viewModel.collectionViewMaxLineCount
//    }
    
}

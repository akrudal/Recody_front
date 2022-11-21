//
//  CalendarDetailCell.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/17.
//

import UIKit

class CalendarDetailCell: UITableViewCell,ObservingTableCell {
    var viewmodel:TableCellViewModel?{
        didSet{
            viewmodel?.delegate = self
            changeData()
        }
    }
    @IBOutlet weak var cellView: UIView?
    @IBOutlet weak var lbGenre:UILabel!
    @IBOutlet weak var lbWorkTitle:UILabel!
    @IBOutlet weak var imgWork:UIImageView!
    @IBOutlet weak var imgStart1:UIImageView!
    @IBOutlet weak var imgStart2:UIImageView!
    @IBOutlet weak var imgStart3:UIImageView!
    @IBOutlet weak var imgStart4:UIImageView!
    @IBOutlet weak var imgStart5:UIImageView!
    var eventDelegate: ObservingTableCellEvent?
    func sendEventToController(sender: UITapGestureRecognizer) {
        if let code = sender.view?.tag {
            eventDelegate?.eventFromTableCell(code: InsightCellEvent.firstRecordEvent.rawValue)
        }
    }
    func changeData() {
        guard let data = viewmodel?.data else { return }
        binding(data: data)
    }
    func binding(data: Dictionary<String, Any>) {
        lbGenre.text=data.stringValue(key: "genre")
        lbWorkTitle.text=data.stringValue(key: "workTitle")
        let score = data.intValue(key: "score")
        settingStar(score)
        let imgPath = data.stringValue(key: "imgPath")
    }
    private func settingStar(_ score : Int){
        if score > 10 { return }
        let startImgs = [imgStart1,imgStart2,imgStart3,imgStart4,imgStart5]
        [imgStart1,imgStart2,imgStart3,imgStart4,imgStart5].forEach({
            $0?.image = UIImage(named:"star")
        })
        var halfStartPosition = -1
        var checkStartLastPosition = -1
        if score%2 == 1 {
            checkStartLastPosition=((score-1)/2) - 1
            halfStartPosition = ((score-1)/2)
        }else{
            checkStartLastPosition=((score)/2) - 1
            halfStartPosition = ((score)/2)
        }
        if checkStartLastPosition != -1 {
            for (index,img) in startImgs.enumerated(){
                if index <= checkStartLastPosition {
                    img?.image = UIImage(named: "star.fill")
                }
            }
        }
        if halfStartPosition != -1 {
            startImgs[halfStartPosition]?.image = UIImage(named: "star.half.fill")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbGenre.layer.masksToBounds = true
        lbGenre.layer.cornerRadius = lbGenre.frame.height/2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

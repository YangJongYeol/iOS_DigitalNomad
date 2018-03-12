//
//  NomadLifeWorkCell.swift
//  DigitalNomad
//
//  Created by Presto on 2018. 3. 7..
//  Copyright © 2018년 MokMinSimSeo. All rights reserved.
//

import UIKit
import BEMCheckBox

class NomadWorkCell: UITableViewCell {

    @IBOutlet var checkBox: BEMCheckBox!
    @IBOutlet var content: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBox.onAnimationType = .fill
        checkBox.offAnimationType = .fill
        checkBox.onCheckColor = .white
        checkBox.onTintColor = checkBox.tintColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickContent(_ sender: UIButton) {
        let textColor = sender.titleColor(for: .normal)
        if(textColor == .black){
            sender.setTitleColor(.blue, for: .normal)
        } else if(textColor == .blue){
            sender.setTitleColor(.red, for: .normal)
        } else if(textColor == .red){
            sender.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBAction func clickCheckBox(_ sender: BEMCheckBox) {
        let parentViewController = self.parentViewController() as! NomadViewController
        if(sender.on){
            checkBox.applyGradient([#colorLiteral(red: 0.5019607843, green: 0.7215686275, blue: 0.8745098039, alpha: 1), #colorLiteral(red: 0.6980392157, green: 0.8470588235, blue: 0.7725490196, alpha: 1)])
            checkBox.layer.sublayers?.first?.cornerRadius = checkBox.frame.height / 2
            let strikethrough = StrikethroughView.instanceFromXib() as! StrikethroughView
            strikethrough.tag = 100
            content.sizeToFit()
            strikethrough.frame.size = content.frame.size
            content.addSubview(strikethrough)
        } else {
            checkBox.layer.sublayers?.removeFirst()
            content.viewWithTag(100)?.removeFromSuperview()
        }
        let isFinished = reloadContentSummaryValue(controller: parentViewController)
        if(isFinished){
            //변경 화면
            let parentViewController = self.parentViewController() as! NomadViewController
            let changeView = NomadChangeView.instanceFromXib()
            changeView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            changeView.frame = parentViewController.view.frame
            parentViewController.view.addSubview(changeView)
            
        }
    }
    
    func reloadContentSummaryValue(controller: NomadViewController) -> Bool{
        if(controller.centerView.subviews.first is NomadWorkView){
            let workView = controller.centerView.subviews.first as! NomadWorkView
            let rows = workView.tableView.numberOfRows(inSection: 0)
            let completeRows = { () -> Int in
                var completes = 0
                var row = 0
                while let cell = workView.tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NomadWorkCell {
                    if(cell.checkBox.on){
                        completes += 1
                    }
                    row += 1
                }
                return completes
            }()
            if let underView = controller.underView.subviews.first as? NomadAddView{
                underView.contentSummaryValue.text = "\(completeRows)/\(rows)"
//                underView.textField.placeholder = "할 일, #해시태그"
//                if let firstContent = (workView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! NomadWorkCell).content.titleLabel?.text {
//                    underView.contentSummary.text = "\(firstContent) 외 \(rows-1)개"
//                }
            }
            return rows == completeRows
        } else {
            let lifeView = controller.centerView.subviews.first as! NomadLifeView
            let rows = lifeView.collectionView.numberOfItems(inSection: 0) - 1
            let completeRows = { () -> Int in
                var completes = 0
                var row = 0
                while let cell = lifeView.collectionView.cellForItem(at: IndexPath(item: row, section: 0)) as? NomadLifeCell {
                    if(cell.checkBox.on){
                        completes += 1
                    }
                    row += 1
                }
                return completes
            }()
            if let underView = controller.underView.subviews.first as? NomadAddView{
                underView.contentSummaryValue.text = "\(completeRows)/\(rows)"
//                underView.textField.placeholder = "하고 싶은 카드를 추가해보세요"
//                if let firstContent = (lifeView.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! NomadLifeCell).content.text {
//                    underView.contentSummary.text = "\(firstContent) 외 \(rows-1)개"
//                }
            }
            return rows == completeRows
        }
    }
}
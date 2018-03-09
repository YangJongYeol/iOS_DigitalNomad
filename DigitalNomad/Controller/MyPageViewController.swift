//
//  MyPageViewController.swift
//  DigitalNomad
//
//  Created by Presto on 2018. 2. 24..
//  Copyright © 2018년 MokMinSimSeo. All rights reserved.
//

import UIKit
import GaugeKit

class MyPageViewController: UIViewController {

    @IBOutlet var gauge: Gauge!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelHashtag: UILabel!
    @IBOutlet var viewList: UIView!
    @IBOutlet var viewCard: UIView!
    @IBOutlet var viewMeetup: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let list = MyPageListView.instanceFromXib()
        let card = MyPageCardView.instanceFromXib()
        let meetup = MyPageMeetupView.instanceFromXib()
        list.frame.size = viewList.frame.size
        card.frame.size = viewCard.frame.size
        meetup.frame.size = viewMeetup.frame.size
        labelHashtag.layer.cornerRadius = 5
        list.layer.cornerRadius = 5
        card.layer.cornerRadius = 5
        meetup.layer.cornerRadius = 5
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        viewList.addSubview(list)
        viewCard.addSubview(card)
        viewMeetup.addSubview(meetup)
        labelHashtag.applyGradient([UIColor(red: 128/255, green: 184/255, blue: 223/255, alpha: 1), UIColor(red: 178/255, green: 216/255, blue: 197/255, alpha: 1)])
        
        let lineWidth = gauge.lineWidth / 2
        let percent = gauge.rate * 100 / gauge.maxValue
        let radian = (percent * 18 / 5) * CGFloat.pi / 180
        let gaugePosition = gauge.frame.origin
        let centerX = gaugePosition.x + gauge.frame.width / 2
        let centerY = gaugePosition.y + gauge.frame.height / 2
        let radius = gauge.frame.width / 2
        let labelX = centerX + radius * sin(radian)
        let labelY = centerY - radius * cos(radian)
        let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: 40, height: 40))
        label.frame.origin.x -= label.frame.width / 2
        label.frame.origin.y -= label.frame.height / 2
        let distanceX = label.frame.origin.x + (label.frame.width / 2) - (centerX + (radius - lineWidth) * sin(radian))
        let distanceY = label.frame.origin.y + (label.frame.height / 2) - (centerY - (radius - lineWidth) * cos(radian))
        label.frame.origin.x -= distanceX
        label.frame.origin.y -= distanceY
        label.layer.masksToBounds = false
        label.layer.cornerRadius = label.frame.height / 2
        label.clipsToBounds = true
        label.backgroundColor = gauge.startColor
        label.text = "\(Int(percent))%"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        view.addSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickSetting(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MyPageDetailViewController")
        present(controller, animated: true)
    }
}

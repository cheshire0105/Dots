//23 . 11 . 17. 3:08 pm  최신화 완료- dev 에서 pull 받고 최신화 완료 - 세그먼트 콘트롤 을 버튼 커스텀으로 해결 진행하기
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import JTAppleCalendar
class Mypage: UIViewController {
    
    var 마이페이지_프로필_이미지_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 38
        imageButton.clipsToBounds = true
        imageButton.setImage(UIImage(named: "cabanel"), for: .selected)
        imageButton.setImage(UIImage(named: "cabanel"), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
    
    let 마이페이지_설정_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "setting" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    let 마이페이지_알림_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "알림" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_프로필_닉네임: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let 마이페이지_프로필_이메일: UILabel = {
        let label = UILabel()
        label.text = "유저 이메일"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let 마이페이지_전시_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    let 마이페이지_전시_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "전시")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    let 마이페이지_전시_라벨 = {
        let label = UILabel()
        label.text = "전시"
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 마이페이지_후기_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_후기_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "후기")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    let 마이페이지_후기_라벨 = {
        let label = UILabel()
        label.text = "리뷰"
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 마이페이지_보관함_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    let 마이페이지_보관함_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "보관함")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    let 마이페이지_보관함_라벨 = {
        let label = UILabel()
        label.text = "보관함"
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 구분선 = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    /*
     
     
     캘 린 더
     
     
     */
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Page")
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        버튼_클릭()
        UI레이아웃()
    }
    
    private func UI레이아웃 () {
        
        for UI뷰 in [마이페이지_프로필_이미지_버튼,마이페이지_설정_버튼,마이페이지_알림_버튼,마이페이지_프로필_닉네임,마이페이지_프로필_이메일,마이페이지_전시_버튼,마이페이지_후기_버튼,마이페이지_보관함_버튼,마이페이지_전시_아이콘,마이페이지_후기_아이콘,마이페이지_보관함_아이콘,마이페이지_전시_라벨,마이페이지_후기_라벨,마이페이지_보관함_라벨,구분선]{
            view.addSubview(UI뷰)
        }
        마이페이지_프로필_이미지_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(28)
            make.size.equalTo(76)
        }
        마이페이지_설정_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
            make.trailing.equalToSuperview().offset(-26)
        }
        마이페이지_알림_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
            make.trailing.equalTo(마이페이지_설정_버튼.snp.leading ).offset(-20)
        }
        마이페이지_프로필_닉네임.snp.makeConstraints { make in
            make.leading.equalTo(마이페이지_프로필_이미지_버튼.snp.trailing).offset(16)
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY).offset(-10)
        }
        마이페이지_프로필_이메일.snp.makeConstraints { make in
            make.leading.equalTo(마이페이지_프로필_이미지_버튼.snp.trailing).offset(16)
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY).offset(10)
        }
        마이페이지_전시_버튼.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(37)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(95)
            make.height.equalTo(85)
        }
        마이페이지_전시_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_전시_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_전시_버튼.snp.centerY)
            make.size.equalTo(25)
        }
        마이페이지_전시_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_전시_버튼.snp.centerX)
            make.top.equalTo(마이페이지_전시_버튼.snp.centerY).offset(6)
        }
        마이페이지_후기_버튼.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(37)
            make.centerX.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(85)
        }
        마이페이지_후기_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_후기_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_후기_버튼.snp.centerY)
            make.size.equalTo(25)
        }
        마이페이지_후기_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_후기_버튼.snp.centerX)
            make.top.equalTo(마이페이지_후기_버튼.snp.centerY).offset(6)
        }
        마이페이지_보관함_버튼.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(37)
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(95)
            make.height.equalTo(85)
        }
        마이페이지_보관함_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_보관함_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_보관함_버튼.snp.centerY)
            make.size.equalTo(25)
        }
        마이페이지_보관함_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_보관함_버튼.snp.centerX)
            make.top.equalTo(마이페이지_보관함_버튼.snp.centerY).offset(6)
        }
        구분선.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_전시_버튼.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

extension Mypage {
    func 버튼_클릭() {
        마이페이지_설정_버튼.addTarget(self, action: #selector(마이페이지_설정_버튼_클릭), for: .touchUpInside)
        마이페이지_전시_버튼.addTarget(self, action: #selector(마이페이지_전시_버튼_클릭), for: .touchUpInside)
        마이페이지_후기_버튼.addTarget(self, action: #selector(마이페이지_후기_버튼_클릭), for: .touchUpInside)
        마이페이지_보관함_버튼.addTarget(self, action: #selector(마이페이지_보관함_버튼_클릭), for: .touchUpInside)
    }
    @objc func 마이페이지_설정_버튼_클릭() {
        let 설정_이동 = 마이페이지_설정_페이지()
        self.navigationController?.pushViewController(설정_이동, animated: false)
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func 마이페이지_알림_버튼_클릭() {
        let 알림_이동 = 마이페이지_알림()
        self.navigationController?.pushViewController(알림_이동, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    @objc func 마이페이지_전시_버튼_클릭 () {
        let 전시_이동 = 마이페이지_전시()
        self.navigationController?.pushViewController(전시_이동, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    @objc func 마이페이지_후기_버튼_클릭 () {
        let 후기_이동 = 마이페이지_리뷰()
        self.navigationController?.pushViewController(후기_이동, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    @objc func 마이페이지_보관함_버튼_클릭 () {
        let 보관함_이동 = 마이페이지_보관함()
        self.navigationController?.pushViewController(보관함_이동, animated: true)
        self.navigationItem.hidesBackButton = true
    }
}

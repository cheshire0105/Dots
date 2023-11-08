// 23. 11. 8  12:28 pm dev에서 풀 완료 - 최신화 커밋 - > 로그인 페이지 작업 시작

import UIKit
import SnapKit

class 로그인_회원가입_뷰컨트롤러: UIViewController {
    
    //    도트 로고&슬로건
    private let 로고_이미지 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    private let 슬로건_라벨 = {
        let label = UILabel()
        label.text = """
전시의 시작은 당신의 눈길,
깊이는 우리의 목소리
"""
        label.numberOfLines = 2
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = UIColor.white
        label.textAlignment = .justified
        return label
    } ()
    //
    //회원가입 -
    private let 회원가입_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("회원가입", for: .normal)
        button.setTitle("회원가입", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    //로그인 _
    private let 로그인_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.setTitle("로그인", for: .normal)
        button.setTitle("로그인", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        UI레이아웃()
        버튼_클릭()
    }
    
    func UI레이아웃() {
        
        view.addSubview(로고_이미지)
        view.addSubview(슬로건_라벨)
        view.addSubview(회원가입_버튼)
        view.addSubview(로그인_버튼)
        
        로고_이미지.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(258)
            make.leading.equalToSuperview().offset(109)
            make.trailing.equalToSuperview().offset(-109)
        }
        
        슬로건_라벨.snp.makeConstraints { make in
            make.top.equalTo(로고_이미지.snp.bottom).offset(32)
            make.leading.equalTo(로고_이미지.snp.leading).offset(5)
            make.trailing.equalTo(로고_이미지.snp.trailing).offset(-5)
        }
        
        회원가입_버튼.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.top.equalTo(슬로건_라벨.snp.bottom).offset(170)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-44)
        }
        
        로그인_버튼.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.top.equalTo(회원가입_버튼.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-44)
        }
    }
}

extension 로그인_회원가입_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        회원가입_버튼.addTarget(self, action: #selector(회원가입_버튼_클릭), for: .touchUpInside)
        로그인_버튼.addTarget(self, action: #selector(로그인_버튼_클릭), for: .touchUpInside)
    }
    @objc func 회원가입_버튼_클릭() {
        let 인기리뷰페이지_디테일_화면 = 회원가입_뷰컨트롤러()
        self.navigationController?.pushViewController(인기리뷰페이지_디테일_화면, animated: true)
    }
    @objc func 로그인_버튼_클릭() {
        let 로그인_뷰컨트롤러_이동 = 로그인_뷰컨트롤러()
        self.navigationController?.pushViewController(로그인_뷰컨트롤러_이동, animated: true)
 
    }
}

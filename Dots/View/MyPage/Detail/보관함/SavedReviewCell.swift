import Foundation
import UIKit
import SnapKit

class 보관함_리뷰_셀 : UICollectionViewCell {
    
    var 리뷰_셀_작성자_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "help")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 리뷰_셀_닉네임 = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = .left
        return label
    } ()
    
    let 리뷰_셀_작성일자 = {
        let label = UILabel()
        label.text = "년월일시"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        return label
    } ()
    
    let 리뷰_셀_리뷰제목 = {
        let label = UILabel()
        label.text = "리뷰 제목"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    } ()
    
    let 리뷰_셀_전시명 = {
        let label = UILabel()
        label.text = "전시명"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    } ()
    private var 리뷰_셀_이미지 = {
       var imageView = UIImageView()
        imageView.image = UIImage(named: "morningStar")
       imageView.layer.cornerRadius = 15
       imageView.clipsToBounds = true
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
    let 리뷰_셀_본문내용 = {
        let label = UILabel()
        label.text = """
          '타락한 천사’는 19세기 프랑스 화가 알렉상드르 카바넬(Alexandre Cabanel)의 작품이다. 에두아르 마네를 구심점으로 새로운 미술 운동인 인상주의가 태동하고 있을 때, 카바넬은 아카데믹한 고전주의 양식으로 작업한 제도권 미술계의 총아였다. 그는 신화와 역사, 성서 이야기를 주제로 하는 역사화, 종교화를 그렸다.이 장르의 전통적인 테마는 성인, 천사, 영웅적인 인물이었는데, 카바넬은 ‘타락한 천사’에서 악마를 묘사해 당대 많은 논란을 일으켰다.
          """
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    } ()
    private let 리뷰_셀_좋아요_버튼 = {
         let button = UIButton()
         button.setImage(UIImage(named: "마이페이지 좋아요off"), for: .selected)
         button.setImage(UIImage(named: "마이페이지 좋아요on"), for: .normal)
         button.isSelected = !button.isSelected
         
         return button
     } ()
    private let 리뷰_셀_좋아요_카운트 = {
        let label = UILabel()
        label.text = "카운트"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.lightGray
        return label
    } ()
    private let 리뷰_셀_조회수_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "마이페이지 조회수"), for: .normal)
        button.isEnabled = false
        return button
    } ()
    
    private let 리뷰_셀_조회수_카운트 = {
        let label = UILabel()
        label.text = "카운트"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.lightGray
        return label
    } ()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "neon")?.cgColor
        마이페이지_리뷰_셀_레이아웃()
    }
    
    func 마이페이지_리뷰_셀_레이아웃() {
        contentView.addSubview(리뷰_셀_작성자_이미지)
        contentView.addSubview(리뷰_셀_닉네임)
        contentView.addSubview(리뷰_셀_작성일자)
        contentView.addSubview(리뷰_셀_이미지)
        contentView.addSubview(리뷰_셀_리뷰제목)
        contentView.addSubview(리뷰_셀_전시명)
        contentView.addSubview(리뷰_셀_본문내용)
        contentView.addSubview(리뷰_셀_좋아요_버튼)
        contentView.addSubview(리뷰_셀_좋아요_카운트)
        contentView.addSubview(리뷰_셀_조회수_버튼)
        contentView.addSubview(리뷰_셀_조회수_카운트)
        
        리뷰_셀_작성자_이미지.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        리뷰_셀_닉네임.snp.makeConstraints { make in
            make.centerY.equalTo(리뷰_셀_작성자_이미지.snp.centerY)
            make.leading.equalTo(리뷰_셀_작성자_이미지.snp.trailing).offset(5)
        }
        리뷰_셀_작성일자.snp.makeConstraints { make in
            make.centerY.equalTo(리뷰_셀_작성자_이미지.snp.centerY)
            make.leading.equalTo(리뷰_셀_닉네임.snp.trailing).offset(5)
        }
      
        리뷰_셀_리뷰제목.snp.makeConstraints { make in
            make.top.equalTo(리뷰_셀_작성자_이미지.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(16)
        }
        
        리뷰_셀_전시명.snp.makeConstraints { make in
            make.top.equalTo(리뷰_셀_리뷰제목.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
           
            
        }
        리뷰_셀_이미지.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(265)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-135)
        }
        리뷰_셀_본문내용.snp.makeConstraints { make in
            make.top.equalTo(리뷰_셀_전시명.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-50)
//            make.height.equalTo(54)
        }
        리뷰_셀_좋아요_버튼.snp.makeConstraints { make in
            make.top.equalTo(리뷰_셀_본문내용.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(10)
        }
        리뷰_셀_좋아요_카운트.snp.makeConstraints { make in
            make.centerY.equalTo(리뷰_셀_좋아요_버튼.snp.centerY)
            make.leading.equalTo(리뷰_셀_좋아요_버튼.snp.trailing).offset(4)
        }
        리뷰_셀_조회수_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(리뷰_셀_좋아요_버튼.snp.centerY)
            make.leading.equalTo(리뷰_셀_좋아요_카운트.snp.trailing).offset(14)
            
        }
        리뷰_셀_조회수_카운트.snp.makeConstraints { make in
            make.centerY.equalTo(리뷰_셀_조회수_버튼.snp.centerY)
            make.leading.equalTo(리뷰_셀_조회수_버튼.snp.trailing).offset(4)
            
        }
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



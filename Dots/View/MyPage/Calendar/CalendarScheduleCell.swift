import Foundation
import UIKit
import SnapKit

class 캘린더_스케쥴_등록_셀 : UITableViewCell {
    
    var 셀_데이터: 셀_데이터? {
        didSet {
            guard let 데이터 = 셀_데이터 else { return }
            
            전시_포스터_이미지(from: 데이터.포스터이미지URL)
            전시명_라벨.text = 데이터.전시명
            장소_라벨.text = 데이터.장소
            방문날짜_라벨.text = 데이터.방문날짜
        }
    }
   
    
    
    let 이미지_백 = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 12
        return uiView
    }()
    let 라벨_백 = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 12
        return uiView
    }()
    
    let 구분선 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "새로구분선")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var 전시_포스터_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "morningStar")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 전시명_라벨 = {
        let label = UILabel()
        label.text = "전시 제목"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    } ()
    
    let 장소_라벨 = {
        let label = UILabel()
        label.text = "전시 장소"
      
        label.textColor = UIColor.black
        
        
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = .left
        return label
    } ()
    
    let 방문날짜_라벨 = {
        let label = UILabel()
        label.text = "2022년 2월 2일"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
      
        label.textColor = UIColor.black
        
        
        label.textAlignment = .left
        return label
    } ()
    let 내후기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "내후기normal"), for: .normal)
        button.setImage(UIImage(named: "내후기select"), for: .selected)
        button.isSelected = !button.isSelected
        return button
    }()
    
    let 내후기_수정_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 0.7)
        button.setImage(UIImage(named: "내후기edit"), for: .normal)
        button.setImage(UIImage(named: "내후기edit"), for: .selected)
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 20
        button.isEnabled = true
        return button
    }()
    
    let 내후기_삭제_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 0.7)
        button.setImage(UIImage(named: "내후기delete"), for: .normal)
        button.setImage(UIImage(named: "내후기delete"), for: .selected)
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 20
        button.isEnabled = true
        return button
    }()
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        캘린더_스케쥴_등록_셀_레이아웃()
        
        
        if let 평균색상_추출 = 전시_포스터_이미지.image?.이미지_평균색상(){
            이미지_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
            라벨_백.backgroundColor = 평균색상_추출.withAlphaComponent(0.8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.selectionStyle = .none
    }
}



import SnapKit
import UIKit
class PopularReviewDetailPanModalCell: UITableViewCell {
    
    var 댓글_작성자_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "cabanel")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var 댓글_작성자_이름: UILabel = {
        let label = UILabel()
        label.text = "박철우"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    let 댓글_내용 = {
        let label = UILabel()
        label.text = """
저도 여기 다녀왔는데 좋았어요
"""
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = .orange.withAlphaComponent(0.3)
        return label
    } ()
    let 댓글_좋아요_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "댓글하트on"), for: .normal)
        button.setImage(UIImage(named: "댓글하트off"), for: .selected)
        button.isSelected = true
        return button
    } ()
    
    let 댓글_좋아요_카운트 = {
        let label = UILabel()
        let 카운팅 : Int = 0
        label.text = "\(카운팅)"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.white
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
            contentView.addSubview(댓글_작성자_이미지)
        contentView.addSubview(댓글_작성자_이름)
        contentView.addSubview(댓글_내용)
        addSubview(댓글_좋아요_버튼)
        contentView.addSubview(댓글_좋아요_카운트)
        
        댓글_작성자_이미지.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(5)
            make.size.equalTo(40)
            
        }
        댓글_작성자_이름.snp.makeConstraints { make in
            make.top.equalTo(댓글_작성자_이미지)
            make.leading.equalTo(댓글_작성자_이미지.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-35)
        }
        댓글_내용.snp.makeConstraints { make in
            make.top.equalTo(댓글_작성자_이름.snp.bottom).offset(3)
            make.leading.equalTo(댓글_작성자_이미지.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalTo(댓글_작성자_이미지.snp.bottom)
        }
        댓글_좋아요_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-5)
        }
        댓글_좋아요_카운트.snp.makeConstraints { make in
            make.top.equalTo(댓글_좋아요_버튼.snp.bottom).offset(-10)
            make.centerX.equalTo(댓글_좋아요_버튼.snp.centerX)
            
        }
    }
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "PopularReviewDetailPanModalCell")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit

extension 캘린더_스케쥴_등록_셀{
    func 캘린더_스케쥴_등록_셀_레이아웃() {
        contentView.addSubview(이미지_백)
        contentView.addSubview(라벨_백)
        contentView.addSubview(구분선)
        
        contentView.addSubview(전시_포스터_이미지)
        contentView.addSubview(전시명_라벨)
        contentView.addSubview(장소_라벨)
        contentView.addSubview(방문날짜_라벨)
        
        contentView.addSubview(내후기_버튼)
        
        이미지_백.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(이미지_백.snp.height)
        }
        
        전시_포스터_이미지.snp.makeConstraints { make in
            make.edges.equalTo(이미지_백).inset(5)
        }
        
        라벨_백.snp.makeConstraints { make in
            make.top.bottom.equalTo(이미지_백)
            make.leading.equalTo(이미지_백.snp.trailing)
            make.trailing.equalToSuperview().offset(-5)
        }
        
        구분선.snp.makeConstraints { make in
            make.centerY.equalTo(이미지_백)
            make.leading.equalTo(이미지_백.snp.trailing).offset(-40)
            make.size.equalTo(80)
        }
        
        전시명_라벨.snp.makeConstraints { make in
            make.top.equalTo(전시_포스터_이미지).offset(3)
            make.leading.equalTo(라벨_백).offset(12)
//            make.trailing.equalTo(view.snp.leading)
        }
        
//        내후기_버튼.snp.makeConstraints { make in
//            make.centerY.equalTo(전시명_라벨)
//            make.trailing.equalTo(라벨_백).offset(-12)
//            make.size.equalTo(24)
//        }
        
        장소_라벨.snp.makeConstraints { make in
            make.top.equalTo(전시명_라벨.snp.bottom).offset(8)
            make.leading.equalTo(전시명_라벨)
        }
        
        방문날짜_라벨.snp.makeConstraints { make in
            make.leading.equalTo(전시명_라벨)
            make.bottom.equalTo(전시_포스터_이미지).inset(3)
        }
    }
}

//		
//  Memka
//	

import PinLayout
import Tempura
import VerticalCardSwiper

/// The root view of the `MemeListView` section.
class MemeListView: UIView, ViewControllerModellableView {
    
    // MARK: - UI Elements
    
    /// Collection view with memes.
    private lazy var memesCollectionView: VerticalCardSwiper = {
        let collectionViewFlowLayout = VerticalCardSwiper(frame: self.bounds)
//        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
        return collectionViewFlowLayout
    }()
    
    // MARK: - Interactions
    
    /// Load more memes when scroll's close to the end of table
    var prefetchMemesAction: Interaction?

    /// User did select `Meme` from the table.
    var didSelectMeme: CustomInteraction<Int>?
    
    // MARK: - SSUL
    
    func setup() {
        addSubview(memesCollectionView)
        
        memesCollectionView.delegate = self
        memesCollectionView.datasource = self
        memesCollectionView.verticalCardSwiperView.prefetchDataSource = self
        memesCollectionView.register(MemeListCell.self, forCellWithReuseIdentifier: MemeListCell.identifier)
    }
    
    func style() {
        MemeListView.styleView(self)
        MemeListView.styleCollectionView(memesCollectionView)
    }
    
    func update(oldModel: MemeListViewModel?) {
        memesCollectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        memesCollectionView.pin
            .all()
    }
}

// MARK: - Collection View DataSource

extension MemeListView: VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        model?.memes.count ?? 0
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        guard let cellModel = model?.modelForMemeListCell(at: index) else {
            return verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: MemeListCell.identifier, for: index) as! CardCell
        }
        
        guard let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: MemeListCell.identifier, for: index) as? MemeListCell else {
            return verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: MemeListCell.identifier, for: index) as! CardCell
        }
        
        cell.model = cellModel
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MemeListView: VerticalCardSwiperDelegate {
    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
        didSelectMeme?(index)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

//extension MemeListView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width * 0.9, height: frame.height * 0.9)
//    }
//}

// MARK: - UICollectionViewDataSourcePrefetching

extension MemeListView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let model = model else {
            return
        }
        
        let indexPath = IndexPath(row: model.memes.count - Int(Double(model.memes.count) * 0.3), section: 0)
        
        if indexPaths.contains(indexPath) {
            prefetchMemesAction?()
        }
    }
}

// MARK: Styling Functions

private extension MemeListView {
    static func styleView(_ view: UIView) {
        view.backgroundColor = .white
    }
    
    static func styleCollectionView(_ collectionView: VerticalCardSwiper) {
        collectionView.backgroundColor = .white
        collectionView.isSideSwipingEnabled = false
//        collectionView.showsHorizontalScrollIndicator = false
    }
}

//		
//  Memka
//	

import PinLayout
import Tempura

/// The root view of the `MemeListView` section.
class MemeListView: UIView, ViewControllerModellableView {

  // MARK: - UI Elements

  /// Collection view with memes.
  private let memesCollectionView: UICollectionView = {
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

    return collectionView
  }()

	// MARK: - SSUL

	func setup() {
    addSubview(memesCollectionView)

    memesCollectionView.delegate = self
    memesCollectionView.dataSource = self
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

extension MemeListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    model?.memes.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let model = model else {
      return collectionView.dequeueReusableCell(withReuseIdentifier: MemeListCell.identifier, for: indexPath)
    }

    let meme = model.memes[indexPath.row]
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeListCell.identifier, for: indexPath) as? MemeListCell else {
      return collectionView.dequeueReusableCell(withReuseIdentifier: MemeListCell.identifier, for: indexPath)
    }

    cell.configure(with: meme)

    return cell
  }
}

// MARK: - Collection View Delegate

extension MemeListView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width * 0.9, height: frame.height * 0.75)
  }
}

// MARK: Styling Functions

private extension MemeListView {
  static func styleView(_ view: UIView) {
    view.backgroundColor = .white
  }

  static func styleCollectionView(_ collectionView: UICollectionView) {
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
  }
}

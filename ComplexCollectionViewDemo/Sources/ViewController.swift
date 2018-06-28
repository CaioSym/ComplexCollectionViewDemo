//
//  ViewController.swift
//  ComplexColectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import UIKit

private let advertisementCellReuseIdentifier = "advertisementCellReuseIdentifier"
private let carouselCellReuseIdentifier = "carouselCellReuseIdentifier"

private let bottomDrawerClosedSize = CGFloat(64)
private let bottomDrawerOpenSize = CGFloat(192)

class ViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var bottomDrawerView: UIView?
    @IBOutlet private weak var bottomDrawerButton: UIButton?
    @IBOutlet private weak var bottomDrawerHeightConstraint: NSLayoutConstraint?
    
    private let adapter = ComplexAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.attach(collectionView: collectionView)
        collectionView?.backgroundColor = Theme.backgroundColor
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(handleBottomDrawerPanGesture))
        bottomDrawerView?.addGestureRecognizer(gesture)
        
        bottomDrawerButton?.addTarget(self, action: #selector(handleBottomDrawerButtonTap), for: .touchUpInside)
    }
    
    @objc func handleBottomDrawerPanGesture(recognizer: UIPanGestureRecognizer) {
        guard case .ended = recognizer.state else { return }
        guard let bottomDrawerView = bottomDrawerView else { return }
        
        let velocity = recognizer.velocity(in: bottomDrawerView).y
        if velocity > 1.0 {
            animateBottomDrawer(isOpen: false)
        } else if velocity < -1.0 {
            animateBottomDrawer(isOpen: true)
        }
    }
    
    @objc func handleBottomDrawerButtonTap(recognizer: UIPanGestureRecognizer) {
        guard let constant = bottomDrawerHeightConstraint?.constant else { return }
        animateBottomDrawer(isOpen: constant == bottomDrawerClosedSize)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        adapter.update(items: [
            AdvertisementSection(advertisement: Advertisement(callToAction: "I'm such a long add title.",
                                                              image: try! Data(resource: R.file.advertBackgroundJpg),
                                                              isFeatured: true)),
           
            MusicAlbumSection(sectionTitle: "My Music", musicAlbums: createAlbumList()),
            MusicAlbumSection(sectionTitle: "Popular Hits", musicAlbums: createAlbumList()),
            MusicAlbumSection(sectionTitle: "Trending Among your friends", musicAlbums: createAlbumList()),
            MusicAlbumSection(sectionTitle: "Some More Music", musicAlbums: createAlbumList()),
            MusicAlbumSection(sectionTitle: "Such Sound. Very Music. Wow", musicAlbums: createAlbumList())
        ])
    }
    
    private func animateBottomDrawer(isOpen: Bool) {
        if isOpen {
            bottomDrawerHeightConstraint?.constant = bottomDrawerOpenSize
            bottomDrawerButton?.setImage(R.image.arrowDown(), for: UIControlState.normal)
        } else {
            bottomDrawerHeightConstraint?.constant = bottomDrawerClosedSize
            bottomDrawerButton?.setImage(R.image.arrowUp(), for: UIControlState.normal)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func createAlbumList() -> [MusicAlbum] {
        let musicAlbums = [
            MusicAlbum(title: "Disraeli Gears", coverImage: try! Data(resource: R.file.creamDisraeliGearsJpg)),
            MusicAlbum(title: "Elvis Presley Debut", coverImage: try! Data(resource: R.file.elvisPresleyDebutAlbumJpg)),
            MusicAlbum(title: "Goodbye Yellow Brick Road", coverImage: try! Data(resource: R.file.goodbyeYellowBrickRoadJpg)),
            MusicAlbum(title: "Back in Black", coverImage: try! Data(resource: R.file.acdcBackInBlackJpg)),
            MusicAlbum(title: "Asia", coverImage: try! Data(resource: R.file.asiaJpg)),
            MusicAlbum(title: "Abbey Road", coverImage: try! Data(resource: R.file.beatlesAbbeyRoadJpg)),
            MusicAlbum(title: "Black Sabbath", coverImage: try! Data(resource: R.file.blackSabbathJpg)),
            MusicAlbum(title: "Parallel Lines", coverImage: try! Data(resource: R.file.blondieParallelLinesJpg)),
            MusicAlbum(title: "Wish You Were Here", coverImage: try! Data(resource: R.file.wishYouWereHereJpg)),
            MusicAlbum(title: "Breakfast in America", coverImage: try! Data(resource: R.file.superTrampBreakfastinAmericaJpg)),
            MusicAlbum(title: "Weasels Ripped My Flesh", coverImage: try! Data(resource: R.file.mothersOfInventionWeaselsRippedMyFleshJpg)),
            MusicAlbum(title: "One Step Beyond", coverImage: try! Data(resource: R.file.madnessOneStepBeyondJpg)),
            MusicAlbum(title: "Look Sharp", coverImage: try! Data(resource: R.file.joeJacksonLookSharpJpg)),
            MusicAlbum(title: "its a Beautiful Day", coverImage: try! Data(resource: R.file.itsABeautifulDayJpg)),
            MusicAlbum(title: "Brain Salad", coverImage: try! Data(resource: R.file.brainSaladJpg)),
            MusicAlbum(title: "Diamond Dogs", coverImage: try! Data(resource: R.file.bowieDiamondDogsJpg)),
            MusicAlbum(title: "Aladin Sane", coverImage: try! Data(resource: R.file.bowieAladinSaneJpg))
        ]
        return musicAlbums.filter { _ in arc4random_uniform(10)%2 == 0 }
    }
}

protocol CollectionViewCellConvertible {
    func asCollectionViewCell(for collectionView: UICollectionView,
                              at indexPath: IndexPath) -> UICollectionViewCell
    
    var collectionViewCellSize: CGFloat { get }
}

struct AdvertisementSection: CollectionViewCellConvertible {
    let advertisement: Advertisement
    let injector = AdvertisementCollectionCellInjector()
    
    var collectionViewCellSize: CGFloat {
        return CGFloat(200)
    }
    
    func asCollectionViewCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: advertisementCellReuseIdentifier,
            for: indexPath) as! AdvertisementCell
        injector.inject(advertisement, into: cell)
        return cell
    }
}

struct MusicAlbumSection: CollectionViewCellConvertible {
    let sectionTitle: String
    let musicAlbums: [MusicAlbum]
    func asCollectionViewCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: carouselCellReuseIdentifier,
            for: indexPath) as! CarouselCell
        cell.title = sectionTitle
        let adapter = SingleCellCollectionCellViewAdapter(injector: MusicAlbumCollectionCellInjector(), cellWidth: CGFloat(160))
        cell.contentsAdapter = adapter
        adapter.update(items: musicAlbums)
        return cell
    }
    
    var collectionViewCellSize: CGFloat {
        return CGFloat(181)
    }
}

private class ComplexAdapter: BaseCollectionAdapter<CollectionViewCellConvertible>, UICollectionViewDelegateFlowLayout {
    
    public override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)
        collectionView?.register(CarouselCell.self, forCellWithReuseIdentifier: carouselCellReuseIdentifier)
        collectionView?.register(AdvertisementCell.self, forCellWithReuseIdentifier: advertisementCellReuseIdentifier)
    }
    
    public override func collectionView(_ collectionView: UICollectionView,
                                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView,
                                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return items[indexPath.row].asCollectionViewCell(for: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = items[indexPath.row].collectionViewCellSize
        return CGSize(width: collectionView.bounds.size.width, height: cellHeight)
    }
}

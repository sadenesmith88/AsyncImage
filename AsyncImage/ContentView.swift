//
//  ContentView.swift
//  AsyncImage
//
//  Created by sade on 6/14/24.
//

import SwiftUI

extension Image {
  func imageModifier() -> some View {
    self
      .resizable()
      .scaledToFit()
  }

  func iconModifier() -> some View {
    self
    .imageModifier()
    .frame(maxWidth: 128)
    .foregroundColor(.purple)
    .opacity(0.5)
  }
}

struct ContentView: View {

  private let imageURL : String = "https://credo.academy/credo-academy@3x.png"

  var body: some View {
    // MARK: - 1. BASIC

    //  AsyncImage(url: URL(string: imageURL))

    // MARK: - 2. SCALE

    // the greater the scale value the smaller the image
    // AsyncImage(url: URL(string: imageURL), scale: 3.0)

    //MARK: 3. PLACEHOLDER

//    AsyncImage(url: URL(string: imageURL)) { image in
//      image.imageModifier()
//
//    } placeholder: {
//      Image(systemName: "photo.circle.fill").iconModifier()
//
//
//    }
//    .padding(40)
    //MARK: - 4. PHASE
//    AsyncImage(url: URL(string: imageURL)) { phase in
//      //SUCCESS: the image successfully loaded
//      //FAILURE: the image failed to load
//      //EMPTY: no image is loaded
//
//      if let image = phase.image {
//        image.imageModifier()
//      } else if phase.error != nil {
//        Image(systemName: "ant.circle.fill").iconModifier()
//      } else {
//        Image(systemName: "photo,circle.fill").iconModifier()
//      }
//    }
//    .padding(40)

    //MARK: - 5. ANIMATION
    AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
      switch phase {
      case .success(let image):
        image.imageModifier()
          .transition(.move(edge: .bottom))
      case .failure(_):
        Image(systemName: "ant.circle.fill").iconModifier()
      case .empty:
        Image(systemName: "photo.circle.fill").iconModifier()
      @unknown default:
        ProgressView()
      }
    }
    .padding(40)
  }
}

#Preview {
    ContentView()
}

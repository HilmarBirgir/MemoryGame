Memory game
===============

A simple 4x4 grid [memory game](https://en.wikipedia.org/wiki/Concentration_(game)). The game saves your high score to your device. Your high score is the fewest moves required to beat the memory game. I made the game for a programming challenge and thought it was a good showcase for my Objective C best practises.

Installing
----------

This project uses [CocoaPods](http://cocoapods.org/) 

    gem install cocoapods
    pod repo update
    pod install

Once you installed the cocoapods you open MemoryGame.workspace and simply run.

Application
----------

The application is written in Objective-C and uses a ViewController + ViewModel paradigm (MVVM). It uses simple dependency injection for singletons which are called services. The Application is fully type annotated so introducing Swift code should be a breeze. 

Testing
----------

The tests are written using XCTest and OCMock.  To run the tests:

    CMD + U


3rd Party libraries
----------

* [AFNetworking](https://github.com/AFNetworking/AFNetworking): A nice wrapper around making network requests.
* [Reactive Cocoa](https://github.com/ReactiveCocoa/ReactiveObjC) : Provides a nice functional API to Objective-C. Also provides a really nice way of gluing UI and logic together.
* [SDWebImage](https://github.com/rs/SDWebImage): Provides a nice API with a built in cache for downloading images.
* [libextobjc](https://github.com/jspahrsummers/libextobjc): Objectice-C extension library. The weakify/strongify makes not retaining self when writing Reactive Cocoa code easy.
* [OCMock](http://ocmock.org/): A mocking library used for testing.

Credits
----------

* This project uses the random image api [unsplash](https://unsplash.it/)
* This project borrows the [8-bit Wonder](http://www.dafont.com/8bit-wonder.font) font by Joiro Hatgaya.

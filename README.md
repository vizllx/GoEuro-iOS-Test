# GoEuro-iOS-Test
GoEuro iOS Test

This is a code test for GoEuro (https://github.com/goeuro/iOS-Test).

Notes:
- Instructions say it should work on iOS 7 but I have no way to test it. All my devices are running iOS 9 or 10 and Xcode does not allow to download iOS 7 Simulators. It should work, though, maybe with a couple of ugly details.
- Date handeling is pretty basic. How basic? Basic-basic. It's just an example since didn't have complete datetimes or timezones.
- I added some tests but a lot more are missing, I'll add them in the comming days.
- Some things are written in Swift, as you asked :)
- Data cache currently works by saving data to a file. It would be nice to store it using Core Data, for example.

3rd party tools:

- SDWebImage (https://github.com/rs/SDWebImage). Used this to fetch images asynchronously.
- AFNetworking (https://github.com/AFNetworking/AFNetworking). Networking.
- Cocoapods (http://cocoadocs.org). Dependency manager. BTW, I'm a "add pods directory to versioning"-kind of person.

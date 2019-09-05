# Trailhead
Standardized iOS Architecture

[![Release](https://img.shields.io/github/v/release/mattwhitlock/trailhead?sort=semver)](https://github.com/mattwhitlock/Trailhead/releases)

[![License](https://img.shields.io/github/license/mattwhitlock/Trailhead)](https://choosealicense.com/licenses/mit/) [![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org) [![codecov.io](https://codecov.io/github/mattwhitlock/Trailhead/coverage.svg?branch=develop)](https://codecov.io/github/Moya/Moya?branch=master)

[![Two Blue Feet](https://img.shields.io/badge/2BF-Two%20Blue%20Feet-blue)](https://twobluefeet.com)

## Documentation
Class Documentation is available on [Github Pages here](https://mattwhitlock.github.io/Trailhead/)

## Installation
To prepare project for use, perform the following steps:  
1. Ensure [Carthage is installed](https://github.com/Carthage/Carthage)  
2. Run `./bootstrap.sh` from the `Source` folder.


## Customization to your Project
To change from the default Trailhead naming to your project called `<NewName>`, perform the following steps in Xcode:  
1. Open `Trailhead.xcodeproj`  
1. In Project Navigator, select the `Trailhead` target  
1. Click `Trailhead` traget again, rename to `<NewName>`  
1. May have to press `return`/`enter` to start rename process.
1. Let Xcode rename all items  
1. Update Signing Team if necessary  
1. Change Bundle Identifier  
1. Use Find Navigator to replace containing `Trailhead` with `<NewName>`  
1. In Project Navigator, rename folder from `Trailhead` to `<NewName>`  
1. In Project Navigator, select `<NewName>`, select General tab, Click `Choose Info.plist File...`, point it to `Info.plist` in `<NewName>` folder.  
1. Click Active Scheme selector, select Manage Schemes  
1. Rename scheme from `Trailhead` to `<NewName>`  
1. Update `README.md`  
1. Open `Main.storyboard` - it will automatically update custom class of `HomeViewController` to point to correct Module.  
1. ...  
1. **Profit!**  

**We're looking to automate this in the near future.**



## Documentation
To generate HTML documentation using [Jazzy](https://github.com/realm/jazzy), run `gendocs_jazzy.sh` in the Documentation folder.

## Contributing
Use standard Gitflow for updates  
*Contribution guidelines coming...*


## License
Trailhead is released under an MIT license. See [License.md](https://github.com/mattwhitlock/Trailhead/blob/develop/Documentation/License.md) for more information.

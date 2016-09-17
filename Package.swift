// Mason 2016-02-26

import PackageDescription

let package = Package(
    name: "Mason",
    
    dependencies:
    [
        //.Package(url: "https://github.com/apple/example-package-fisheryates.git", majorVersion: 1),
    ]
)

package.exclude = ["Whatever"]

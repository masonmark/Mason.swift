import Foundation
import Mason

let whoami = TaskWrapper.run("/usr/bin/whoami")
print("🖕  F.U., \(whoami.stdoutText)")

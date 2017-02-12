# EtcHost

EtcHost is a custom URLProtocol built on top of URLSession, which resolves host name to specific IP address directly.

# Example

````swift

import EtcHost

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

	URLProtocol.registerClass(EtcHostsURLProtocol.self)

	EtcHostsURLProtocol.configureHosts { (configuration) in
		configuration.resolveHostName(hostname: "google", to: "127.0.0.1")
	}

	return true
}
````

# LICENSE

MIT

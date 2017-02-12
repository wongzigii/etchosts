# EtcHosts

EtcHosts is a URLProtocol-based framework for *OS built on top of URLSession, which resolves host name to specific IP address directly, just likes `/etc/host` in *inux.

# Example

Usage is brain-dead simple with two lines of codes.

````swift

import EtcHosts

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

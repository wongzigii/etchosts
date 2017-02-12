# EtcHosts

EtcHosts is a URLSession-based framework for *OS to resolves host name to specific IP address directly, likes `/etc/host` in *inux.

## Example

Usage is brain-dead simple with two lines of codes.

````swift

import EtcHosts

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

	URLProtocol.registerClass(EtcHostsURLProtocol.self)

	EtcHostsURLProtocol.configureHosts { (configuration) in
		configuration.resolveHostName(hostname: "google.com", to: "192.168.0.1")
	}

	return true
}
````

## LICENSE

MIT

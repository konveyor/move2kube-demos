package io.konveyor.move2kube.helloserver.restservice;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class Hello {

	private final String name;
	private final String host;

	public Hello(String name) {
		this.name = name;
		String hostname = "localhost";
		try {
			hostname = InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		this.host = hostname;
	}

	public String getName() {
		return name;
	}

	public String getHost() {
		return host;
	}
}
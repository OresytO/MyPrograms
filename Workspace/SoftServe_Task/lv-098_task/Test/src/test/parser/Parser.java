package test.parser;

import java.util.ArrayList;
import java.util.List;

import test.ip.IP;
import test.ip.IPv4;
import test.ip.IPv6;

public abstract class Parser {
	protected List<IPv4> listIPv4 = new ArrayList<>();
	protected List<IPv6> listIPv6 = new ArrayList<>();

//	public Parser() {
//	}

	/**
	 * @return the listIPv4
	 */
	public List<IPv4> getListIPv4() {
		return listIPv4;
	}

	/**
	 * @return the listIPv6
	 */
	public List<IPv6> getListIPv6() {
		return listIPv6;
	}

	public boolean addToList(IP ip) {
		if (ip == null) {
			throw new RuntimeException("addToList() get null as parameter");
		} else {
			if (ip.getClass().getName().equals("test.ip.IPv4")) {
				listIPv4.add((IPv4) ip);
				return true;
			} else if (ip.getClass().getName().equals("test.ip.IPv6")) {
				listIPv6.add((IPv6) ip);
				return true;
			} else {
				return false;
			}
		}
	}
}

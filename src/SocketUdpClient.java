import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;


public class SocketUdpClient {
	public static void main(String[] args) throws Exception {
		DatagramSocket socket = new DatagramSocket();
		String s = "abc";
		byte[] buffer = s.getBytes();
		DatagramPacket packet = new DatagramPacket(buffer, buffer.length,
//				InetAddress.getByName("211.149.195.78"), 9000);
				InetAddress.getByName("58.20.37.144"), 27347);
		socket.send(packet);
		//socket.close();
		while (true) {// 无数据，则循环
			byte[] receiveByte = new byte[1024];
			DatagramPacket dataPacket = new DatagramPacket(receiveByte,
					receiveByte.length);
			socket.receive(dataPacket);
			String msg = new String(dataPacket.getData(),
					dataPacket.getOffset(), dataPacket.getLength());
			System.out.println(msg+"=====");
		}
	}
}

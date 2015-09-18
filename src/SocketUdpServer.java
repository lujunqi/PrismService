import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class SocketUdpServer {

	public static void main(String[] args) throws IOException {
		DatagramSocket ds = new DatagramSocket(9000);
		int i = 0;
		while (true) {// 无数据，则循环
			byte[] receiveByte = new byte[1024];
			DatagramPacket dataPacket = new DatagramPacket(receiveByte,
					receiveByte.length);
			ds.receive(dataPacket);
			String msg = new String(dataPacket.getData(),
					dataPacket.getOffset(), dataPacket.getLength());
			String line = dataPacket.getSocketAddress() + ":" + msg;
			System.out.println(line + "=========");
			
		}
	}
}

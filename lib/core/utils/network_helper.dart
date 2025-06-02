import 'dart:io';
import 'dart:async';

class NetworkHelper {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<bool> canReachServer(String host) async {
    try {
      final result = await InternetAddress.lookup(host);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<void> logNetworkInfo() async {
    print('=== Network Connectivity Check ===');

    final isOnline = await isConnected();
    print('Internet connectivity: $isOnline');

    if (isOnline) {
      final canReachAPI = await canReachServer('dentaq.genesiscreations.co');
      print('Can reach API server: $canReachAPI');
    }

    print('=== End Network Check ===');
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isDeviceConnected() async {
  try {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected = connectivityResult[0] == ConnectivityResult.wifi || connectivityResult[0] == ConnectivityResult.mobile;

    // if(!isConnected) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text('This product is already added to the outfit.')),
    //   );
    // }

    return isConnected;
  } catch (e) {
    print('Error checking connectivity: $e');
    return false;
  }
}
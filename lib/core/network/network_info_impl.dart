import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'network_info.dart';

/// Implementation of [NetworkInfo] using internet_connection_checker_plus
@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._connectionChecker);

  final InternetConnection _connectionChecker;

  @override
  Future<bool> get isConnected => _connectionChecker.hasInternetAccess;
}

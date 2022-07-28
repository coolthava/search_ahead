import 'package:search_ahead/core/common/network/i_network_client.dart';

abstract class IApiProvider {
  final INetworkClient client;

  IApiProvider(this.client);
}

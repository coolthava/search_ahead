import 'package:search_ahead/core/api/i_api_provider.dart';
import 'package:search_ahead/core/api/seatgeek/i_seatgeek_provider.dart';
import 'package:search_ahead/core/api/seatgeek/model/event_response.dart';
import 'package:search_ahead/core/common/network/i_network_client.dart';

class SeatGeekProvider extends IApiProvider implements ISeatGeekProvider {
  SeatGeekProvider(INetworkClient client) : super(client);

  @override
  Future<EventListResponse> getEventList(String keyword) async {
    var res = await client.get<Map<String, dynamic>>(
      '/events',
      queryParameters: <String, String>{
        'client_id': 'MjgwNzUzMDV8MTY1ODkyNjg5My41NDIzMTM2',
        'q': keyword,
        'per_page': '25',
      },
    );

    return EventListResponse.fromJson(res.data!);
  }
}

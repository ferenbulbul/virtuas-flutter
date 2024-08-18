import 'package:flutter_application_1/models/client_data.dart';

class ClientDataResponse {
  List<ClientData>? clientDataList;

  ClientDataResponse({
    required this.clientDataList,
  });

  factory ClientDataResponse.fromJson(Map<String, dynamic> json) {

return ClientDataResponse(
      clientDataList: (json['clientDataList'] as List)
          .map((x) => ClientData.fromJson(x))
          .toList(),
    );  
  }

  Map<String, dynamic> toJson() {
     return {
      'clientDataList': clientDataList?.map((item) => item.toJson()).toList(),
    };
  }
}





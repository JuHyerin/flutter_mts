import 'package:flutter_mts/interface/api/api_request_data.dart';

class KisSocketRequestHeader implements ApiRequestData{
   late final String approvalKey;
   late final String custType;
   late final int trType;

   KisSocketRequestHeader({
      required this.approvalKey,
      required this.custType,
      required this.trType
   });

   @override
   Map<String, dynamic> toJson() {
      return {
         "approval_key": approvalKey,
         "custtype": custType,
         "tr_type": '$trType',
         "content-type": "utf-8"
      };
   }
}
class KisSocketRequestBody implements ApiRequestData {
   late final String trId;
   late final String trKey;

   KisSocketRequestBody({
      required this.trId,
      required this.trKey
   });

   @override
   Map<String, dynamic> toJson() {
      return {
         "input": {
            "tr_id": trId,
            "tr_key": trKey
         }
      };
   }

}
class KisSocketRequestParam implements ApiRequestData {
   late final KisSocketRequestHeader header;
   late final KisSocketRequestBody body;

   KisSocketRequestParam({
      required this.header,
      required this.body
   });

   @override
   Map<String, dynamic> toJson() {
      return {
        "header": header.toJson(),
        "body": body.toJson()
      };
   }

   @override
   String toString() {
      return body.trKey;
   }
}

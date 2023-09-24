class EsewaMessageModel {
  EsewaMessageModel({
    required this.productId,
    required this.productName,
    required this.totalAmount,
    required this.environment,
    required this.code,
    required this.merchantName,
    required this.message,
    required this.transactionDetails,
  });

  String productId;
  String productName;
  String totalAmount;
  String environment;
  String code;
  String merchantName;
  Message message;
  TransactionDetails transactionDetails;

  factory EsewaMessageModel.fromJson(Map<String, dynamic> json) =>
      EsewaMessageModel(
        productId: json["productId"],
        productName: json["productName"],
        totalAmount: json["totalAmount"],
        environment: json["environment"],
        code: json["code"],
        merchantName: json["merchantName"],
        message: Message.fromJson(json["message"]),
        transactionDetails:
            TransactionDetails.fromJson(json["transactionDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "totalAmount": totalAmount,
        "environment": environment,
        "code": code,
        "merchantName": merchantName,
        "message": message.toJson(),
        "transactionDetails": transactionDetails.toJson(),
      };

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'totalAmount': totalAmount,
      'environment': environment,
      'code': code,
      'merchantName': merchantName,
      "message": message.toMap(),
      "transactionDetails": transactionDetails.toMap(),
    };
  }
}

class Message {
  Message({
    required this.technicalSuccessMessage,
    required this.successMessage,
  });

  String technicalSuccessMessage;
  String successMessage;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        technicalSuccessMessage: json["technicalSuccessMessage"],
        successMessage: json["successMessage"],
      );

  Map<String, dynamic> toJson() => {
        "technicalSuccessMessage": technicalSuccessMessage,
        "successMessage": successMessage,
      };

  Map<String, dynamic> toMap() {
    return {
      'technicalSuccessMessage': technicalSuccessMessage,
      'successMessage': successMessage,
    };
  }
}

class TransactionDetails {
  TransactionDetails({
    required this.status,
    required this.referenceId,
    required this.date,
  });

  String status;
  String referenceId;
  String date;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        status: json["status"],
        referenceId: json["referenceId"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "referenceId": referenceId,
        "date": date,
      };

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'referenceId': referenceId,
      "date": date,
    };
  }
}



class EsewaPaymentModel {
  EsewaPaymentModel({
    this.message,
    this.productId,
    this.productName,
    this.totalAmount,
    this.date,
    this.status,
    this.referenceId,
  });
  String? message;
  String? productId;
  String? productName;
  String? totalAmount;
  String? date;
  String? status;
  String? referenceId;

  factory EsewaPaymentModel.fromJson(Map<String, dynamic> json) =>
      EsewaPaymentModel(
        message: json["message"],
        productId: json["productId"],
        productName: json["productName"],
        totalAmount: json["totalAmount"],
        date: json["date"],
        status: json["status"],
        referenceId: json["referenceId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "productId": productId,
        "productName": productName,
        "totalAmount": totalAmount,
        "date": date,
        "status": status,
        "referenceId": referenceId,
      };
}

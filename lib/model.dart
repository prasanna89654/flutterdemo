class CartModel {
  final String? id;
  final String? userId;
  final String? publisherId;
  final String? bookId;
  final DateTime? createdAt;
  final Book? book;

  CartModel({
    this.id,
    this.userId,
    this.publisherId,
    this.bookId,
    this.createdAt,
    this.book,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        userId: json["userId"],
        publisherId: json["publisherId"],
        bookId: json["bookId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        book: json["book"] == null ? null : Book.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "publisherId": publisherId,
        "bookId": bookId,
        "createdAt": createdAt?.toIso8601String(),
        "book": book?.toJson(),
      };
}

class Book {
  final String? title;
  final int? price;
  final dynamic image;

  Book({
    this.title,
    this.price,
    this.image,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "image": image,
      };
}

class OrderModel {
  final String? id;
  final String? userId;
  final String? status;
  final bool? isPayment;
  final int? total;
  final DateTime? createdAt;
  final User? user;
  final List<OrderItem>? orderItem;

  OrderModel({
    this.id,
    this.userId,
    this.status,
    this.isPayment,
    this.total,
    this.createdAt,
    this.user,
    this.orderItem,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["userId"],
        status: json["status"],
        isPayment: json["isPayment"],
        total: json["total"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        orderItem: json["OrderItem"] == null
            ? []
            : List<OrderItem>.from(
                json["OrderItem"]!.map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "status": status,
        "isPayment": isPayment,
        "total": total,
        "createdAt": createdAt?.toIso8601String(),
        "user": user?.toJson(),
        "OrderItem": orderItem == null
            ? []
            : List<dynamic>.from(orderItem!.map((x) => x.toJson())),
      };
}

class OrderItem {
  final int? quantity;
  final int? price;
  final String? status;
  final Book? book;

  OrderItem({
    this.quantity,
    this.price,
    this.status,
    this.book,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        quantity: json["quantity"],
        price: json["price"],
        status: json["status"],
        book: json["book"] == null ? null : Book.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "price": price,
        "status": status,
        "book": book?.toJson(),
      };
}

class Bookss {
  final String? title;

  Bookss({
    this.title,
  });

  factory Bookss.fromJson(Map<String, dynamic> json) => Bookss(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class User {
  final String? name;

  User({
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}


class SearchModel {
    final String? id;
    final String? title;
    final int? price;
    final dynamic image;

    SearchModel({
        this.id,
        this.title,
        this.price,
        this.image,
    });

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "image": image,
    };
}

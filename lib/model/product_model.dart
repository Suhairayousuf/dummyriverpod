class ProductModel {
  DateTime? createdDate;
  double? amount;
  String? id;
  String? image;
  // bool? deal;

  // String? shopId;
  String? productName;
  String? description;
  // String? shopCategory;
  // double? offerPercentage;

  ProductModel(
      {this.createdDate,
        this.id,
        this.image,
        this.amount,
        // this.deal,
        // this.shopId,
        this.description,

        // this.shopCategory,
        // this.offerPercentage,
        this. productName,
      });

  ProductModel.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'].toDate();

    id = json['id'];
    image = json['image'];
    amount = json['amount'];
    // deal = json['deal'];
    //
    // shopId = json['shopId'];
    productName = json['productName'];
    description = json['description'];
    // shopCategory = json['shopCategory'];
    // offerPercentage = json['offerPercentage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;

    data['id'] = this.id;
    // data['deal'] = this.deal;
    data['amount'] = this.amount;
    data['image'] = this.image;
    // data['shopId'] = this.shopId;
    data['productName'] = this.productName;
    data['description'] = this.description;
    // data['shopCategory'] = this.shopCategory;
    // data['offerPercentage'] = this.offerPercentage;
    return data;
  }
}
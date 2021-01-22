class CustomerReviewsResponse {
  bool error;
  String message;
  List<CustomerReviews> customerReviews;

  CustomerReviewsResponse({this.error, this.message, this.customerReviews});

  CustomerReviewsResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['customerReviews'] != null) {
      customerReviews = [];
      json['customerReviews'].forEach((v) {
        customerReviews.add(CustomerReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.customerReviews != null) {
      data['customerReviews'] =
          this.customerReviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerReviews {
  String name;
  String review;
  String date;

  CustomerReviews({this.name, this.review, this.date});

  CustomerReviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['review'] = this.review;
    data['date'] = this.date;
    return data;
  }
}

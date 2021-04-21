class Advert {
  String? advertType;
  int? quantity;
  String? quantityUnit;
  List? images;
  String? title;
  String? description;
  int? price;
  bool eachCheckbox;
  String? district;
  String? parish;
  String? listed;
  int? distance;
  String? advertPhoneNumber;
  bool whatsApp;
  bool phoneCallOk;
  String? advertiserName;
  String? advertiserJoinedDate;
  String? advertiserProfilePicture;
  bool isWatchlisted;
  bool adStatus;
  String listingID;

  Advert({
    required this.advertType,
    required this.quantity,
    this.quantityUnit,
    this.images,
    required this.title,
    required this.listed,
    required this.price,
    this.eachCheckbox = false,
    this.distance,
    required this.advertPhoneNumber,
    required this.whatsApp,
    required this.phoneCallOk,
    this.advertiserName,
    this.advertiserJoinedDate,
    this.advertiserProfilePicture,
    required this.description,
    required this.isWatchlisted,
    required this.adStatus,
    required this.district,
    required this.parish,
    required this.listingID,
  });
}

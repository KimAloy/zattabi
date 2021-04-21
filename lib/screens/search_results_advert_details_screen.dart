import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/widgets/widgets.dart';

class SearchResultsAdvertDetailsScreen extends StatelessWidget {
  final Advert advertData;

  const SearchResultsAdvertDetailsScreen({
    Key? key,
    required this.advertData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              advertData.images == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          elevation: 0.0,
                          backgroundColor: kScreenBackground,
                          iconTheme: IconThemeData(color: Colors.black),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.amber[400],
                              radius: 24,
                              child: IconAddToWatchlist(advertData: advertData),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    )
                  : ImagesContainerDetailsScreen(
                      advertData: advertData,
                      imageContainerHeight: 272.5,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SelectableText(
                      "${advertData.title}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    SelectableText(
                      advertData.advertType == 'For Sale'
                          ? advertData.eachCheckbox == true
                              ? 'Asking price:\nUGX ${numberCommaFormatter.format(advertData.price)} each'
                              : 'Asking price:\nUGX ${numberCommaFormatter.format(advertData.price)}'
                          : advertData.eachCheckbox == true
                              ? 'Buying price:\nUGX ${numberCommaFormatter.format(advertData.price)} each'
                              : 'Buying price:\nUGX ${numberCommaFormatter.format(advertData.price)}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    advertData.quantity == null || advertData.quantity == 0
                        // advertData.quantity.isEmpty //This returns For Sale or Wanted
                        ? SelectableText(
                            advertData.advertType == 'For Sale'
                                ? 'For Sale'
                                : 'Wanted',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Qty ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            advertData.advertType == 'For Sale'
                                                ? 'For Sale: '
                                                : 'Wanted: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      TextSpan(
                                        text: '${advertData.quantity} ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: advertData.quantityUnit == null
                                            ? ''
                                            : '${advertData.quantityUnit}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  minFontSize: 8,
                                  maxLines: 1,
                                  maxFontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          '${advertData.advertPhoneNumber}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        advertData.whatsApp == true
                            ? Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.green,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        advertData.phoneCallOk == true
                            ? Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Icon(
                                    FontAwesomeIcons.phone,
                                    color: kColorTwo,
                                    size: 20,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(
                                  '"Location tapped\nshould go to map screen"');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.room_outlined),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: advertData.advertType == 'For Sale'
                                      ? Text(
                                          advertData.distance! > 1
                                              ? 'Seller located ${advertData.distance} miles in ${advertData.parish}, ${advertData.district}, Uganda'
                                              : 'Seller located ${advertData.distance} mile in ${advertData.parish}, ${advertData.district}, Uganda',
                                        )
                                      : Text(
                                          advertData.distance! > 1
                                              ? 'Buyer located ${advertData.distance} miles in ${advertData.parish}, ${advertData.district}, Uganda'
                                              : 'Buyer located ${advertData.distance} mile in ${advertData.parish}, ${advertData.district}, Uganda',
                                        ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time),
                              const SizedBox(width: 8),
                              SelectableText(
                                'Listed: ${kConvertDateTime(DateTime.parse(advertData.listed!))} ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    advertData.description == null
                        ? const SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Description',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              SelectableText(
                                '${advertData.description}',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                    // advertData.keywords == null
                    //     ? const SizedBox.shrink()
                    //     : Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SelectableText(
                    //             'Keywords',
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.bold),
                    //           ),
                    //           const SizedBox(height: 15),
                    //           SelectableText('${advertData.keywords}',
                    //               style: TextStyle(fontSize: 16))
                    //         ],
                    //       ),
                    AboutTheSellerOrBuyer(advertData: advertData),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

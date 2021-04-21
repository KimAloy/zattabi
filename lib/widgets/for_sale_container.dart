import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/widgets/widgets.dart';

class ForSaleContainerHasImage extends StatelessWidget {
  final Advert advertData;
  final Function onTap;
  final bool showWatchlistIcon;
  final bool showDistance;
  final bool showAdvertStatusSwitch;

  const ForSaleContainerHasImage({
    Key? key,
    required this.advertData,
    required this.onTap,
    this.showWatchlistIcon = true,
    this.showDistance = true,
    this.showAdvertStatusSwitch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: kScreenBackground,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 75,
                width: 75,
                child: Image.asset(
                  advertData.images![0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            showWatchlistIcon == false
                ? const SizedBox.shrink()
                : Positioned(
                    right: 8,
                    top: 5,
                    child: IconAddToWatchlist(advertData: advertData),
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  showAdvertStatusSwitch == false
                      ? const SizedBox.shrink()
                      : Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 85),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 13),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Ad Status: ',
                                              style: TextStyle(
                                                  color: Colors.black45)),
                                          TextSpan(
                                              text: advertData.adStatus == true
                                                  ? 'active'
                                                  : '',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          TextSpan(
                                              text: advertData.adStatus == false
                                                  ? 'not active'
                                                  : '',
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                  Flexible(
                    child: Row(
                      children: [
                        const SizedBox(width: 85),
                        showDistance == false
                            ? Text(
                                '${advertData.parish}, ${advertData.district}',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              )
                            : Container(
                                width: myWidth - 150,
                                child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${advertData.parish}, ${advertData.district}     ',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 13),
                                      ),
                                      TextSpan(
                                        text: advertData.distance! > 1
                                            ? '${advertData.distance} miles'
                                            : '${advertData.distance} mile',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        const SizedBox(width: 85),
                        Text(
                          'Listed: ${kConvertDateTime(DateTime.parse(advertData.listed!))}',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  advertData.quantity == null || advertData.quantity == 0
                      ? Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 85),
                                  Text(
                                    'For Sale',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        )
                      : Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 85),
                                  Text('Quantity For Sale: ',
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 13)),
                                  Text(
                                      '${numberCommaFormatter.format(advertData.quantity)}',
                                      style: TextStyle(fontSize: 13)),
                                  advertData.quantityUnit == null
                                      ? const SizedBox.shrink()
                                      : Text(' ${advertData.quantityUnit}',
                                          style: TextStyle(fontSize: 13)),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                  Flexible(
                    child: Row(
                      children: [
                        const SizedBox(width: 85),
                        Expanded(
                          child: Text(
                            "${advertData.title}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                        advertData.eachCheckbox == true
                            ? 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)} each'
                            : 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)}',
                        style: kPriceContainerTextStyle),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForSaleNoImageContainer extends StatelessWidget {
  final Advert advertData;
  final Function onTap;
  final bool showWatchlistIcon;
  final bool showDistance;
  final bool showAdvertStatusSwitch;

  const ForSaleNoImageContainer({
    Key? key,
    required this.advertData,
    required this.onTap,
    this.showWatchlistIcon = true,
    this.showDistance = true,
    this.showAdvertStatusSwitch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: kScreenBackground,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  showAdvertStatusSwitch == false
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ad Status: ',
                                        style:
                                            TextStyle(color: Colors.black45)),
                                    TextSpan(
                                        text: advertData.adStatus == true
                                            ? 'active'
                                            : '',
                                        style: TextStyle(color: Colors.blue)),
                                    TextSpan(
                                        text: advertData.adStatus == false
                                            ? 'not active'
                                            : '',
                                        style: TextStyle(color: Colors.red))
                                  ]),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                  showDistance == false
                      // TODO: Calculate distance automatically
                      ? Text(
                          '${advertData.parish}, ${advertData.district}',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        )
                      : RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${advertData.parish}, ${advertData.district}     ',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              advertData.distance! > 1
                                  ? TextSpan(
                                      text: '${advertData.distance} miles',
                                      style: TextStyle(fontSize: 13),
                                    )
                                  : TextSpan(
                                      text: '${advertData.distance} mile',
                                      style: TextStyle(fontSize: 13),
                                    ),
                            ],
                          ),
                        ),
                  Text(
                    'Listed: ${kConvertDateTime(DateTime.parse(advertData.listed!))}',
                    style: TextStyle(color: Colors.black45, fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  advertData.quantity == null || advertData.quantity == 0
                      ? Text(
                          'For Sale',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        )
                      : Row(
                          children: [
                            Text('Quantity For Sale: ',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13)),
                            Text(
                                '${numberCommaFormatter.format(advertData.quantity)}',
                                style: TextStyle(fontSize: 13)),
                            advertData.quantityUnit == null
                                ? const SizedBox.shrink()
                                : Text(' ${advertData.quantityUnit}',
                                    style: TextStyle(fontSize: 13)),
                          ],
                        ),
                  const SizedBox(height: 4),
                  Text(
                    "${advertData.title}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    advertData.eachCheckbox == true
                        ? 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)} each'
                        : 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)}',
                    style: kPriceContainerTextStyle,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            showWatchlistIcon == false
                ? const SizedBox.shrink()
                : Positioned(
                    right: 8,
                    top: 5,
                    child: IconAddToWatchlist(advertData: advertData)),
          ],
        ),
      ),
    );
  }
}

class AutoSizeTextContainerItems extends StatelessWidget {
  final String text1;
  final String text2;

  const AutoSizeTextContainerItems({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: text1,
            style: TextStyle(color: Colors.black45, fontSize: 13),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
      maxLines: 1,
      maxFontSize: 13,
      minFontSize: 8,
    );
  }
}

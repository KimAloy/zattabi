import 'package:flutter/material.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/models/models.dart';
import 'package:zattabi/widgets/widgets.dart';

class WantedContainer extends StatelessWidget {
  final Advert wantedData;
  final Function onTap;
  final bool showWatchlistIcon;
  final bool showDistance;
  final bool showAdvertStatusSwitch;

  const WantedContainer({
    Key? key,
    required this.wantedData,
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
                                        text: wantedData.adStatus == true
                                            ? 'active'
                                            : '',
                                        style: TextStyle(color: Colors.blue)),
                                    TextSpan(
                                        text: wantedData.adStatus == false
                                            ? 'not active'
                                            : '',
                                        style: TextStyle(color: Colors.red))
                                  ]),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                  showDistance == false
                      ? Text(
                          '${wantedData.parish}, ${wantedData.district}',
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
                                    '${wantedData.parish}, ${wantedData.district}     ',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              ),
                              wantedData.distance! > 1
                                  ? TextSpan(
                                      text: '${wantedData.distance} miles',
                                      style: TextStyle(fontSize: 13),
                                    )
                                  : TextSpan(
                                      text: '${wantedData.distance} mile',
                                      style: TextStyle(fontSize: 13),
                                    ),
                            ],
                          ),
                        ),
                  Text(
                    'Listed: ${kConvertDateTime(DateTime.parse(wantedData.listed!))}',
                    style: TextStyle(color: Colors.black45, fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  // wantedData.quantity.isEmpty
                  wantedData.quantity == null || wantedData.quantity == 0
                      ? Text('Wanted',
                          style: TextStyle(color: Colors.black45, fontSize: 13))
                      : Row(
                          children: [
                            Text('Quantity Wanted: ',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13)),
                            Text(
                                '${numberCommaFormatter.format(wantedData.quantity)}',
                                style: TextStyle(fontSize: 13)),
                            wantedData.quantityUnit == null
                                ? const SizedBox.shrink()
                                : Text(' ${wantedData.quantityUnit}',
                                    style: TextStyle(fontSize: 13)),
                          ],
                        ),
                  SizedBox(height: 4),
                  Text(
                    "${wantedData.title}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    wantedData.eachCheckbox == true
                        ? 'Buying price: UGX ${numberCommaFormatter.format(wantedData.price)} each'
                        : 'Buying price: UGX ${numberCommaFormatter.format(wantedData.price)}',
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
                    child: IconAddToWatchlist(advertData: wantedData),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../../domain/new_and_hot/model/hot_and_new_response.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class CommingSoonWidget extends StatelessWidget {
  final HotAndNewData data;
  const CommingSoonWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _date = DateTime.parse(data.releaseDate!);
    final formattedDate =  DateFormat.yMMMMd('en_US').format(_date);
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 500,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            kHeigth,
            Text(formattedDate.split(' ').first.substring(0,3),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey)),
            Text(
              data.releaseDate?.split('-').last ?? '-',
              style: TextStyle(
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )
          ]),
        ),
        SizedBox(
          width: size.width - 50,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(url: '$imageAppendURL${data.posterPath}'),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      data.title ?? '',
                      style: TextStyle(
                        letterSpacing: -4,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      CustomButtonWidget(
                        title: 'Remind me',
                        icon: Icons.alarm,
                        iconSize: 20,
                        textSize: 12,
                      ),
                      kWidth,
                      CustomButtonWidget(
                        title: 'Info',
                        icon: Icons.info,
                        iconSize: 20,
                        textSize: 12,
                      ),
                      kWidth,
                    ],
                  ),
                ],
              ),
              kHeigth,
              Text('Comming on ${data.releaseDate}'),
              kHeigth,
              Text(
                data.originalTitle ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              kHeigth,
              Text(
                data.overview ?? '',
                maxLines: 4,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ],
    );
  }
}

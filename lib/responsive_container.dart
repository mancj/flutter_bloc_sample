import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget Function(BuildContext context, bool isTablet) masterBuilder;
  final Widget detailScreen;

  const ResponsiveContainer(
      {@required this.masterBuilder, @required this.detailScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final flex = constraints.maxWidth < 820
          ? _MasterDetailFlex(1, 1)
          : _MasterDetailFlex(2, 4);
      if (!isTabletConstraints(constraints)) {
        return Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(child: masterBuilder(context, true), flex: flex.master),
            Container(
              width: 1,
              color: Colors.grey[200],
            ),
            Flexible(child: detailScreen, flex: flex.detail),
          ],
        );
      } else {
        return masterBuilder(context, false);
      }
    });
  }
}

class _MasterDetailFlex {
  int master;
  int detail;

  _MasterDetailFlex(this.master, this.detail);
}

const TABLET_EXT = 700;

bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= TABLET_EXT;

bool isTabletConstraints(BoxConstraints constraints) =>
    constraints.maxWidth >= TABLET_EXT;

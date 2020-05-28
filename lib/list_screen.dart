import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/detail_screen.dart';
import 'package:flutter_sample/responsive_container.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocProvider(
        create: (context) => ListBloc(),
        child: BlocBuilder<ListBloc, ListState>(
          builder: (context, state) => ResponsiveContainer(
            masterBuilder: (context, isTablet) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => BlocProvider.of<ListBloc>(context)
                            .add(ListEvent(index)),
                        child: Text(
                          "Item $index",
                          style: TextStyle(
                            color: state.itemIndex == index
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ));
                },
                itemCount: 10,
              );
            },
            detailScreen: DetailPage(),
          ),
        ),
      ),
    );
  }
}

class ListBloc extends Bloc<ListEvent, ListState> {
  @override
  ListState get initialState => ListState(2);

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    yield ListState(event.itemIndex);
  }
}

class ListEvent extends Equatable {
  @override
  List<Object> get props => [itemIndex];
  final int itemIndex;

  ListEvent(this.itemIndex);
}

class ListState extends Equatable {
  @override
  List<Object> get props => [itemIndex];
  final int itemIndex;

  ListState(this.itemIndex);
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_screen.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailBloc>(
      create: (_) => DetailBloc(),
      child: Builder(builder: (context) {
        return BlocListener<ListBloc, ListState>(
          listener: (_, state) =>
              context.bloc<DetailBloc>()..add(DetailEvent(state.itemIndex)),
          child: Center(
            child: DetailScreen(),
          ),
        );
      }),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
        return Text(
          "Item detail ${state.itemIndex}",
          style: TextStyle(color: Colors.white),
        );
      }),
    );
  }
}

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  @override
  DetailState get initialState {
    return DetailState(0);
  }

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    yield DetailState(event.itemIndex);
  }
}

class DetailEvent extends Equatable {
  final int itemIndex;

  @override
  List<Object> get props => [itemIndex];

  DetailEvent(this.itemIndex);
}

class DetailState extends Equatable {
  final int itemIndex;

  @override
  List<Object> get props => [itemIndex];

  DetailState(this.itemIndex);
}

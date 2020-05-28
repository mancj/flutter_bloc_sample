import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  int itemIndex;

  DetailPage(this.itemIndex);

  @override
  Widget build(BuildContext context) {
    final bloc = DetailBloc()..add(DetailEvent(itemIndex));
    return BlocProvider(
      create: (context) {
        return bloc;
      },
      child: Center(child: DetailScreen()),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
      return Text("Item detail ${state.itemIndex}");
    });
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
  int itemIndex;

  @override
  List<Object> get props => [itemIndex];

  DetailEvent(this.itemIndex);
}

class DetailState extends Equatable {
  int itemIndex;

  @override
  List<Object> get props => [itemIndex];

  DetailState(this.itemIndex);
}

import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends InheritedNotifier {

  final Model model;

  NotifierProvider({Key? key,required this.model,required Widget child}) : super(key: key,notifier: model, child: child);

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NotifierProvider<Model>>()?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget =  context.getElementForInheritedWidgetOfExactType<NotifierProvider<Model>>()?.widget;
    return widget is NotifierProvider<Model> ? widget.model : null;
  }
}

class Provider<Model> extends InheritedWidget {
  final Model model;
  Provider({Key? key,required this.model,required Widget child}) : super(key: key, child: child);

  static Provider? watch<Model>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<Model>>();
  }

  static Provider? read<Model>(BuildContext context) {
    final widget =  context.getElementForInheritedWidgetOfExactType<Provider<Model>>()?.widget;
    return widget is Provider<Model> ? widget : null;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return model!= oldWidget.model;
  }
}
import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'loader/lab_clinicas_loader.dart';

class LabClinicasCoreConfig extends StatelessWidget {
  const LabClinicasCoreConfig({
    super.key,
    this.binding,
    this.pagesRoute,
    this.pagesBuilders,
    this.modules,
    required this.title,
  });

  final ApplicationBindings? binding;
  final List<FlutterGetItPageRouter>? pagesRoute;
  final List<FlutterGetItPageBuilder>? pagesBuilders;
  final List<FlutterGetItModule>? modules;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      debugMode: true,
      bindings: binding,
      bindingsBuilder: () => [Bind.lazySingleton((i) => "batata")],
      pages: [...pagesRoute ?? [], ...pagesBuilders ?? []],
      modules: modules,
      builder: (context, routes, flutterGetItNavObserver) {
        return AsyncStateBuilder(
          loader: LabClinicasLoader(),
          builder: (navigatorObserver) {
            return MaterialApp(
              navigatorObservers: [navigatorObserver, flutterGetItNavObserver],
              routes: routes,
              title: title,
            );
          },
        );
        // return MaterialApp(
        // navigatorObservers: [flutterGetItNavObserver],
        // routes: routes,
        //  title: title,
        // );
      },
    );
  }
}

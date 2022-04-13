import 'package:ebg/ui/creation_fichier/newFile_screen.dart';
import 'package:ebg/ui/view_fichier/view_fichier_bloc.dart';
import 'package:ebg/ui/view_fichier/view_fichier_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../constants/routes.dart';
import '../../ui/creation_fichier/newFile_bloc.dart';
import '../../ui/home/home_screen.dart';
import '../../ui/home/myhome_bloc.dart';
import 'app_widget.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => HomeBloc()),
        Bind.singleton((i) => NewFileBloc()),
        Bind.singleton((i) => ViewFileBloc())
      ];

  // Provide all the routes for your module
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => HomeScreen()),
        ChildRoute(Routes.home,
            child: (context, args) => HomeScreen(),
            transition: TransitionType.fadeIn),
        ChildRoute(Routes.newFile,
            child: (context, args) => NewFileScreen(),
            transition: TransitionType.fadeIn),
        ChildRoute(Routes.viewFile,
            child: (context, args) => ViewFileScreen(),
            transition: TransitionType.fadeIn),
      ];

  // Provide the root widget associated with your module
  @override
  Widget get bootstrap => AppWidget();
}

import 'package:flutter/widgets.dart';
import 'package:jarmpnj/auth.dart';
import 'package:jarmpnj/pages/home_page.dart';
import 'package:jarmpnj/pages/login_or_register_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginOrRegisterPage();
        }
      },
    );
  }
}

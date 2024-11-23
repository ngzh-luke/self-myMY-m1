import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        ConnectionState,
        Scaffold,
        SizedBox,
        StatelessWidget,
        StreamBuilder,
        Theme,
        Widget,
        WidgetsBinding;
import 'package:go_router/go_router.dart' show GoRouterHelper;
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;

import 'package:mymy_m1/services/authentication/auth_service.dart'
    show AuthService;
import 'package:mymy_m1/services/authentication/user_session.dart'
    show UserSession;
import 'package:mymy_m1/ui/pages/authentication/login_and_register_screen.dart'
    show LoginAndRegisterScreen;
import 'package:mymy_m1/utils/dependency_inj/get_it.dart' show getIt;
import 'package:mymy_m1/utils/logger/logger_tool.dart' show LoggerTool;

class Start extends StatelessWidget {
  Start({super.key});

  final AuthService _auth = getIt<AuthService>();
  final UserSession _userSession = getIt<UserSession>();
  final LoggerTool _loggerTool = getIt<LoggerTool>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LoginAndRegisterScreen();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              try {
                context.goNamed("Home");
              } catch (e) {
                _loggerTool.d(debugMsg: '-Navigation error: $e');
              }
            });
            return const SizedBox.shrink();
          }
        }
        return Scaffold(
            body: Center(
                child: LoadingAnimationWidget.twoRotatingArc(
                    color: Theme.of(context).colorScheme.onSurface, size: 20)));
      },
    );
  }
}

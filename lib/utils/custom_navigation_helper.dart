import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/pages/account_page.dart';
import 'package:practise_ui/pages/adding_workspace.dart';
import 'package:practise_ui/pages/report_page.dart';
import 'package:practise_ui/pages/unverify_account.dart';
import 'package:practise_ui/pages/user_profile.dart';
import 'package:practise_ui/utils/bottom_navigation_bar.dart';

import '../pages/home_page.dart';
import '../pages/signin_page.dart';
import '../pages/signup_page.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
  CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> accountTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> addingTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> reportTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> anotherTabNavigatorKey =
  GlobalKey<NavigatorState>();

  BuildContext get context => router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser => router.routeInformationParser;


  static const String rootDetailPath = '/rootDetail';

  //tab
  static const String homePath = '/home';
  static const String accountPath = '/account';
  static const String addingWorkspacePath = '/adding';
  static const String reportPath= '/report';
  static const String anotherPath = '/another';

  //pages path
  static const String signUpPath = '/signUp';
  static const String signInPath = '/signIn';
  static const String userProfilePath = '/userProfile';

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
      final routes = [
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: parentNavigatorKey,
          branches: [
            StatefulShellBranch(
              navigatorKey: homeTabNavigatorKey,
              routes: [
                GoRoute(
                  path: homePath,
                  pageBuilder: (context, GoRouterState state) {
                    return getPage(
                      child: const HomePage(),
                      state: state,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: accountTabNavigatorKey,
              routes: [
                GoRoute(
                  path: accountPath,
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const AccountPage(),
                      state: state,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: addingTabNavigatorKey,
              routes: [
                GoRoute(
                  path: addingWorkspacePath,
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const AddingWorkspace(),
                      state: state,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: reportTabNavigatorKey,
              routes: [
                GoRoute(
                  path: reportPath,
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const ReportPage(),
                      state: state,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: anotherTabNavigatorKey,
              routes: [
                GoRoute(
                  path: anotherPath,
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const UserProfile(),
                      state: state,
                    );
                  },
                ),
              ],
            ),
          ],
          pageBuilder: (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell
              ) {
            return getPage(
              child: MyBottomNavigationBar(
                child: navigationShell,
              ),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: signUpPath,
          pageBuilder: (context, state) {
            return getPage(
              child: const SignUpPage(),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: signInPath,
          pageBuilder: (context, state) {
            return getPage(
              child: SignInPage(),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: userProfilePath,
          pageBuilder: (context, state) {
            return getPage(
              child: const UserProfile(),
              state: state,
            );
          },
        ),
      ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: homePath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
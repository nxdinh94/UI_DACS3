import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practise_ui/pages/account_wallet/account_page.dart';
import 'package:practise_ui/pages/account_setting_page.dart';
import 'package:practise_ui/pages/account_wallet/add_account_wallet_page.dart';
import 'package:practise_ui/pages/account_wallet/detail_account_wallet_page.dart';
import 'package:practise_ui/pages/account_wallet/select_account_wallet_type_page.dart';
import 'package:practise_ui/pages/account_wallet/select_bank_page.dart';
import 'package:practise_ui/pages/account_wallet/update_account_wallet_page.dart';
import 'package:practise_ui/pages/adding_workspace/choose_account_wallet_page.dart';
import 'package:practise_ui/pages/adding_workspace/update_workspace.dart';
import 'package:practise_ui/pages/auth/change_password_page.dart';
import 'package:practise_ui/pages/home_page/detail_spending_revenue_statistical_page/detail_cashflow_category_parent.dart';
import 'package:practise_ui/pages/home_page/detail_spending_revenue_statistical_page/detail_spending_revenue_statistical_page.dart';
import 'package:practise_ui/pages/home_page/noteHistory.dart';
import 'package:practise_ui/pages/report/current_finances.dart';
import 'package:practise_ui/pages/select_time_show_expense_record.dart';
import 'package:practise_ui/pages/spending_limit/add_spending_limit_page.dart';
import 'package:practise_ui/pages/adding_workspace/adding_workspace.dart';
import 'package:practise_ui/pages/spending_limit/choose_wallet_page.dart';
import 'package:practise_ui/pages/spending_limit/detail_spending_limit_item_page.dart';
import 'package:practise_ui/pages/spending_limit/detail_spending_page.dart';
import 'package:practise_ui/pages/spending_limit/list_spending_limit_item_page.dart';
import 'package:practise_ui/pages/spending_limit/repeat_cycle_page.dart';
import 'package:practise_ui/pages/report/report_page.dart';
import 'package:practise_ui/pages/adding_workspace/select_cashflow_category_page.dart';
import 'package:practise_ui/pages/spending_limit/update_spending_limit_page.dart';
import 'package:practise_ui/pages/user_profile.dart';
import 'package:practise_ui/utils/bottom_navigation_bar.dart';
import '../pages/home_page/home_page.dart';
import '../pages/auth/signin_page.dart';
import '../pages/auth/signup_page.dart';

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
  static const String accountWalletPath = '/account';
  static const String addingWorkspacePath = '/adding';
  static const String reportPath= '/report';
  static const String anotherPath = '/another';

  //pages path
  static const String signUpPath = '/signUp';
  static const String signInPath = '/signIn';

  static const String userProfilePath = 'userProfile';
  static const String detailSpendingLimitItemPath = '/detailSpendingLimitItem';
  static const String listSpendingLimitItemPath = '/listSpendingLimitItem';
  static const String addSpendingLimitPath = '/addSpendingLimit';
  static const String updateSpendingLimitPath = 'updateSpendingLimit';
  static const String editSpendingLimitPath = '/editSpendingLimit';
  static const String repeatCyclePath = '/repeatCycle';

  static const String accountSettingPath = '/accountSetting';
  static const String selectCategoryPath = 'selectCategory';


  static const String selectAccountWalletTypePath = 'selectAccountWalletType';
  static const String selectBankPath = 'selectBankPath';
  static const String addAccountWalletPath = 'addAccountWallet';
  static const String updateAccountWalletPath = 'updateAccountWallet';
  static const String chooseAccountWalletPath = 'chooseAccountWallet';
  static const String detailAccountWalletPath = 'detailAccountWallet';


  static const String detailSpendingRevenueStatisticalPath = 'detailSpendingRevenueStatistical';
  static const String detailCashFlowCategoryParentPath = 'detailCashFlowCategoryParent';
  static const String updateWorkSpacePath = '/updateWorkSpace';
  static const String noteHistoryPath = 'noteHistory';
  static const String selectTimeShowExpenseRecordPath = 'selectTimeShowExpenseRecord';

  static const String repeatTimeForSpendingLimitPath = 'repeatTimeForSpendingLimit';
  static const String selectWalletSpendingPath = 'selectWalletSpending';
  static const String changePasswordPath = 'changePassword';

  static const String detailSpendingInSpendingLimitPath = 'detailSpendingInSpendingLimit';
  static const String currentFinancesPath = 'currentFinances';



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
                  routes: <RouteBase>[
                    GoRoute(
                      path: detailSpendingRevenueStatisticalPath,
                      pageBuilder: (context, state) {
                        return getPage(
                          child: const DetailSpendingRevenueStatisticalPage(),
                          state: state
                        );
                      },
                    ),
                    GoRoute(
                      path: selectTimeShowExpenseRecordPath,
                      pageBuilder: (context, state) {
                        return getPage(
                            child: const SelectTimeShowExpenseRecord(),
                            state: state
                        );
                      },
                    ),

                    GoRoute(
                      path: detailCashFlowCategoryParentPath,
                      pageBuilder: (context, state) {
                        Map<String,dynamic> dataFromExtra = state.extra as Map<String, dynamic>;
                        return getPage(
                          child: DetailCashflowCategoryParent(
                            data:  dataFromExtra,
                          ),
                          state: state
                        );
                      },
                    ),
                    GoRoute(
                      path: noteHistoryPath,
                      pageBuilder: (context, state) {
                        return getPage(
                          child: const NoteHistory(),
                          state: state
                        );
                      },
                    )
                  ]
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: accountTabNavigatorKey,
              routes: [
                GoRoute(
                  path: accountWalletPath,
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const AccountPage(),
                      state: state,
                    );
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: addAccountWalletPath,
                      pageBuilder: (context, state){
                        return getPage(
                          child: const AddAccountWalletPage(),
                          state: state
                        );
                      },
                      routes: <RouteBase>[
                        GoRoute(
                          path: selectAccountWalletTypePath,
                          pageBuilder: (context, state){
                          return getPage(
                              child: const SelectAccountWalletTypePage(),
                              state: state
                            );
                          }
                        ),
                        GoRoute(
                          path: selectBankPath,
                          pageBuilder: (context, state){
                            return getPage(
                              child: const SelectBankPage(),
                              state: state
                            );
                          }
                        ),
                      ]
                    ),
                    GoRoute(
                      path: updateAccountWalletPath,
                      pageBuilder: (context, state){
                      Map<String, dynamic> dataFromExtra = state.extra as Map<String, dynamic>;

                      return getPage(
                          child: UpdateAccountWalletPage(
                            dataToUpdate: dataFromExtra,
                          ),
                          state: state
                        );
                      }
                    ),
                    GoRoute(
                      path: detailAccountWalletPath,
                      pageBuilder: (context, state){
                        Map<String,dynamic> dataFromExtra = state.extra as Map<String,dynamic>;
                        return getPage(
                          child: DetailAccountWalletPage(
                            accountWalletData: dataFromExtra
                          ),
                          state: state
                        );
                      }
                    ),
                    GoRoute(
                      path: selectTimeShowExpenseRecordPath,
                      pageBuilder: (context, state) {
                        return getPage(
                            child: const SelectTimeShowExpenseRecord(),
                            state: state
                        );
                      },
                    )
                  ]
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
                  routes: <RouteBase>[
                    GoRoute(
                      path: selectCategoryPath,
                      name: 'selectCategory',
                      pageBuilder: (context, state) {
                        String cashFlowType = state.extra.toString();
                        return getPage(
                          child: SelectCategoryPage(
                              cashFlowType: cashFlowType
                          ),
                          state: state,
                        );
                      },
                    ),
                    GoRoute(
                        path: chooseAccountWalletPath,
                        pageBuilder: (context, state){
                          return getPage(
                            child: const ChooseAccountWalletPage(),
                            state: state
                          );
                        }
                    )
                  ]
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
                  routes: <RouteBase>[
                    GoRoute(
                      path: currentFinancesPath,
                      pageBuilder: (context, state) {
                        return getPage(
                          child: CurrentFinances(),
                          state: state
                        );
                      },
                    )
                  ]
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: anotherTabNavigatorKey,
              routes: [
                GoRoute(
                  path: accountSettingPath,
                  pageBuilder: (context, state) {
                    return getPage(
                      child: const AccountSettingPage(),
                      state: state,
                    );
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: userProfilePath,
                      pageBuilder: (context, state){
                        return getPage(
                          child: const UserProfile(),
                          state: state
                        );
                      }
                    ),
                    GoRoute(
                      path: changePasswordPath,
                      pageBuilder: (context, state){
                        return getPage(
                          child: ChangePasswordPage(),
                          state: state
                        );
                      }
                    ),

                  ]
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
          path: detailSpendingLimitItemPath,
          pageBuilder: (context, state) {
            Map<String, dynamic> dataFromExtra = state.extra as Map<String, dynamic>;
            return getPage(
              child: DetailSpendingLimitItem(dataToPassSpendingLimitItemWidget: dataFromExtra),
              state: state,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: detailSpendingInSpendingLimitPath,
              pageBuilder: (context, state) {
                List<List<dynamic>> dataFromExtra = state.extra as List<List<dynamic>>;
                return getPage(
                  child: DetailSpendingPage(transformData: dataFromExtra),
                  state: state
                );
              },
            ),
            GoRoute(
              path: updateSpendingLimitPath,
              pageBuilder: (context, state) {
                Map<String, dynamic> dataFromExtra = state.extra as Map<String, dynamic>;
                return getPage(
                  child: UpdateSpendingLimitPage(dataToUpdate: dataFromExtra),
                  state: state
                );
              },
            ),

          ]
        ),
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: addSpendingLimitPath,
          pageBuilder: (context, state) {
            return getPage(
              child: const AddSpendingLimitPage(),
              state: state,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: repeatTimeForSpendingLimitPath,
              pageBuilder: (context, state){
                return getPage(
                  child: const RepeatCyclePage(),
                  state: state
                );
              }
            ),
            GoRoute(
              path: selectWalletSpendingPath,
              pageBuilder: (context, state) {
                return getPage(
                  child: const ChooseWalletPage(),
                  state: state
                );
              },
            )
          ]
        ),
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: editSpendingLimitPath,
          pageBuilder: (context, state) {
            return getPage(
              child: const AddSpendingLimitPage(),
              state: state,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: parentNavigatorKey,
          path: listSpendingLimitItemPath,
          pageBuilder: (context, state) {
            return getPage(
              child: const ListSpendingLimitItemPage(),
              state: state,
            );
          },
        ),
        GoRoute(
            path: updateWorkSpacePath,
            pageBuilder: (context, state){
              Map<String, dynamic> dataFromExtra = state.extra as Map<String, dynamic>;
              return getPage(
                  child: UpdateWorkspace(
                    dataToUpdate: dataFromExtra,
                  ),
                  state: state
              );
            }
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
    return CustomTransitionPage(
      child: child,
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
    );
  }
}
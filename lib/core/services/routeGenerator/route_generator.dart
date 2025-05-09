import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hospital_hr/features/admin_module/attendance_admin/screens/my_attendance_admin.dart';
import '../../../features/admin_module/admin_dashboard/screens/admin_dashboard_screen.dart';

import '../../../features/admin_module/attendance_admin/screens/dashboard_attendance_admin.dart';
import '../../../features/admin_module/auth_admin/screens/forgot_password.dart';
import '../../../features/admin_module/auth_admin/screens/admin_log_in.dart';
import '../../../features/admin_module/auth_admin/screens/otp.dart';
import '../../../features/admin_module/auth_admin/screens/reset_password.dart';
import '../../../features/admin_module/departments_admin/screens/add_department_admin.dart';
import '../../../features/admin_module/departments_admin/screens/dashboard_departments_admin.dart';
import '../../../features/admin_module/events_admin/screens/add_events_admin.dart';
import '../../../features/admin_module/events_admin/screens/dashboard_event_admin.dart';
import '../../../features/admin_module/events_admin/screens/edit_events_admin.dart';
import '../../../features/admin_module/notice_admin/screens/add_notice_admin.dart';
import '../../../features/admin_module/notice_admin/screens/dashboard_notice_admin.dart';
import '../../../features/admin_module/notice_admin/screens/edit_notice_admin.dart';
import '../../../features/admin_module/payroll_admin/screens/dashboard_payroll_admin.dart';
import '../../../features/admin_module/payroll_admin/screens/view_payroll_admin.dart';
import '../../../features/admin_module/users/screens/add_user_admin.dart';
import '../../../features/admin_module/users/screens/dashboard_users_admin.dart';
import '../../../features/admin_module/users/screens/edit_user_admin.dart';
import '../../../features/admin_module/users/screens/view_user_admin.dart';
import '../../../features/splash/screens/splash_screen.dart';
import '../../../features/user_module/attendance_user/screens/dashboard_attendance_user.dart';

import '../../../features/user_module/departments_user/screens/add_department.dart';
import '../../../features/user_module/departments_user/screens/dashboard_departments.dart';
import '../../../features/user_module/events_user/screens/dashboard_events_user.dart';
import '../../../features/user_module/notice_user/screens/dashboard_notice.dart';
import '../../../features/user_module/payroll_user/screens/dashboard_payroll_user.dart';
import '../../../features/user_module/payroll_user/screens/view_payroll_user.dart';
import '../../../features/user_module/profile/screens/profile_user.dart';
import '../../../features/user_module/user_dashboard/screens/user_dashboard_screen.dart';
import '../../utils/helper/app_fontSize.dart';

class RouteGenerator {
  // general navigation
  static const kSplashScreen = "/";
  static const kLogInTypeScreens = "/LogInTypeScreens";
  static const kAdminLogInScreens = "/AdminLogInScreens";
  static const kAdminForgotPassword = "/AdminForgotPassword";
  static const kAdminOTP = "/AdminOTP";
  static const kAdminResetPasswordScreens = "/AdminResetPasswordScreens";
  static const kUserLogInScreens = "/UserLogInScreens";
  static const kUserForgotPassword = "/UserForgotPassword";
  static const kUserOTP = "/UserOTP";
  static const kUserResetPasswordScreens = "/UserResetPasswordScreens";
  static const kUserHomeScreen = "/UserHomeScreen";
  static const kViewUser = "/ViewUser";
  static const kEditUser = "/EditUser";
  static const kDashboardDepartments = "/DashboardDepartments";
  static const kAddDepartment = "/AddDepartment";
  static const kDashboardNotice = "/DashboardNotice";
  static const kAddNotice = "/AddNotice";
  static const kEditNotice = "/EditNotice";
  static const kAdminHomeScreen = "/AdminHomeScreen";
  static const kViewDashboardAdmin = "/ViewDashboardAdmin";
  static const kEditDashboardAdmin = "/EditDashboardAdmin";
  static const kDashboardDepartmentsAdmin = "/DashboardDepartmentsAdmin";
  static const kAddDepartmentAdmin = "/AddDepartmentAdmin";
  static const kDashboardNoticeAdmin = "/DashboardNoticeAdmin";
  static const kEditNoticeAdmin = "/EditNoticeAdmin";
  static const kAddNoticeAdmin = "/AddNoticeAdmin";
  static const kProfileUser = "/ProfileUser";
  static const kDashboardAttendanceUser = "/DashboardAttendanceUser";
  static const kDashboardEvent = "/DashboardEvent";
  static const kDashboardPayrollUser = "/DashboardPayrollUser";
  static const kViewPayrollUser = "/ViewPayrollUser";
  static const kDashboardUser = "/DashboardUser";
  static const kDashboardUsersAdmin = "/DashboardUsersAdmin";
  static const kAddUserAdmin = "/AddUserAdmin";
  static const kEditUserAdmin = "/EditUserAdmin";
  static const kViewUserAdmin = "/ViewUserAdmin";
  static const kDashboardAttendanceAdmin = "/DashboardAttendanceAdmin";
  static const kDashboardEventAdmin = "/DashboardEventAdmin";
  static const kEditEventsAdmin = "/EditEventsAdmin";
  static const kAddEventsAdmin = "/AddEventsAdmin";
  static const kDashboardPayrollAdmin = "/DashboardPayrollAdmin";
  static const kViewPayrollAdmin = "/ViewPayrollAdmin";
  static const kDashboardAdmin = "/DashboardAdmin";
  static const kMyAttendanceAdmin = "/MyAttendanceAdmin";

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case kSplashScreen:
        //return MaterialPageRoute(builder: (_)=>SplashScreen());
        return _animatedPageRoute(SplashScreen());
      case kAdminLogInScreens:
        return _animatedPageRoute(AdminLogInScreens());
      case kAdminForgotPassword:
        return _animatedPageRoute(AdminForgotPassword());
      case kAdminOTP:
        return _animatedPageRoute(AdminOTP());
      case kAdminResetPasswordScreens:
        return _animatedPageRoute(AdminResetPasswordScreens());
      case kUserHomeScreen:
        return _animatedPageRoute(UserHomeScreen());
      case kDashboardDepartments:
        return _animatedPageRoute(DashboardDepartments());
      case kAddDepartment:
        return _animatedPageRoute(AddDepartment());
      case kDashboardNotice:
        return _animatedPageRoute(DashboardNotice());
      case kAdminHomeScreen:
        return _animatedPageRoute(AdminHomeScreen());

      case kDashboardDepartmentsAdmin:
        return _animatedPageRoute(DashboardDepartmentsAdmin());
      case kAddDepartmentAdmin:
        return _animatedPageRoute(AddDepartmentAdmin());
      case kDashboardNoticeAdmin:
        return _animatedPageRoute(DashboardNoticeAdmin());
      case kEditNoticeAdmin:
        return _animatedPageRoute(EditNoticeAdmin(noticeId: args as int,));
      case kAddNoticeAdmin:
        return _animatedPageRoute(AddNoticeAdmin());

      case kProfileUser:
        return _animatedPageRoute(ProfileUser());
      case kDashboardAttendanceUser:
        return _animatedPageRoute(DashboardAttendanceUser());
      case kDashboardEvent:
        return _animatedPageRoute(DashboardEvent());
      case kDashboardPayrollUser:
        return _animatedPageRoute(DashboardPayrollUser());
      case kViewPayrollUser:
        return _animatedPageRoute(ViewPayrollUser());

      case kDashboardUsersAdmin:
        return _animatedPageRoute(DashboardUsersAdmin());
      case kAddUserAdmin:
        return _animatedPageRoute(AddUserAdmin());
      case kEditUserAdmin:
        return _animatedPageRoute(EditUserAdmin());
      case kViewUserAdmin:
        return _animatedPageRoute(ViewUserAdmin(
          userId: args as int,
        ));
      case kDashboardAttendanceAdmin:
        return _animatedPageRoute(DashboardAttendanceAdmin());
      case kDashboardEventAdmin:
        return _animatedPageRoute(DashboardEventAdmin());
      case kEditEventsAdmin:
        return _animatedPageRoute(EditEventsAdmin(eventId: args as int,));
      case kAddEventsAdmin:
        return _animatedPageRoute(AddEventsAdmin());
      case kDashboardPayrollAdmin:
        return _animatedPageRoute(DashboardPayrollAdmin());
      case kViewPayrollAdmin:
        return _animatedPageRoute(ViewPayrollAdmin());

      case kMyAttendanceAdmin:
        return _animatedPageRoute(MyAttendanceAdmin());

      default:
        return _errorRoute(errorMessage: "Route not found: ${settings.name}");
    }
  }

  static Route<dynamic> _animatedPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page; // The page to navigate to
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the transition animation

        // Slide from the right (Offset animation)
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final curve = Curves.easeInToLinear; // A more natural easing curve

        var offsetTween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(offsetTween);

        // Scale transition (page zooms in slightly)
        var scaleTween = Tween(begin: 0.95, end: 1.0);
        var scaleAnimation = animation.drive(scaleTween);

        // Fade transition (opacity increases from 0 to 1)
        var fadeTween = Tween(begin: 0.0, end: 1.0);
        var fadeAnimation = animation.drive(fadeTween);

        // Return a combination of Slide, Fade, and Scale
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Material(
                color: Colors.transparent,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5.0, sigmaY: 5.0), // Add blur effect
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Route<dynamic> _errorRoute({
    String errorMessage = '',
  }) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Error",
            style: Theme.of(_)
                .textTheme
                .displayMedium
                ?.copyWith(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                "Oops something went wrong",
                style: Theme.of(_).textTheme.displayMedium?.copyWith(
                    fontSize: AppFontSize.textExtraLarge, color: Colors.black),
              ),
              Text(
                errorMessage,
                style: Theme.of(_).textTheme.displayMedium?.copyWith(
                    fontSize: AppFontSize.textExtraLarge, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    });
  }
}

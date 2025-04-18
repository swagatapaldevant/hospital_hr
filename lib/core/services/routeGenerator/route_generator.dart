import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../features/admin_module/admin_dashboard/screens/admin_dashboard_screen.dart';
import '../../../features/admin_module/admin_dashboard/screens/edit_dashboard_admin.dart';
import '../../../features/admin_module/admin_dashboard/screens/view_dashboard_admin.dart';
import '../../../features/admin_module/auth_admin/screens/forgot_password.dart';
import '../../../features/admin_module/auth_admin/screens/admin_log_in.dart';
import '../../../features/admin_module/auth_admin/screens/otp.dart';
import '../../../features/admin_module/auth_admin/screens/reset_password.dart';
import '../../../features/admin_module/departments_admin/screens/add_department_admin.dart';
import '../../../features/admin_module/departments_admin/screens/dashboard_departments_admin.dart';
import '../../../features/admin_module/notice_admin/screens/add_notice_admin.dart';
import '../../../features/admin_module/notice_admin/screens/dashboard_notice_admin.dart';
import '../../../features/admin_module/notice_admin/screens/edit_notice_admin.dart';
import '../../../features/login_type/screen/login_type.dart';
import '../../../features/splash/screens/splash_screen.dart';
import '../../../features/user_module/attendance_user/screens/dashboard_attendance_user.dart';
import '../../../features/user_module/auth_user/screens/forgot_password.dart';
import '../../../features/user_module/auth_user/screens/otp.dart';
import '../../../features/user_module/auth_user/screens/reset_password.dart';
import '../../../features/user_module/auth_user/screens/reset_password.dart';
import '../../../features/user_module/auth_user/screens/user_log_in.dart';
import '../../../features/user_module/dashboard_user/screens/dashboard_user.dart';
import '../../../features/user_module/departments_user/screens/add_department.dart';
import '../../../features/user_module/departments_user/screens/dashboard_departments.dart';
import '../../../features/user_module/events_user/screens/dashboard_events_user.dart';
import '../../../features/user_module/notice_user/screens/add_notice.dart';
import '../../../features/user_module/notice_user/screens/dashboard_notice.dart';
import '../../../features/user_module/notice_user/screens/edit_notice.dart';
import '../../../features/user_module/payroll_user/screens/dashboard_payroll_user.dart';
import '../../../features/user_module/payroll_user/screens/view_payroll_user.dart';
import '../../../features/user_module/profile/screens/profile_user.dart';
import '../../../features/user_module/user_dashboard/screens/edit_user.dart';
import '../../../features/user_module/user_dashboard/screens/user_dashboard_screen.dart';
import '../../../features/user_module/user_dashboard/screens/view_user.dart';
import '../../utils/helper/app_fontSize.dart';

class RouteGenerator {
  // general navigation
  static const kSplashScreen = "/SplashScreen";
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


  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case kSplashScreen:
        //return MaterialPageRoute(builder: (_)=>SplashScreen());
        return _animatedPageRoute(SplashScreen());
      case kLogInTypeScreens:
        return _animatedPageRoute(LogInTypeScreens());
        case kAdminLogInScreens:
        return _animatedPageRoute(AdminLogInScreens());
        case kAdminForgotPassword:
        return _animatedPageRoute(AdminForgotPassword());
        case kAdminOTP:
        return _animatedPageRoute(AdminOTP());
        case kAdminResetPasswordScreens:
        return _animatedPageRoute(AdminResetPasswordScreens());
case kUserLogInScreens:
        return _animatedPageRoute(UserLogInScreens());
        case kUserForgotPassword:
        return _animatedPageRoute(UserForgotPassword());
case kUserOTP:
        return _animatedPageRoute(UserOTP());
        case kUserResetPasswordScreens:
        return _animatedPageRoute(UserResetPasswordScreens());
        case kUserHomeScreen:
        return _animatedPageRoute(UserHomeScreen());
        case kViewUser:
        return _animatedPageRoute(ViewUser());
        case kEditUser:
        return _animatedPageRoute(EditUser());
        case kDashboardDepartments:
        return _animatedPageRoute(DashboardDepartments());
        case kAddDepartment:
        return _animatedPageRoute(AddDepartment());
      case kDashboardNotice:
        return _animatedPageRoute(DashboardNotice());
case kAddNotice:
        return _animatedPageRoute(AddNotice());
        case kEditNotice:
        return _animatedPageRoute(EditNotice());
case kAdminHomeScreen:
        return _animatedPageRoute(AdminHomeScreen());
case kViewDashboardAdmin:
        return _animatedPageRoute(ViewDashboardAdmin());
case kDashboardDepartmentsAdmin:
        return _animatedPageRoute(DashboardDepartmentsAdmin());
case kAddDepartmentAdmin:
        return _animatedPageRoute(AddDepartmentAdmin());
case kDashboardNoticeAdmin:
        return _animatedPageRoute(DashboardNoticeAdmin());
case kEditNoticeAdmin:
        return _animatedPageRoute(EditNoticeAdmin());
case kAddNoticeAdmin:
        return _animatedPageRoute(AddNoticeAdmin());
case kEditDashboardAdmin:
        return _animatedPageRoute(EditDashboardAdmin());
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
case kDashboardUser:
        return _animatedPageRoute(DashboardUser());


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

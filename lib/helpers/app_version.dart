
import 'package:package_info_plus/package_info_plus.dart';
class AppInfo{

  late String version;
   Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
   
    version= packageInfo.version;
     print(version);
  }
}

late AppInfo appInfo;

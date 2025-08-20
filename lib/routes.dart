import 'package:get/get.dart';
import 'package:remago/core/constant/routes.dart';
import 'package:remago/view/screen/home/home.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => Homepage()),
  GetPage(name: AppRoute.homepage, page: () => Homepage()),
];

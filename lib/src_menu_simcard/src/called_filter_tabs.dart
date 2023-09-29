import 'package:component_menu/src/api_sort.dart';

class CalledFilterTabs {
  Map<String, String> status = {
    'type': 'INCLUDE',
  };

  CalledFilterTabs(this.status);

  dynamic variable(ApiSort sort) {
    return {
      "orderBy": {"field": sort.name, "sort": sort.direction},
      "pagination": {"size": sort.limit, "page": sort.page},
      "status": status,
    };
  }

  @override
  String toString() {
    return 'Instance of CalledFilterTabs(status:$status)';
  }
}

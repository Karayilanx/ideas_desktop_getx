import 'table_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'home_model.g.dart';

@JsonSerializable()
class HomeGroupWithDetails {
  String? name;
  int? tableGroupId;
  List<TableWithDetails>? tables;
  bool? hasFastSellCheck;

  HomeGroupWithDetails({
    this.name,
    this.tableGroupId,
    this.tables,
    this.hasFastSellCheck,
  });

  factory HomeGroupWithDetails.fromJson(Map<String, dynamic> json) {
    return _$HomeGroupWithDetailsFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$HomeGroupWithDetailsToJson(this);
  }
}

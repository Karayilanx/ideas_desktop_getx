import 'package:json_annotation/json_annotation.dart';

import 'check_model.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class MenuItemCategory {
  int? menuItemCategoryId;
  String? nameTr;
  String? nameEn;
  List<MenuItemSubCategory>? menuItemSubCategories;

  MenuItemCategory(
      {this.menuItemCategoryId,
      this.menuItemSubCategories,
      this.nameEn,
      this.nameTr});

  factory MenuItemCategory.fromJson(Map<String, dynamic> json) {
    return _$MenuItemCategoryFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$MenuItemCategoryToJson(this);
  }
}

@JsonSerializable()
class MenuItemSubCategory {
  int? menuItemSubCategoryId;
  String? nameTr;
  String? nameEn;
  bool? isStopDefault;
  List<MenuItem>? menuItems;
  MenuItemSubCategory({
    this.menuItemSubCategoryId,
    this.menuItems,
    this.nameEn,
    this.nameTr,
    this.isStopDefault,
  });

  factory MenuItemSubCategory.fromJson(Map<String, dynamic> json) {
    return _$MenuItemSubCategoryFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$MenuItemSubCategoryToJson(this);
  }
}

@JsonSerializable()
class MenuItem {
  int? menuItemId;
  String? nameTr;
  String? nameEn;
  double price;
  double priceToShow;
  DefaultSellUnitModel? sellUnit;
  List<CondimentGroup>? condimentGroups;
  List<String>? barcodes;
  bool? isCategoryStoppedDefault;

  MenuItem({
    this.menuItemId,
    this.nameEn,
    this.nameTr,
    required this.price,
    this.condimentGroups,
    this.sellUnit,
    this.barcodes,
    this.isCategoryStoppedDefault,
    required this.priceToShow,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return _$MenuItemFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$MenuItemToJson(this);
  }
}

@JsonSerializable()
class CondimentGroup {
  int? condimentGroupId;
  String? nameTr;
  String? nameEn;
  bool? isRequired;
  bool? isMultiple;
  int? minCount;
  int? maxCount;
  List<int>? prerequisiteCondimentIds;
  List<CondimentModel>? condiments;
  int? basketGroupId;
  int? parentBasketGroupId;
  bool? isIngredient;
  CondimentGroup({
    this.condimentGroupId,
    this.isMultiple,
    this.isRequired,
    this.maxCount,
    this.minCount,
    this.nameEn,
    this.nameTr,
    this.prerequisiteCondimentIds,
    this.condiments,
    this.basketGroupId,
    this.parentBasketGroupId,
    this.isIngredient,
  });

  factory CondimentGroup.fromJson(Map<String, dynamic> json) {
    return _$CondimentGroupFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CondimentGroupToJson(this);
  }
}

@JsonSerializable()
class DefaultSellUnitModel {
  int? defaultSellUnitId;
  String? name;
  bool? isFloating;
  DefaultSellUnitModel({
    this.defaultSellUnitId,
    this.name,
    this.isFloating,
  });

  factory DefaultSellUnitModel.fromJson(Map<String, dynamic> json) {
    return _$DefaultSellUnitModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$DefaultSellUnitModelToJson(this);
  }
}

@JsonSerializable()
class MenuItemLocalPrinterMappingModel {
  int? menuItemPrinterMappingId;
  int? serverMenuItemPrinterMappingId;
  String? printerName;
  int? printerId;
  int? serverPrinterId;

  MenuItemLocalPrinterMappingModel({
    this.menuItemPrinterMappingId,
    this.printerId,
    this.printerName,
    this.serverMenuItemPrinterMappingId,
    this.serverPrinterId,
  });

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

  @override
  int get hashCode => printerId.hashCode;

  factory MenuItemLocalPrinterMappingModel.fromJson(Map<String, dynamic> json) {
    return _$MenuItemLocalPrinterMappingModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$MenuItemLocalPrinterMappingModelToJson(this);
  }
}

@JsonSerializable()
class MenuItemLocalEditModel {
  int? menuItemId;
  bool? isVisible;
  String? nameTr;
  String? categoryName;
  int? categoryId;
  String? subCategoryName;
  int? subCategoryId;
  String? nameEn;
  double? price;
  int? branchId;
  int? serverBranchId;
  int? serverMenuItemId;
  bool? topList;
  List<MenuItemLocalPrinterMappingModel>? printerMappings;
  MenuItemLocalEditModel({
    this.categoryId,
    this.categoryName,
    this.isVisible,
    this.menuItemId,
    this.nameEn,
    this.nameTr,
    this.price,
    this.subCategoryId,
    this.subCategoryName,
    this.branchId,
    this.serverBranchId,
    this.serverMenuItemId,
    this.printerMappings,
    this.topList,
  });

  factory MenuItemLocalEditModel.fromJson(Map<String, dynamic> json) {
    return _$MenuItemLocalEditModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$MenuItemLocalEditModelToJson(this);
  }
}

@JsonSerializable()
class PriceChangeItemModel {
  int? branchId;
  String? categoryName;
  String? subCategoryName;
  int? menuItemId;
  int? condimentId;
  String? name;
  double? price;
  bool? isPriceToShow;

  PriceChangeItemModel({
    this.branchId,
    this.categoryName,
    this.condimentId,
    this.isPriceToShow,
    this.menuItemId,
    this.name,
    this.price,
    this.subCategoryName,
  });

  factory PriceChangeItemModel.fromJson(Map<String, dynamic> json) {
    return _$PriceChangeItemModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$PriceChangeItemModelToJson(this);
  }
}

@JsonSerializable()
class PriceChangeModel {
  int? branchId;
  List<String>? categories;
  List<String>? subCategories;
  List<PriceChangeItemModel>? items;

  PriceChangeModel({
    this.branchId,
    this.categories,
    this.items,
    this.subCategories,
  });

  factory PriceChangeModel.fromJson(Map<String, dynamic> json) {
    return _$PriceChangeModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$PriceChangeModelToJson(this);
  }
}

@JsonSerializable()
class CreateMenuItemModel {
  List<int>? condimentGroupIds;
  List<int>? branchGroupIds;
  int? subCategoryId;
  int? qrSubCategoryId;
  bool? hasStock;
  bool? hasPortion;
  bool? isChainMenuItem;
  double? kdv;
  String? barcode;
  int? defaultSellUnitId;
  List<PortionListItemInput>? portions;
  List<int>? printerIds;
  int? branchId;
  int? stockRecipeId;
  int? menuItemId;
  String? nameTr;
  String? nameEn;
  String? qrNameTr;
  String? qrNameEn;
  String? descriptionTr;
  String? descriptionEn;
  double? price;
  CreateMenuItemModel({
    this.branchId,
    this.barcode,
    this.condimentGroupIds,
    this.defaultSellUnitId,
    this.descriptionEn,
    this.descriptionTr,
    this.hasPortion,
    this.hasStock,
    this.isChainMenuItem,
    this.kdv,
    this.menuItemId,
    this.nameEn,
    this.nameTr,
    this.portions,
    this.price,
    this.printerIds,
    this.qrNameEn,
    this.qrNameTr,
    this.qrSubCategoryId,
    this.stockRecipeId,
    this.subCategoryId,
    this.branchGroupIds,
  });

  factory CreateMenuItemModel.fromJson(Map<String, dynamic> json) {
    return _$CreateMenuItemModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CreateMenuItemModelToJson(this);
  }
}

@JsonSerializable()
class PortionListItemInput {
  int? condimentId;
  String? portionName;
  double? price;
  bool? isPriceToShow;
  bool? isActive;

  PortionListItemInput({
    this.condimentId,
    this.isActive,
    this.isPriceToShow,
    this.portionName,
    this.price,
  });

  factory PortionListItemInput.fromJson(Map<String, dynamic> json) {
    return _$PortionListItemInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$PortionListItemInputToJson(this);
  }
}

@JsonSerializable()
class AddMenuItemCategoryModel {
  int? branchId;
  int? menuItemCategoryId;
  String? nameTr;
  String? nameEn;

  AddMenuItemCategoryModel(
      {this.nameEn, this.branchId, this.menuItemCategoryId, this.nameTr});

  factory AddMenuItemCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$AddMenuItemCategoryModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$AddMenuItemCategoryModelToJson(this);
  }
}

@JsonSerializable()
class AddMenuItemSubCategoryModel {
  int? branchId;
  int? menuItemCategoryId;
  String? nameTr;
  String? nameEn;
  int? menuItemSubCategoryId;
  bool? isStopDefault;
  AddMenuItemSubCategoryModel({
    this.nameEn,
    this.branchId,
    this.menuItemCategoryId,
    this.nameTr,
    this.isStopDefault,
    this.menuItemSubCategoryId,
  });

  factory AddMenuItemSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$AddMenuItemSubCategoryModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$AddMenuItemSubCategoryModelToJson(this);
  }
}

@JsonSerializable()
class CondimentGroupForEditOutput {
  int? condimentGroupId;
  int? branchId;
  String? nameTr;
  String? nameEn;
  DateTime? createDate;
  bool? isActive;
  bool? isRequired;
  bool? isMultiple;
  int? minCount;
  int? maxCount;
  bool? isPortion;
  bool? isIngredient;
  List<CondimentCondimentGroupMappingForEditOutput>?
      condimentCondimentGroupMappings;
  List<PrerequisiteCondimentMappingForEditOutput>?
      prerequisiteCondimentMappings;
  List<MenuItemCondimentGroupMappingForEditOutput>?
      menuItemCondimentGroupMappings;
  int? chainCondimentGroupId;
  CondimentGroupForEditOutput({
    this.branchId,
    this.chainCondimentGroupId,
    this.condimentCondimentGroupMappings,
    this.condimentGroupId,
    this.createDate,
    this.isActive,
    this.isIngredient,
    this.isMultiple,
    this.isPortion,
    this.isRequired,
    this.maxCount,
    this.menuItemCondimentGroupMappings,
    this.minCount,
    this.nameEn,
    this.nameTr,
    this.prerequisiteCondimentMappings,
  });

  factory CondimentGroupForEditOutput.fromJson(Map<String, dynamic> json) {
    return _$CondimentGroupForEditOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CondimentGroupForEditOutputToJson(this);
  }
}

@JsonSerializable()
class PrerequisiteCondimentMappingForEditOutput {
  int? prerequisiteCondimentMappingId;
  int? branchId;
  int? condimentId;
  int? condimentGroupId;
  CondimentForEditOutput? condiment;
  CondimentGroupForEditOutput? condimentGroup;
  PrerequisiteCondimentMappingForEditOutput({
    this.branchId,
    this.condiment,
    this.condimentGroup,
    this.condimentGroupId,
    this.condimentId,
    this.prerequisiteCondimentMappingId,
  });

  factory PrerequisiteCondimentMappingForEditOutput.fromJson(
      Map<String, dynamic> json) {
    return _$PrerequisiteCondimentMappingForEditOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$PrerequisiteCondimentMappingForEditOutputToJson(this);
  }
}

@JsonSerializable()
class CondimentForEditOutput {
  int? condimentId;
  int? branchId;
  String? nameTr;
  String? nameEn;
  bool? isActive;
  double? price;
  bool? isPortion;
  bool? hasStockCard;
  double? portionMultiplier;
  int? menuItemId;
  bool? isIngredient;
  MenuItemForCondimentGroupEdit? menuItem;
  List<CondimentCondimentGroupMappingForEditOutput>?
      condimentCondimentGroupMappings;
  List<PrerequisiteCondimentMappingForEditOutput>?
      prerequisiteCondimentMappings;
  List<int>? branchGroupIds;
  int? chainCondimentId;
  CondimentForEditOutput({
    this.branchGroupIds,
    this.branchId,
    this.chainCondimentId,
    this.condimentCondimentGroupMappings,
    this.condimentId,
    this.hasStockCard,
    this.isActive,
    this.isIngredient,
    this.isPortion,
    this.menuItem,
    this.menuItemId,
    this.nameEn,
    this.nameTr,
    this.portionMultiplier,
    this.prerequisiteCondimentMappings,
    this.price,
  });

  factory CondimentForEditOutput.fromJson(Map<String, dynamic> json) {
    return _$CondimentForEditOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CondimentForEditOutputToJson(this);
  }
}

@JsonSerializable()
class MenuItemForCondimentGroupEdit {
  int? menuItemId;
  int? branchId;
  String? nameTr;
  String? nameEn;
  double? price;
  double? priceToShow;
  MenuItemForCondimentGroupEdit({
    this.branchId,
    this.menuItemId,
    this.nameEn,
    this.nameTr,
    this.price,
    this.priceToShow,
  });

  factory MenuItemForCondimentGroupEdit.fromJson(Map<String, dynamic> json) {
    return _$MenuItemForCondimentGroupEditFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$MenuItemForCondimentGroupEditToJson(this);
  }
}

@JsonSerializable()
class CondimentCondimentGroupMappingForEditOutput {
  int? condimentCondimentGroupMappingId;
  int? branchId;
  int? condimentId;
  int? condimentGroupId;
  CondimentForEditOutput? condiment;
  CondimentGroupForEditOutput? condimentGroup;
  CondimentCondimentGroupMappingForEditOutput({
    this.branchId,
    this.condiment,
    this.condimentCondimentGroupMappingId,
    this.condimentGroup,
    this.condimentGroupId,
    this.condimentId,
  });

  factory CondimentCondimentGroupMappingForEditOutput.fromJson(
      Map<String, dynamic> json) {
    return _$CondimentCondimentGroupMappingForEditOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CondimentCondimentGroupMappingForEditOutputToJson(this);
  }
}

@JsonSerializable()
class MenuItemCondimentGroupMappingForEditOutput {
  int? menuItemCondimentGroupMappingId;
  int? branchId;
  int? menuItemId;
  int? condimentGroupId;
  DateTime? createDate;
  int? orderNumber;
  MenuItemForCondimentGroupEdit? menuItem;
  MenuItemCondimentGroupMappingForEditOutput({
    this.branchId,
    this.condimentGroupId,
    this.createDate,
    this.menuItem,
    this.menuItemCondimentGroupMappingId,
    this.menuItemId,
    this.orderNumber,
  });

  factory MenuItemCondimentGroupMappingForEditOutput.fromJson(
      Map<String, dynamic> json) {
    return _$MenuItemCondimentGroupMappingForEditOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$MenuItemCondimentGroupMappingForEditOutputToJson(this);
  }
}

@JsonSerializable()
class GetCategoriesOutput {
  List<SubCategoryWithMenuItemsOutput>? menuItemSubCategories;
  String? nameTr;
  String? nameEn;
  String? qrNameTr;
  String? qrNameEn;
  int? menuItemCategoryId;
  GetCategoriesOutput(
      {this.menuItemCategoryId,
      this.menuItemSubCategories,
      this.nameEn,
      this.nameTr,
      this.qrNameEn,
      this.qrNameTr});

  factory GetCategoriesOutput.fromJson(Map<String, dynamic> json) {
    return _$GetCategoriesOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetCategoriesOutputToJson(this);
  }
}

@JsonSerializable()
class SubCategoryWithMenuItemsOutput {
  List<GetCategoriesMenuItemOutput>? menuItems;
  String? nameTr;
  String? nameEn;
  String? qrNameTr;
  String? qrNameEn;
  int? menuItemSubCategoryId;
  int? qrMenuItemSubCategoryId;
  bool? isStoppedDefault;
  SubCategoryWithMenuItemsOutput({
    this.menuItemSubCategoryId,
    this.menuItems,
    this.nameEn,
    this.nameTr,
    this.qrNameEn,
    this.qrNameTr,
    this.isStoppedDefault,
    this.qrMenuItemSubCategoryId,
  });

  factory SubCategoryWithMenuItemsOutput.fromJson(Map<String, dynamic> json) {
    return _$SubCategoryWithMenuItemsOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$SubCategoryWithMenuItemsOutputToJson(this);
  }
}

@JsonSerializable()
class GetCategoriesMenuItemOutput {
  List<GetCategoriesCondimentGroupOutput>? condimentGroups;
  List<String>? barcodes;
  String? printerName;
  double? kdv;
  bool? isVisible;
  bool? isCategoryStoppedDefault;
  double? priceToShow;
  int? menuItemId;
  String? nameTr;
  String? nameEn;
  String? qrNameTr;
  String? qrNameEn;
  String? descriptionTr;
  String? descriptionEn;
  double? price;
  GetCategoriesMenuItemOutput({
    this.barcodes,
    this.condimentGroups,
    this.isCategoryStoppedDefault,
    this.isVisible,
    this.kdv,
    this.priceToShow,
    this.printerName,
    this.descriptionEn,
    this.descriptionTr,
    this.menuItemId,
    this.nameEn,
    this.nameTr,
    this.price,
    this.qrNameEn,
    this.qrNameTr,
  });

  factory GetCategoriesMenuItemOutput.fromJson(Map<String, dynamic> json) {
    return _$GetCategoriesMenuItemOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetCategoriesMenuItemOutputToJson(this);
  }
}

@JsonSerializable()
class GetCategoriesCondimentGroupOutput {
  int? menuItemId;
  int? basketGroupId;
  int? parentBasketGroupId;
  List<CondimentModel>? condiments;
  bool? isIngredient;
  int? condimentGroupId;
  String? nameTr;
  String? nameEn;
  bool? isRequired;
  bool? isMultiple;
  int? minCount;
  int? maxCount;
  List<int>? condimentIds;
  List<int>? prerequisiteCondimentIds;
  bool? isPortion;
  GetCategoriesCondimentGroupOutput({
    this.basketGroupId,
    this.condimentGroupId,
    this.condimentIds,
    this.condiments,
    this.isIngredient,
    this.isMultiple,
    this.isPortion,
    this.isRequired,
    this.maxCount,
    this.menuItemId,
    this.minCount,
    this.nameEn,
    this.nameTr,
    this.parentBasketGroupId,
    this.prerequisiteCondimentIds,
  });

  factory GetCategoriesCondimentGroupOutput.fromJson(
      Map<String, dynamic> json) {
    return _$GetCategoriesCondimentGroupOutputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetCategoriesCondimentGroupOutputToJson(this);
  }
}

@JsonSerializable()
class CreateCondimentGroupInput {
  int? branchId;
  List<int>? menuItemIds;
  List<int>? mappedMenuItemIds;
  int? condimentGroupId;
  String? nameTr;
  String? nameEn;
  bool? isRequired;
  bool? isMultiple;
  int? minCount;
  int? maxCount;
  List<int>? condimentIds;
  List<int>? prerequisiteCondimentIds;
  bool? isPortion;
  CreateCondimentGroupInput({
    this.condimentGroupId,
    this.condimentIds,
    this.isMultiple,
    this.isPortion,
    this.isRequired,
    this.maxCount,
    this.minCount,
    this.nameEn,
    this.nameTr,
    this.prerequisiteCondimentIds,
    this.branchId,
    this.mappedMenuItemIds,
    this.menuItemIds,
  });

  factory CreateCondimentGroupInput.fromJson(Map<String, dynamic> json) {
    return _$CreateCondimentGroupInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CreateCondimentGroupInputToJson(this);
  }
}

@JsonSerializable()
class CreateCondimentInput {
  int? branchId;
  List<int>? condimentGroupIds;
  int? condimentId;
  String? nameTr;
  String? nameEn;
  double? price;
  CreateCondimentInput({
    this.nameEn,
    this.nameTr,
    this.branchId,
    this.condimentGroupIds,
    this.condimentId,
    this.price,
  });

  factory CreateCondimentInput.fromJson(Map<String, dynamic> json) {
    return _$CreateCondimentInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CreateCondimentInputToJson(this);
  }
}

@JsonSerializable()
class CreateMenuItemNoteInput {
  String? note;
  List<int>? subCategoryIds;
  int? branchId;

  CreateMenuItemNoteInput({
    this.note,
    this.subCategoryIds,
    this.branchId,
  });

  factory CreateMenuItemNoteInput.fromJson(Map<String, dynamic> json) {
    return _$CreateMenuItemNoteInputFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$CreateMenuItemNoteInputToJson(this);
  }
}

@JsonSerializable()
class GetNotesModel {
  List<String>? notes;

  GetNotesModel({
    this.notes,
  });

  factory GetNotesModel.fromJson(Map<String, dynamic> json) {
    return _$GetNotesModelFromJson(json);
  }

  Map<String, Object?> toJson() {
    return _$GetNotesModelToJson(this);
  }
}

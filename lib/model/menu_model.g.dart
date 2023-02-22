// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemCategory _$MenuItemCategoryFromJson(Map<String, dynamic> json) =>
    MenuItemCategory(
      menuItemCategoryId: json['menuItemCategoryId'] as int?,
      menuItemSubCategories: (json['menuItemSubCategories'] as List<dynamic>?)
          ?.map((e) => MenuItemSubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
    );

Map<String, dynamic> _$MenuItemCategoryToJson(MenuItemCategory instance) =>
    <String, dynamic>{
      'menuItemCategoryId': instance.menuItemCategoryId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'menuItemSubCategories': instance.menuItemSubCategories,
    };

MenuItemSubCategory _$MenuItemSubCategoryFromJson(Map<String, dynamic> json) =>
    MenuItemSubCategory(
      menuItemSubCategoryId: json['menuItemSubCategoryId'] as int?,
      menuItems: (json['menuItems'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      isStopDefault: json['isStopDefault'] as bool?,
    );

Map<String, dynamic> _$MenuItemSubCategoryToJson(
        MenuItemSubCategory instance) =>
    <String, dynamic>{
      'menuItemSubCategoryId': instance.menuItemSubCategoryId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'isStopDefault': instance.isStopDefault,
      'menuItems': instance.menuItems,
    };

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      menuItemId: json['menuItemId'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      price: (json['price'] as num).toDouble(),
      condimentGroups: (json['condimentGroups'] as List<dynamic>?)
          ?.map((e) => CondimentGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      sellUnit: json['sellUnit'] == null
          ? null
          : DefaultSellUnitModel.fromJson(
              json['sellUnit'] as Map<String, dynamic>),
      barcodes: (json['barcodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isCategoryStoppedDefault: json['isCategoryStoppedDefault'] as bool?,
      priceToShow: (json['priceToShow'] as num).toDouble(),
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'price': instance.price,
      'priceToShow': instance.priceToShow,
      'sellUnit': instance.sellUnit,
      'condimentGroups': instance.condimentGroups,
      'barcodes': instance.barcodes,
      'isCategoryStoppedDefault': instance.isCategoryStoppedDefault,
    };

CondimentGroup _$CondimentGroupFromJson(Map<String, dynamic> json) =>
    CondimentGroup(
      condimentGroupId: json['condimentGroupId'] as int?,
      isMultiple: json['isMultiple'] as bool?,
      isRequired: json['isRequired'] as bool?,
      maxCount: json['maxCount'] as int?,
      minCount: json['minCount'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      prerequisiteCondimentIds:
          (json['prerequisiteCondimentIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      condiments: (json['condiments'] as List<dynamic>?)
          ?.map((e) => CondimentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      basketGroupId: json['basketGroupId'] as int?,
      parentBasketGroupId: json['parentBasketGroupId'] as int?,
      isIngredient: json['isIngredient'] as bool?,
    );

Map<String, dynamic> _$CondimentGroupToJson(CondimentGroup instance) =>
    <String, dynamic>{
      'condimentGroupId': instance.condimentGroupId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'isRequired': instance.isRequired,
      'isMultiple': instance.isMultiple,
      'minCount': instance.minCount,
      'maxCount': instance.maxCount,
      'prerequisiteCondimentIds': instance.prerequisiteCondimentIds,
      'condiments': instance.condiments,
      'basketGroupId': instance.basketGroupId,
      'parentBasketGroupId': instance.parentBasketGroupId,
      'isIngredient': instance.isIngredient,
    };

DefaultSellUnitModel _$DefaultSellUnitModelFromJson(
        Map<String, dynamic> json) =>
    DefaultSellUnitModel(
      defaultSellUnitId: json['defaultSellUnitId'] as int?,
      name: json['name'] as String?,
      isFloating: json['isFloating'] as bool?,
    );

Map<String, dynamic> _$DefaultSellUnitModelToJson(
        DefaultSellUnitModel instance) =>
    <String, dynamic>{
      'defaultSellUnitId': instance.defaultSellUnitId,
      'name': instance.name,
      'isFloating': instance.isFloating,
    };

MenuItemLocalPrinterMappingModel _$MenuItemLocalPrinterMappingModelFromJson(
        Map<String, dynamic> json) =>
    MenuItemLocalPrinterMappingModel(
      menuItemPrinterMappingId: json['menuItemPrinterMappingId'] as int?,
      printerId: json['printerId'] as int?,
      printerName: json['printerName'] as String?,
      serverMenuItemPrinterMappingId:
          json['serverMenuItemPrinterMappingId'] as int?,
      serverPrinterId: json['serverPrinterId'] as int?,
    );

Map<String, dynamic> _$MenuItemLocalPrinterMappingModelToJson(
        MenuItemLocalPrinterMappingModel instance) =>
    <String, dynamic>{
      'menuItemPrinterMappingId': instance.menuItemPrinterMappingId,
      'serverMenuItemPrinterMappingId': instance.serverMenuItemPrinterMappingId,
      'printerName': instance.printerName,
      'printerId': instance.printerId,
      'serverPrinterId': instance.serverPrinterId,
    };

MenuItemLocalEditModel _$MenuItemLocalEditModelFromJson(
        Map<String, dynamic> json) =>
    MenuItemLocalEditModel(
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      isVisible: json['isVisible'] as bool?,
      menuItemId: json['menuItemId'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      subCategoryId: json['subCategoryId'] as int?,
      subCategoryName: json['subCategoryName'] as String?,
      branchId: json['branchId'] as int?,
      serverBranchId: json['serverBranchId'] as int?,
      serverMenuItemId: json['serverMenuItemId'] as int?,
      printerMappings: (json['printerMappings'] as List<dynamic>?)
          ?.map((e) => MenuItemLocalPrinterMappingModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      topList: json['topList'] as bool?,
    );

Map<String, dynamic> _$MenuItemLocalEditModelToJson(
        MenuItemLocalEditModel instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'isVisible': instance.isVisible,
      'nameTr': instance.nameTr,
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
      'subCategoryName': instance.subCategoryName,
      'subCategoryId': instance.subCategoryId,
      'nameEn': instance.nameEn,
      'price': instance.price,
      'branchId': instance.branchId,
      'serverBranchId': instance.serverBranchId,
      'serverMenuItemId': instance.serverMenuItemId,
      'topList': instance.topList,
      'printerMappings': instance.printerMappings,
    };

PriceChangeItemModel _$PriceChangeItemModelFromJson(
        Map<String, dynamic> json) =>
    PriceChangeItemModel(
      branchId: json['branchId'] as int?,
      categoryName: json['categoryName'] as String?,
      condimentId: json['condimentId'] as int?,
      isPriceToShow: json['isPriceToShow'] as bool?,
      menuItemId: json['menuItemId'] as int?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      subCategoryName: json['subCategoryName'] as String?,
    );

Map<String, dynamic> _$PriceChangeItemModelToJson(
        PriceChangeItemModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'categoryName': instance.categoryName,
      'subCategoryName': instance.subCategoryName,
      'menuItemId': instance.menuItemId,
      'condimentId': instance.condimentId,
      'name': instance.name,
      'price': instance.price,
      'isPriceToShow': instance.isPriceToShow,
    };

PriceChangeModel _$PriceChangeModelFromJson(Map<String, dynamic> json) =>
    PriceChangeModel(
      branchId: json['branchId'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => PriceChangeItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PriceChangeModelToJson(PriceChangeModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'items': instance.items,
    };

CreateMenuItemModel _$CreateMenuItemModelFromJson(Map<String, dynamic> json) =>
    CreateMenuItemModel(
      branchId: json['branchId'] as int?,
      barcode: json['barcode'] as String?,
      condimentGroupIds: (json['condimentGroupIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      defaultSellUnitId: json['defaultSellUnitId'] as int?,
      descriptionEn: json['descriptionEn'] as String?,
      descriptionTr: json['descriptionTr'] as String?,
      hasPortion: json['hasPortion'] as bool?,
      hasStock: json['hasStock'] as bool?,
      isChainMenuItem: json['isChainMenuItem'] as bool?,
      kdv: (json['kdv'] as num?)?.toDouble(),
      menuItemId: json['menuItemId'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      portions: (json['portions'] as List<dynamic>?)
          ?.map((e) => PortionListItemInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num?)?.toDouble(),
      printerIds:
          (json['printerIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      qrNameEn: json['qrNameEn'] as String?,
      qrNameTr: json['qrNameTr'] as String?,
      qrSubCategoryId: json['qrSubCategoryId'] as int?,
      stockRecipeId: json['stockRecipeId'] as int?,
      subCategoryId: json['subCategoryId'] as int?,
      branchGroupIds: (json['branchGroupIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$CreateMenuItemModelToJson(
        CreateMenuItemModel instance) =>
    <String, dynamic>{
      'condimentGroupIds': instance.condimentGroupIds,
      'branchGroupIds': instance.branchGroupIds,
      'subCategoryId': instance.subCategoryId,
      'qrSubCategoryId': instance.qrSubCategoryId,
      'hasStock': instance.hasStock,
      'hasPortion': instance.hasPortion,
      'isChainMenuItem': instance.isChainMenuItem,
      'kdv': instance.kdv,
      'barcode': instance.barcode,
      'defaultSellUnitId': instance.defaultSellUnitId,
      'portions': instance.portions,
      'printerIds': instance.printerIds,
      'branchId': instance.branchId,
      'stockRecipeId': instance.stockRecipeId,
      'menuItemId': instance.menuItemId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'qrNameTr': instance.qrNameTr,
      'qrNameEn': instance.qrNameEn,
      'descriptionTr': instance.descriptionTr,
      'descriptionEn': instance.descriptionEn,
      'price': instance.price,
    };

PortionListItemInput _$PortionListItemInputFromJson(
        Map<String, dynamic> json) =>
    PortionListItemInput(
      condimentId: json['condimentId'] as int?,
      isActive: json['isActive'] as bool?,
      isPriceToShow: json['isPriceToShow'] as bool?,
      portionName: json['portionName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PortionListItemInputToJson(
        PortionListItemInput instance) =>
    <String, dynamic>{
      'condimentId': instance.condimentId,
      'portionName': instance.portionName,
      'price': instance.price,
      'isPriceToShow': instance.isPriceToShow,
      'isActive': instance.isActive,
    };

AddMenuItemCategoryModel _$AddMenuItemCategoryModelFromJson(
        Map<String, dynamic> json) =>
    AddMenuItemCategoryModel(
      nameEn: json['nameEn'] as String?,
      branchId: json['branchId'] as int?,
      menuItemCategoryId: json['menuItemCategoryId'] as int?,
      nameTr: json['nameTr'] as String?,
    );

Map<String, dynamic> _$AddMenuItemCategoryModelToJson(
        AddMenuItemCategoryModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'menuItemCategoryId': instance.menuItemCategoryId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
    };

AddMenuItemSubCategoryModel _$AddMenuItemSubCategoryModelFromJson(
        Map<String, dynamic> json) =>
    AddMenuItemSubCategoryModel(
      nameEn: json['nameEn'] as String?,
      branchId: json['branchId'] as int?,
      menuItemCategoryId: json['menuItemCategoryId'] as int?,
      nameTr: json['nameTr'] as String?,
      isStopDefault: json['isStopDefault'] as bool?,
      menuItemSubCategoryId: json['menuItemSubCategoryId'] as int?,
    );

Map<String, dynamic> _$AddMenuItemSubCategoryModelToJson(
        AddMenuItemSubCategoryModel instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'menuItemCategoryId': instance.menuItemCategoryId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'menuItemSubCategoryId': instance.menuItemSubCategoryId,
      'isStopDefault': instance.isStopDefault,
    };

CondimentGroupForEditOutput _$CondimentGroupForEditOutputFromJson(
        Map<String, dynamic> json) =>
    CondimentGroupForEditOutput(
      branchId: json['branchId'] as int?,
      chainCondimentGroupId: json['chainCondimentGroupId'] as int?,
      condimentCondimentGroupMappings:
          (json['condimentCondimentGroupMappings'] as List<dynamic>?)
              ?.map((e) => CondimentCondimentGroupMappingForEditOutput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      condimentGroupId: json['condimentGroupId'] as int?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      isActive: json['isActive'] as bool?,
      isIngredient: json['isIngredient'] as bool?,
      isMultiple: json['isMultiple'] as bool?,
      isPortion: json['isPortion'] as bool?,
      isRequired: json['isRequired'] as bool?,
      maxCount: json['maxCount'] as int?,
      menuItemCondimentGroupMappings:
          (json['menuItemCondimentGroupMappings'] as List<dynamic>?)
              ?.map((e) => MenuItemCondimentGroupMappingForEditOutput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      minCount: json['minCount'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      prerequisiteCondimentMappings:
          (json['prerequisiteCondimentMappings'] as List<dynamic>?)
              ?.map((e) => PrerequisiteCondimentMappingForEditOutput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CondimentGroupForEditOutputToJson(
        CondimentGroupForEditOutput instance) =>
    <String, dynamic>{
      'condimentGroupId': instance.condimentGroupId,
      'branchId': instance.branchId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'createDate': instance.createDate?.toIso8601String(),
      'isActive': instance.isActive,
      'isRequired': instance.isRequired,
      'isMultiple': instance.isMultiple,
      'minCount': instance.minCount,
      'maxCount': instance.maxCount,
      'isPortion': instance.isPortion,
      'isIngredient': instance.isIngredient,
      'condimentCondimentGroupMappings':
          instance.condimentCondimentGroupMappings,
      'prerequisiteCondimentMappings': instance.prerequisiteCondimentMappings,
      'menuItemCondimentGroupMappings': instance.menuItemCondimentGroupMappings,
      'chainCondimentGroupId': instance.chainCondimentGroupId,
    };

PrerequisiteCondimentMappingForEditOutput
    _$PrerequisiteCondimentMappingForEditOutputFromJson(
            Map<String, dynamic> json) =>
        PrerequisiteCondimentMappingForEditOutput(
          branchId: json['branchId'] as int?,
          condiment: json['condiment'] == null
              ? null
              : CondimentForEditOutput.fromJson(
                  json['condiment'] as Map<String, dynamic>),
          condimentGroup: json['condimentGroup'] == null
              ? null
              : CondimentGroupForEditOutput.fromJson(
                  json['condimentGroup'] as Map<String, dynamic>),
          condimentGroupId: json['condimentGroupId'] as int?,
          condimentId: json['condimentId'] as int?,
          prerequisiteCondimentMappingId:
              json['prerequisiteCondimentMappingId'] as int?,
        );

Map<String, dynamic> _$PrerequisiteCondimentMappingForEditOutputToJson(
        PrerequisiteCondimentMappingForEditOutput instance) =>
    <String, dynamic>{
      'prerequisiteCondimentMappingId': instance.prerequisiteCondimentMappingId,
      'branchId': instance.branchId,
      'condimentId': instance.condimentId,
      'condimentGroupId': instance.condimentGroupId,
      'condiment': instance.condiment,
      'condimentGroup': instance.condimentGroup,
    };

CondimentForEditOutput _$CondimentForEditOutputFromJson(
        Map<String, dynamic> json) =>
    CondimentForEditOutput(
      branchGroupIds: (json['branchGroupIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      branchId: json['branchId'] as int?,
      chainCondimentId: json['chainCondimentId'] as int?,
      condimentCondimentGroupMappings:
          (json['condimentCondimentGroupMappings'] as List<dynamic>?)
              ?.map((e) => CondimentCondimentGroupMappingForEditOutput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      condimentId: json['condimentId'] as int?,
      hasStockCard: json['hasStockCard'] as bool?,
      isActive: json['isActive'] as bool?,
      isIngredient: json['isIngredient'] as bool?,
      isPortion: json['isPortion'] as bool?,
      menuItem: json['menuItem'] == null
          ? null
          : MenuItemForCondimentGroupEdit.fromJson(
              json['menuItem'] as Map<String, dynamic>),
      menuItemId: json['menuItemId'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      portionMultiplier: (json['portionMultiplier'] as num?)?.toDouble(),
      prerequisiteCondimentMappings:
          (json['prerequisiteCondimentMappings'] as List<dynamic>?)
              ?.map((e) => PrerequisiteCondimentMappingForEditOutput.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CondimentForEditOutputToJson(
        CondimentForEditOutput instance) =>
    <String, dynamic>{
      'condimentId': instance.condimentId,
      'branchId': instance.branchId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'isActive': instance.isActive,
      'price': instance.price,
      'isPortion': instance.isPortion,
      'hasStockCard': instance.hasStockCard,
      'portionMultiplier': instance.portionMultiplier,
      'menuItemId': instance.menuItemId,
      'isIngredient': instance.isIngredient,
      'menuItem': instance.menuItem,
      'condimentCondimentGroupMappings':
          instance.condimentCondimentGroupMappings,
      'prerequisiteCondimentMappings': instance.prerequisiteCondimentMappings,
      'branchGroupIds': instance.branchGroupIds,
      'chainCondimentId': instance.chainCondimentId,
    };

MenuItemForCondimentGroupEdit _$MenuItemForCondimentGroupEditFromJson(
        Map<String, dynamic> json) =>
    MenuItemForCondimentGroupEdit(
      branchId: json['branchId'] as int?,
      menuItemId: json['menuItemId'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      priceToShow: (json['priceToShow'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MenuItemForCondimentGroupEditToJson(
        MenuItemForCondimentGroupEdit instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'branchId': instance.branchId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'price': instance.price,
      'priceToShow': instance.priceToShow,
    };

CondimentCondimentGroupMappingForEditOutput
    _$CondimentCondimentGroupMappingForEditOutputFromJson(
            Map<String, dynamic> json) =>
        CondimentCondimentGroupMappingForEditOutput(
          branchId: json['branchId'] as int?,
          condiment: json['condiment'] == null
              ? null
              : CondimentForEditOutput.fromJson(
                  json['condiment'] as Map<String, dynamic>),
          condimentCondimentGroupMappingId:
              json['condimentCondimentGroupMappingId'] as int?,
          condimentGroup: json['condimentGroup'] == null
              ? null
              : CondimentGroupForEditOutput.fromJson(
                  json['condimentGroup'] as Map<String, dynamic>),
          condimentGroupId: json['condimentGroupId'] as int?,
          condimentId: json['condimentId'] as int?,
        );

Map<String, dynamic> _$CondimentCondimentGroupMappingForEditOutputToJson(
        CondimentCondimentGroupMappingForEditOutput instance) =>
    <String, dynamic>{
      'condimentCondimentGroupMappingId':
          instance.condimentCondimentGroupMappingId,
      'branchId': instance.branchId,
      'condimentId': instance.condimentId,
      'condimentGroupId': instance.condimentGroupId,
      'condiment': instance.condiment,
      'condimentGroup': instance.condimentGroup,
    };

MenuItemCondimentGroupMappingForEditOutput
    _$MenuItemCondimentGroupMappingForEditOutputFromJson(
            Map<String, dynamic> json) =>
        MenuItemCondimentGroupMappingForEditOutput(
          branchId: json['branchId'] as int?,
          condimentGroupId: json['condimentGroupId'] as int?,
          createDate: json['createDate'] == null
              ? null
              : DateTime.parse(json['createDate'] as String),
          menuItem: json['menuItem'] == null
              ? null
              : MenuItemForCondimentGroupEdit.fromJson(
                  json['menuItem'] as Map<String, dynamic>),
          menuItemCondimentGroupMappingId:
              json['menuItemCondimentGroupMappingId'] as int?,
          menuItemId: json['menuItemId'] as int?,
          orderNumber: json['orderNumber'] as int?,
        );

Map<String, dynamic> _$MenuItemCondimentGroupMappingForEditOutputToJson(
        MenuItemCondimentGroupMappingForEditOutput instance) =>
    <String, dynamic>{
      'menuItemCondimentGroupMappingId':
          instance.menuItemCondimentGroupMappingId,
      'branchId': instance.branchId,
      'menuItemId': instance.menuItemId,
      'condimentGroupId': instance.condimentGroupId,
      'createDate': instance.createDate?.toIso8601String(),
      'orderNumber': instance.orderNumber,
      'menuItem': instance.menuItem,
    };

GetCategoriesOutput _$GetCategoriesOutputFromJson(Map<String, dynamic> json) =>
    GetCategoriesOutput(
      menuItemCategoryId: json['menuItemCategoryId'] as int?,
      menuItemSubCategories: (json['menuItemSubCategories'] as List<dynamic>?)
          ?.map((e) => SubCategoryWithMenuItemsOutput.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      qrNameEn: json['qrNameEn'] as String?,
      qrNameTr: json['qrNameTr'] as String?,
    );

Map<String, dynamic> _$GetCategoriesOutputToJson(
        GetCategoriesOutput instance) =>
    <String, dynamic>{
      'menuItemSubCategories': instance.menuItemSubCategories,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'qrNameTr': instance.qrNameTr,
      'qrNameEn': instance.qrNameEn,
      'menuItemCategoryId': instance.menuItemCategoryId,
    };

SubCategoryWithMenuItemsOutput _$SubCategoryWithMenuItemsOutputFromJson(
        Map<String, dynamic> json) =>
    SubCategoryWithMenuItemsOutput(
      menuItemSubCategoryId: json['menuItemSubCategoryId'] as int?,
      menuItems: (json['menuItems'] as List<dynamic>?)
          ?.map((e) =>
              GetCategoriesMenuItemOutput.fromJson(e as Map<String, dynamic>))
          .toList(),
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      qrNameEn: json['qrNameEn'] as String?,
      qrNameTr: json['qrNameTr'] as String?,
      isStoppedDefault: json['isStoppedDefault'] as bool?,
      qrMenuItemSubCategoryId: json['qrMenuItemSubCategoryId'] as int?,
    );

Map<String, dynamic> _$SubCategoryWithMenuItemsOutputToJson(
        SubCategoryWithMenuItemsOutput instance) =>
    <String, dynamic>{
      'menuItems': instance.menuItems,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'qrNameTr': instance.qrNameTr,
      'qrNameEn': instance.qrNameEn,
      'menuItemSubCategoryId': instance.menuItemSubCategoryId,
      'qrMenuItemSubCategoryId': instance.qrMenuItemSubCategoryId,
      'isStoppedDefault': instance.isStoppedDefault,
    };

GetCategoriesMenuItemOutput _$GetCategoriesMenuItemOutputFromJson(
        Map<String, dynamic> json) =>
    GetCategoriesMenuItemOutput(
      barcodes: (json['barcodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      condimentGroups: (json['condimentGroups'] as List<dynamic>?)
          ?.map((e) => GetCategoriesCondimentGroupOutput.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      isCategoryStoppedDefault: json['isCategoryStoppedDefault'] as bool?,
      isVisible: json['isVisible'] as bool?,
      kdv: (json['kdv'] as num?)?.toDouble(),
      priceToShow: (json['priceToShow'] as num?)?.toDouble(),
      printerName: json['printerName'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      descriptionTr: json['descriptionTr'] as String?,
      menuItemId: json['menuItemId'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      qrNameEn: json['qrNameEn'] as String?,
      qrNameTr: json['qrNameTr'] as String?,
    );

Map<String, dynamic> _$GetCategoriesMenuItemOutputToJson(
        GetCategoriesMenuItemOutput instance) =>
    <String, dynamic>{
      'condimentGroups': instance.condimentGroups,
      'barcodes': instance.barcodes,
      'printerName': instance.printerName,
      'kdv': instance.kdv,
      'isVisible': instance.isVisible,
      'isCategoryStoppedDefault': instance.isCategoryStoppedDefault,
      'priceToShow': instance.priceToShow,
      'menuItemId': instance.menuItemId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'qrNameTr': instance.qrNameTr,
      'qrNameEn': instance.qrNameEn,
      'descriptionTr': instance.descriptionTr,
      'descriptionEn': instance.descriptionEn,
      'price': instance.price,
    };

GetCategoriesCondimentGroupOutput _$GetCategoriesCondimentGroupOutputFromJson(
        Map<String, dynamic> json) =>
    GetCategoriesCondimentGroupOutput(
      basketGroupId: json['basketGroupId'] as int?,
      condimentGroupId: json['condimentGroupId'] as int?,
      condimentIds: (json['condimentIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      condiments: (json['condiments'] as List<dynamic>?)
          ?.map((e) => CondimentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isIngredient: json['isIngredient'] as bool?,
      isMultiple: json['isMultiple'] as bool?,
      isPortion: json['isPortion'] as bool?,
      isRequired: json['isRequired'] as bool?,
      maxCount: json['maxCount'] as int?,
      menuItemId: json['menuItemId'] as int?,
      minCount: json['minCount'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      parentBasketGroupId: json['parentBasketGroupId'] as int?,
      prerequisiteCondimentIds:
          (json['prerequisiteCondimentIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
    );

Map<String, dynamic> _$GetCategoriesCondimentGroupOutputToJson(
        GetCategoriesCondimentGroupOutput instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'basketGroupId': instance.basketGroupId,
      'parentBasketGroupId': instance.parentBasketGroupId,
      'condiments': instance.condiments,
      'isIngredient': instance.isIngredient,
      'condimentGroupId': instance.condimentGroupId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'isRequired': instance.isRequired,
      'isMultiple': instance.isMultiple,
      'minCount': instance.minCount,
      'maxCount': instance.maxCount,
      'condimentIds': instance.condimentIds,
      'prerequisiteCondimentIds': instance.prerequisiteCondimentIds,
      'isPortion': instance.isPortion,
    };

CreateCondimentGroupInput _$CreateCondimentGroupInputFromJson(
        Map<String, dynamic> json) =>
    CreateCondimentGroupInput(
      condimentGroupId: json['condimentGroupId'] as int?,
      condimentIds: (json['condimentIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      isMultiple: json['isMultiple'] as bool?,
      isPortion: json['isPortion'] as bool?,
      isRequired: json['isRequired'] as bool?,
      maxCount: json['maxCount'] as int?,
      minCount: json['minCount'] as int?,
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      prerequisiteCondimentIds:
          (json['prerequisiteCondimentIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      branchId: json['branchId'] as int?,
      mappedMenuItemIds: (json['mappedMenuItemIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      menuItemIds: (json['menuItemIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$CreateCondimentGroupInputToJson(
        CreateCondimentGroupInput instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'menuItemIds': instance.menuItemIds,
      'mappedMenuItemIds': instance.mappedMenuItemIds,
      'condimentGroupId': instance.condimentGroupId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'isRequired': instance.isRequired,
      'isMultiple': instance.isMultiple,
      'minCount': instance.minCount,
      'maxCount': instance.maxCount,
      'condimentIds': instance.condimentIds,
      'prerequisiteCondimentIds': instance.prerequisiteCondimentIds,
      'isPortion': instance.isPortion,
    };

CreateCondimentInput _$CreateCondimentInputFromJson(
        Map<String, dynamic> json) =>
    CreateCondimentInput(
      nameEn: json['nameEn'] as String?,
      nameTr: json['nameTr'] as String?,
      branchId: json['branchId'] as int?,
      condimentGroupIds: (json['condimentGroupIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      condimentId: json['condimentId'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CreateCondimentInputToJson(
        CreateCondimentInput instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'condimentGroupIds': instance.condimentGroupIds,
      'condimentId': instance.condimentId,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'price': instance.price,
    };

CreateMenuItemNoteInput _$CreateMenuItemNoteInputFromJson(
        Map<String, dynamic> json) =>
    CreateMenuItemNoteInput(
      note: json['note'] as String?,
      subCategoryIds: (json['subCategoryIds'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      branchId: json['branchId'] as int?,
    );

Map<String, dynamic> _$CreateMenuItemNoteInputToJson(
        CreateMenuItemNoteInput instance) =>
    <String, dynamic>{
      'note': instance.note,
      'subCategoryIds': instance.subCategoryIds,
      'branchId': instance.branchId,
    };

GetNotesModel _$GetNotesModelFromJson(Map<String, dynamic> json) =>
    GetNotesModel(
      notes:
          (json['notes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetNotesModelToJson(GetNotesModel instance) =>
    <String, dynamic>{
      'notes': instance.notes,
    };

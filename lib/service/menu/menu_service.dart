import 'package:get/get.dart';
import 'package:ideas_desktop/model/integer_model.dart';
import 'package:ideas_desktop/service/base_get_connect.dart';

import '../../model/check_model.dart';
import '../../model/menu_model.dart';

class MenuService extends BaseGetConnect {
  Future<List<MenuItemCategory>?> getCategories(int? branchId) async {
    Response? response;
    try {
      response = await get('menu/getCategories', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => MenuItemCategory.fromJson(data))
          .cast<MenuItemCategory>()
          .toList() as List<MenuItemCategory>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<MenuItemLocalEditModel>?> getMenuForLocalEdit(
      int? branchId) async {
    Response? response;
    try {
      response = await get('menu/getMenuForLocalEdit', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => MenuItemLocalEditModel.fromJson(data))
          .cast<MenuItemLocalEditModel>()
          .toList() as List<MenuItemLocalEditModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<MenuItemLocalPrinterMappingModel>?> getLocalPrinters(
      int? branchId) async {
    Response? response;
    try {
      response = await get('menu/getLocalPrinters', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => MenuItemLocalPrinterMappingModel.fromJson(data))
          .cast<MenuItemLocalPrinterMappingModel>()
          .toList() as List<MenuItemLocalPrinterMappingModel>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateLocalMenu(
      List<MenuItemLocalEditModel> input) async {
    Response? response;
    try {
      response = await post(
          'menu/updateLocalMenu', input.map((e) => e.toJson()).toList());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<PriceChangeModel?> getItemsForPriceChange(int? branchId) async {
    Response? response;
    try {
      response = await get('menu/getItemsForPriceChange', query: {
        'branchId': branchId.toString(),
      });
      return PriceChangeModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> savePriceChange(PriceChangeModel input) async {
    Response? response;
    try {
      response = await post('menu/savePriceChange', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<MenuItemCategory>?> getCategoriesForEdit(int branchId) async {
    Response? response;
    try {
      response = await get('menu/getCategoriesForEdit', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => MenuItemCategory.fromJson(data))
          .cast<MenuItemCategory>()
          .toList() as List<MenuItemCategory>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<MenuItemCategory>?> getLocalCategories(int branchId) async {
    Response? response;
    try {
      response = await get('menu/getLocalCategories', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => MenuItemCategory.fromJson(data))
          .cast<MenuItemCategory>()
          .toList() as List<MenuItemCategory>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> createMenuItem(CreateMenuItemModel input) async {
    Response? response;
    try {
      response = await post('menu/createMenuItem', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateMenuItemCategory(
      AddMenuItemCategoryModel input) async {
    Response? response;
    try {
      response = await post('menu/updateMenuItemCategory', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> updateMenuItemSubCategory(
      AddMenuItemSubCategoryModel input) async {
    Response? response;
    try {
      response = await post('menu/updateMenuItemSubCategory', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<CondimentGroupForEditOutput>?> getCondimentGroupsForEdit(
      int branchId) async {
    Response? response;
    try {
      response = await get('menu/getCondimentGroupsForEdit', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => CondimentGroupForEditOutput.fromJson(data))
          .cast<CondimentGroupForEditOutput>()
          .toList() as List<CondimentGroupForEditOutput>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<CondimentForEditOutput>?> getCondimentsForEdit(
      int branchId) async {
    Response? response;
    try {
      response = await get('menu/getCondimentsForEdit', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => CondimentForEditOutput.fromJson(data))
          .cast<CondimentForEditOutput>()
          .toList() as List<CondimentForEditOutput>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<List<GetCategoriesOutput>?> getCategoriesForNewCondimentGroup(
      int branchId) async {
    Response? response;
    try {
      response = await get('menu/getCategoriesForNewCondimentGroup', query: {
        'branchId': branchId.toString(),
      });
      return response.body
          .map((data) => GetCategoriesOutput.fromJson(data))
          .cast<GetCategoriesOutput>()
          .toList() as List<GetCategoriesOutput>;
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CondimentGroup?> createCondimentGroup(
      CreateCondimentGroupInput input) async {
    Response? response;
    try {
      response = await post('menu/createCondimentGroup', input.toJson());
      return CondimentGroup.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CondimentModel?> createCondiment(CreateCondimentInput input) async {
    Response? response;
    try {
      response = await post('menu/createCondiment', input.toJson());
      return CondimentModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> deleteMenuItem(int? branchId, int menuItemId) async {
    Response? response;
    try {
      response = await get('menu/deleteMenuItem', query: {
        'branchId': branchId.toString(),
        'menuItemId': menuItemId.toString()
      });
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<CreateMenuItemModel?> getMenuItemForEdit(
      int? branchId, int menuItemId) async {
    Response? response;
    try {
      response = await get('menu/getMenuItemForEdit', query: {
        'branchId': branchId.toString(),
        'menuItemId': menuItemId.toString()
      });
      return CreateMenuItemModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<GetNotesModel?> getMenuItemNotes(int menuItemId) async {
    Response? response;
    try {
      response = await get('menu/getMenuItemNotes',
          query: {'menuItemId': menuItemId.toString()});
      return GetNotesModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }

  Future<IntegerModel?> createMenuItemNote(
      CreateMenuItemNoteInput input) async {
    Response? response;
    try {
      response = await post('menu/createMenuItemNote', input.toJson());
      return IntegerModel.fromJson(response.body);
    } catch (e) {
      handleError(response);
      return null;
    }
  }
}

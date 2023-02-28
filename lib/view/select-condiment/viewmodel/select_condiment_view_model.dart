import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import '../../../model/check_model.dart';
import '../../../model/menu_model.dart';

class SelectCondimentController extends BaseController {
  late MenuItem menuItem;
  late RxInt addCount;
  late RxDouble sellUnitQuantity;
  RxList<CondimentGroup> condimentGroupMaps = RxList<CondimentGroup>([]);

  @override
  void onInit() {
    super.onInit();
    menuItem = Get.arguments[0];
    addCount = RxInt(Get.arguments[1]);
    sellUnitQuantity = RxDouble(Get.arguments[2]);
    initSelections();
  }

  void initSelections() {
    for (var group in menuItem.condimentGroups!) {
      condimentGroupMaps.add(CondimentGroup(
        condimentGroupId: group.condimentGroupId,
        condiments: [],
        isMultiple: group.isMultiple,
        isRequired: group.isRequired,
        maxCount: group.maxCount,
        minCount: group.minCount,
        nameEn: group.nameTr,
        nameTr: group.nameTr,
        prerequisiteCondimentIds: group.prerequisiteCondimentIds,
        basketGroupId: group.basketGroupId,
        parentBasketGroupId: group.parentBasketGroupId,
        isIngredient: group.isIngredient,
      ));
    }
  }

  void increaseAddCount() {
    addCount(addCount.value + 1);
  }

  void decreaseAddCount() {
    if (addCount.value > 1) addCount(addCount.value - 1);
  }

  bool isPreRequisteSelected(CondimentGroup group) {
    if (group.prerequisiteCondimentIds!.isEmpty) return true;
    int preReqCount = group.prerequisiteCondimentIds!.length;
    int foundCount = 0;
    for (var preRequisteId in group.prerequisiteCondimentIds!) {
      for (var map in condimentGroupMaps) {
        for (var selectedCondiment in map.condiments!) {
          if (selectedCondiment.condimentId == preRequisteId &&
              (map.basketGroupId == group.parentBasketGroupId ||
                  map.parentBasketGroupId == group.parentBasketGroupId ||
                  map.parentBasketGroupId == null)) {
            foundCount++;
          }
        }
      }
    }

    if (foundCount == preReqCount) {
      return true;
    } else {
      return false;
    }
  }

  bool isRequiredCondimentSelected() {
    List<CondimentGroup> requiredGroups = condimentGroupMaps
        .where((grp) => grp.isRequired! && isPreRequisteSelected(grp))
        .toList();
    if (requiredGroups.isEmpty) {
      return true;
    } else {
      for (var group in requiredGroups) {
        if (group.condiments!.isEmpty ||
            (group.minCount! > group.condiments!.length)) return false;
      }
    }
    return true;
  }

  bool isCondimentSelected(CondimentModel condiment, CondimentGroup group) {
    for (var condimentGroup in condimentGroupMaps) {
      if (condimentGroup.condimentGroupId == group.condimentGroupId &&
          condimentGroup.basketGroupId == group.basketGroupId) {
        for (var item in condimentGroup.condiments!) {
          if (item.condimentId == condiment.condimentId) return true;
        }
      }
    }
    return false;
  }

  CondimentGroup? getCondimentGroupMap(CondimentGroup group) {
    for (var map in condimentGroupMaps) {
      if (map.condimentGroupId == group.condimentGroupId &&
          map.basketGroupId == group.basketGroupId) return map;
    }

    return null;
  }

  void removeCondimentsOfGroup(CondimentGroup group) {
    for (var map in condimentGroupMaps) {
      if (map.condimentGroupId == group.condimentGroupId &&
          map.basketGroupId == group.basketGroupId) {
        for (var i = 0; i < map.condiments!.length; i++) {
          removeCondiment(map.condiments![0], group);
        }
      }
    }
  }

  void removeCondiment(CondimentModel condiment, CondimentGroup group) {
    int index = 0;
    var map = getCondimentGroupMap(group)!;
    for (var item in map.condiments!) {
      if (item.condimentId == condiment.condimentId) {
        break;
      }
      index++;
    }
    map.condiments!.removeAt(index);
    for (var group in menuItem.condimentGroups!) {
      if (!isPreRequisteSelected(group)) {
        removeCondimentsOfGroup(group);
      }
    }
  }

  List<CondimentModel>? getSelectedCondimentsInGroup(CondimentGroup group) {
    return getCondimentGroupMap(group)!.condiments;
  }

  double getTotalPrice() {
    double price = menuItem.price;
    for (var map in condimentGroupMaps) {
      for (var item in map.condiments!) {
        price += item.price;
      }
    }

    return price * sellUnitQuantity.value * addCount.value;
  }

  void selectCondiment(CondimentModel condiment, CondimentGroup group) {
    var map = getCondimentGroupMap(group);
    if (isCondimentSelected(condiment, group)) {
      removeCondiment(condiment, group);
    } else {
      if (group.isMultiple!) {
        if (group.maxCount! > getSelectedCondimentsInGroup(group)!.length) {
          map!.condiments!.add(condiment);
        }
      } else {
        removeCondimentsOfGroup(group);
        map!.condiments!.add(condiment);
        if (menuItem.condimentGroups!.length == 1) {
          handleOk();
        }
      }
    }
    condimentGroupMaps.refresh();
  }

  handleOk() {
    if (isRequiredCondimentSelected()) {
      var item = CheckMenuItemModel(
        menuItemId: menuItem.menuItemId,
        name: menuItem.nameTr,
        totalPrice: menuItem.price,
        sellUnitQuantity: sellUnitQuantity.value,
        actionType: CheckMenuItemActionType.ORDER.getValue,
        condiments: [],
      );

      for (var map in condimentGroupMaps) {
        for (var condiment in map.condiments!) {
          condiment.condimentGroupId = map.condimentGroupId;
          condiment.parentBasketGroupId = map.parentBasketGroupId;
          condiment.basketGroupId = map.basketGroupId;
          item.condiments!.add(condiment);
          item.totalPrice += condiment.price;
        }
      }

      item.totalPrice = item.totalPrice * item.sellUnitQuantity!;
      List<CheckMenuItemModel> items = [];

      if (addCount % 1 == 0) {
        for (var i = 0; i < addCount.value; i++) {
          items.add(item);
        }
      }
      Get.back(result: items);
    } else {
      showSnackbarError('Lütfen zorunlu seçimleri yapınız!');
    }
  }

  handleClose() {
    Get.back(result: null);
  }
}

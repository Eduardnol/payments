import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:payments/models/SaveInformation.dart';
import 'package:payments/models/Suscription.dart';
import 'package:payments/utils/Save.dart';

part 'Session.g.dart';

@JsonSerializable(explicitToJson: true)
class Session extends ChangeNotifier {
  List<Suscription>? suscriptionList = [
    // (Suscription((0), 'Spotify', "Music Service for Everyone",
    //     DateTime(2020, 12, 30), 9.99, Colors.green, null)),
    // (Suscription((1), 'MailChimp', "Music Service for Everyone",
    //     DateTime(2020, 12, 30), 9.99, Colors.yellow, null)),
    // (Suscription((2), 'Netflix', "Music Service for Everyone",
    //     DateTime(2020, 12, 30), 9.99, Colors.red, null)),
    // (Suscription(
    //     (3),
    //     'Amazon',
    //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dapibus diam quis lacinia faucibus. Nam dapibus nulla a volutpat commodo. Cras libero dolor, tincidunt tincidunt erat nec, mattis consectetur nisi. Quisque ut convallis urna. Quisque pellentesque eget sapien sit amet congue. Phasellus dictum egestas maximus. Nullam sagittis feugiat augue et vulputate. Donec at cursus nulla. Nam mattis elit a sapien vestibulum, eu aliquam purus pulvinar. Ut id sagittis magna. Sed posuere lacus in lorem efficitur hendrerit. Pellentesque turpis sapien, suscipit at ullamcorper at, blandit in eros. Etiam gravida sed urna vel vehicula. Integer in bibendum neque, faucibus pharetra enim. Maecenas nec ligula nisl. Curabitur euismod urna neque, ac suscipit tellus tempus non. Aliquam lacinia nisi sed nulla tincidunt consectetur nec vehicula dolor. Nunc in mi dui. Sed a mauris magna. Cras est nisi, interdum nec suscipit sed, dictum nec magna. Integer nibh risus, elementum id condimentum vel, tristique ultricies ex. Morbi consequat aliquam turpis non gravida. Vivamus sollicitudin mauris id auctor tempor. Donec vehicula hendrerit justo, vitae facilisis neque pharetra nec. Mauris accumsan massa augue, laoreet aliquet risus molestie quis. Duis scelerisque sapien arcu, non sagittis metus sodales sed. Quisque dapibus, massa vitae cursus pretium, lorem odio iaculis magna, eu mattis tortor risus nec odio. Nunc varius diam scelerisque, vulputate neque et, hendrerit dui. Etiam vitae nisi cursus, pulvinar tellus vitae, fermentum nulla. Proin vestibulum nisi urna, id rhoncus elit ultricies eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
    //     DateTime(2020, 12, 30),
    //     9.99,
    //     Colors.orange,
    //     null)),
    // (Suscription((4), 'Disney', "Music Service for Everyone",
    //     DateTime(2020, 12, 30), 9.99, Colors.blue, null)),
  ];
  int? _editingIndex;

  Session(this.suscriptionList);

  int? get editingIndex => _editingIndex;

  set editingIndex(int? value) {
    _editingIndex = value;
  }

  void update() {
    notifyListeners();
  }

  void add(Suscription suscription) {
    suscriptionList!.add(suscription);
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  void delete(int index) {
    suscriptionList!.removeAt(index);
    notifyListeners();
  }

  void editName(int index, var name) {
    suscriptionList!.elementAt(index).name = name;
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  void editPrice(int index, var price) {
    suscriptionList!.elementAt(index).price = price;
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  void editId(int index, var id) {
    suscriptionList!.elementAt(index).id = id;
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  void editColor(int index, Color color) {
    suscriptionList!.elementAt(index).color = color.value;
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  void editDate(int index, DateTime date) {
    suscriptionList!.elementAt(index).date = date;
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  void editDescripion(int index, var description) {
    suscriptionList!.elementAt(index).description = description;
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  void editLogo(int index, IconData logo) {
    suscriptionList!.elementAt(index).logo = logo;
    SaveInformation.setInfoFromSharedPref(SaveFile.encodeJson(this));
    notifyListeners();
  }

  factory Session.fromJson(Map<String, dynamic> data) =>
      _$SessionFromJson(data);

  String toJson() {
    return json.encode(_$SessionToJson(this));
  }
}

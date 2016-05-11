@HtmlImport('createMigrationColumn.html')
library dartabase.poly.createMigrationColumn;

import 'dart:async';

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/paper_listbox.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_button.dart';
import "../poly/columnView.dart";
import "../poly/pm.dart";


@PolymerRegister('custom-create-migration-column')
class CreateMigrationColumn extends PolymerElement {
    @Property(notify: true)
    Project project;

    @property
    List existingTableNames;

    CreateMigrationColumn.created() : super.created();

    void ready() {
        print("$runtimeType::ready()");
    }

    @reflectable
    void addColumn(event, [_]) {
        var model = new DomRepeatModel.fromEvent(event);
        model.add("item.columns", {
            "name":"",
            "type":"",
            "default":"",
            "null":true
        });
    }

    @reflectable
    Future addTable(event, [_]) async {
        var tableButton = querySelector("#tableButton");
        tableButton.classes.toggle('hidden');
        Map table = {
            "columns" : [ {
                "name":"",
                "type":"",
                "default":"",
                "null":true
            }
            ]
        };
        add("project.migrationActions.createColumns", table);
        set("existingTableNames", await project.getTableNames());
    }

    @reflectable
    void cancelColumn(event, [_]) {
        var model = new DomRepeatModel.fromEvent(event);
        removeAt("project.migrationActions.createColumns.0.columns",
                model.index);
    }

    @reflectable
    void cancelTable(event, [_]) {
        set("project.migrationActions.createColumns", new List());
        var tableButton = querySelector("#tableButton");
        tableButton.classes.toggle('hidden');
    }
}

@HtmlImport('configView.html')
library dartabase.poly.configView;

// Import the element from Polymer.
import "package:polymer_elements/iron_pages.dart";
import "package:polymer_elements/paper_material.dart";
import "package:polymer_elements/paper_input.dart";
import "package:polymer_elements/paper_button.dart";
import "package:polymer_elements/paper_checkbox.dart";
import "../poly/project.dart";
import "../poly/serverStatus.dart";

// Import the Polymer and Web Components scripts.
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import "dart:html";
import "dart:convert" show JSON;

@PolymerRegister('custom-config-view')
class ConfigView extends PolymerElement {
    @Property(notify: true)
    Project project;

    @Property(notify: true)
    String status;

    @Property(notify: true)
    int editMode = 0;

    ConfigView.created() : super.created();

    @reflectable
    transition(e) {
        if (this.editMode == 0) {
            this.editMode = 1;
        } else {
            this.editMode = 0;
        }
    }

    @reflectable
    saveTransition(e) {
        HttpRequest request = new HttpRequest(); // create a new XHR
        // add an event handler that is called when the request finishes
        request.onReadyStateChange.listen((_) {
            if (request.readyState == HttpRequest.DONE &&
                    (request.status == 200 || request.status == 0)) {
                // data saved OK.

                print(request
                        .responseText); // output the response from the server
                updateConfig(request.responseText);
            }
        });

        // POST the data to the server
        var url = "http://127.0.0.1:8079/saveConfig?config=${JSON.encode(
                project.config)}&projectRootPath=${project.path}";
        request.open("POST", url, async: false);
        //String jsonData = '{"config":${JSON.encode(project.config)},"projectRootPath":${project.path}}'; // etc...
        request.send(); // perform the async POST
    }

    updateConfig(String responseText) {
        if (this.editMode == 0) {
            this.editMode = 1;
        } else {
            this.editMode = 0;
        }
    }

}
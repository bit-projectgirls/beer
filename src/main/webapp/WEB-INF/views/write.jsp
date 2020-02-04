<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ZURB Tribute | Demo</title>
   
    <script src="<c:url value="/resources/tribute.js"/>"></script>
    <style>
      body {
        position: relative;
      }
      .tribute-demo-input {
        outline: none;
        border: 1px solid #eee;
        padding: 3px 5px;
        border-radius: 2px;
        font-size: 15px;
        min-height: 32px;
        cursor: text;
      }
      .tribute-demo-input:focus {
        border-color: #d1d1d1;
        background-color: #fbfbfb;
      }
      [contenteditable="true"]:empty:before {
        content: attr(placeholder);
        display: block;
        color: #ccc;
      }
      #test-autocomplete-container {
        position: relative;
      }
      #test-autocomplete-textarea-container {
        position: relative;
      }
      .float-right {
        float: right;
      }
    </style>
  </head>
  <body>
    <div class="row text-center">
      <div class="large-12 columns">
        <h1>해시태그 테스트</h1>
      </div>
    </div>
<!--  
    <div class="row">
      <div class="large-8 small-centered columns">
        <div class="callout large">
          <h5>Tribute on <code>contenteditable</code> element:</h5>
          <a id="activateInput">@mention</a>
          <p
            id="test"
            class="tribute-demo-input"
            placeholder="Enter some text here"
          ></p>

          <h5>
            Tribute with a local collection (on <code>@</code>) and a remote one
            (on <code>#</code>):
          </h5>
          <p
            id="testMultiple"
            class="tribute-demo-input"
            placeholder="Enter some text here"
          ></p>
        </div>
      </div>
    </div>

    <br /><br />

    <div class="row">
      <div class="large-8 small-centered columns">
        <div class="callout large">
          <h5>
            Tribute with <code>autocompleteMode:true</code> on
            <code>contenteditable</code> element:
          </h5>
          <div id="test-autocomplete-container">
            <p
              id="test-autocomplete"
              class="tribute-demo-input"
              placeholder="States of USA"
            ></p>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="large-8 small-centered columns">
        <div class="callout large">
          <h5>
            Tribute with <code>autocompleteMode:true</code> on
            <code>textarea</code> element:
          </h5>

          <div id="test-autocomplete-textarea-container">
            <textarea
              id="test-autocomplete-textarea"
              cols="40"
              rows="10"
              placeholder="States of USA"
            ></textarea>
          </div>
        </div>
      </div>
    </div>
-->
    <div class="row" id="content">
      <div class="large-8 medium-8 small-centered columns">
        <h5>Tribute on traditional form elements!</h5>
        <form>
          <div class="row">
            <div class="large-12 columns">
              <label>Input Label</label>
              <input
                id="testInput"
                type="text"
                placeholder="Enter some text here"
              />
            </div>
          </div>
          <div class="row">
            <div class="large-12 columns">
              <label>Textarea Label</label>
              <textarea
                id="testarea"
                placeholder="Enter some text here"
              ></textarea>
            </div>
          </div>
        </form>

        <hr />
      </div>
    </div>
    <script>
      // example of alternative callback
      var tribute = new Tribute({
        // menuContainer: document.getElementById('content'),
        trigger: "#",
        values: [
          {
            key: "오렌지",
            value: "오렌지"
          },
          {
            key: "사과",
            value: "사과"
          }
        ],
        selectTemplate: function(item) {
          if (typeof item === "undefined") return null;
          if (this.range.isContentEditable(this.current.element)) {
            return (
              '<span contenteditable="false"><a href="//" target="_blank" title="' +
              item.original.value +
              '">' +
              item.original.value +
              "</a></span>"
            );
          }

          return "#" + item.original.value;
        }
      });

      //tribute.attach(document.getElementById("test"));
      tribute.attach(document.getElementById("testInput"));
      tribute.attach(document.getElementById("testarea"));

      var tributeMultipleTriggers = new Tribute({
        collection: [
          {
            // The function that gets call on select that retuns the content to insert
            selectTemplate: function(item) {
              if (this.range.isContentEditable(this.current.element)) {
                return (
                  '<a href="http://zurb.com" title="' +
                  item.original.email +
                  '">@' +
                  item.original.value +
                  "</a>"
                );
              }

              return "@" + item.original.value;
            },

            // the array of objects
            values: [
              {
                key: "Jordan Humphreys",
                value: "Jordan Humphreys",
                email: "jordan@zurb.com"
              },
              {
                key: "Sir Walter Riley",
                value: "Sir Walter Riley",
                email: "jordan+riley@zurb.com"
              }
            ]
          },
          {
            // The symbol that starts the lookup
            trigger: "#",

            // The function that gets call on select that retuns the content to insert
            selectTemplate: function(item) {
              if (this.range.isContentEditable(this.current.element)) {
                return (
                  '<a href="mailto:' +
                  item.original.email +
                  '">#' +
                  item.original.name.replace() +
                  "</a>"
                );
              }

              return "#" + item.original.name;
            },

            // function retrieving an array of objects
            values: [
              { name: "Bob Bill", email: "bobbill@example.com" },
              { name: "Steve Stevenston", email: "steve@example.com" }
            ],

            lookup: "name",

            fillAttr: "name"
          }
        ]
      });

      tributeMultipleTriggers.attach(document.getElementById("testMultiple"));

      document
        .getElementById("test")
        .addEventListener("tribute-replaced", function(e) {
          console.log("Original Event:", e.detail.event);
          console.log("Matched item:", e.detail.item);
        });

      document
        .getElementById("test")
        .addEventListener("tribute-no-match", function(e) {
          var values = [
            {
              key: "Cheese Tacos",
              value: "Cheese Tacos",
              email: "cheesetacos@zurb.com"
            }
          ];
          tribute.appendCurrent(values);
        });

      var activateLink = document.getElementById("activateInput");

      if (activateLink) {
        activateLink.addEventListener("mousedown", function(e) {
          e.preventDefault();
          var input = document.getElementById("test");

          tribute.showMenuForCollection(input);
        });
      }

      // example of Tribute in autocomplete mode

      var tributeAttributes = {
        autocompleteMode: true,
        values: [
          { key: "Alabama", value: "Alabama" },
          { key: "Alaska", value: "Alaska" },
          { key: "Arizona", value: "Arizona" }
        ],
        selectTemplate: function(item) {
          if (typeof item === "undefined") return null;
          if (this.range.isContentEditable(this.current.element)) {
            return (
              '<span contenteditable="false"><a>' +
              item.original.key +
              "</a></span>"
            );
          }

          return item.original.value;
        },
        menuItemTemplate: function(item) {
          return item.string;
        }
      };
      var tributeAutocompleteTest = new Tribute(
        Object.assign(
          {
            menuContainer: document.getElementById(
              "test-autocomplete-container"
            )
          },
          tributeAttributes
        )
      );
      tributeAutocompleteTest.attach(
        document.getElementById("test-autocomplete")
      );

      var tributeAutocompleteTestArea = new Tribute(
        Object.assign(
          {
            menuContainer: document.getElementById(
              "test-autocomplete-textarea-container"
            )
          },
          tributeAttributes
        )
      );
      tributeAutocompleteTestArea.attach(
        document.getElementById("test-autocomplete-textarea")
      );
    </script>
  </body>
</html>
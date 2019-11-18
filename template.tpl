___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "URL Builder",
  "description": "With this variable template, build a complete URL from the input protocols, hostname, URI path, defined query parameters, and fragments. \n\nVery useful for, for instance, building API request URLs.",
  "containerContexts": [
    "WEB"
  ]
  "categories": ["UTILITY"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "protocol",
    "displayName": "Protocol",
    "radioItems": [
      {
        "value": "https://",
        "displayValue": "HTTPS"
      },
      {
        "value": "http://",
        "displayValue": "HTTP"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "https://",
    "help": "With these radio buttons, select which protocol you\u0027d like to use in you returned URL."
  },
  {
    "type": "LABEL",
    "name": "protocolHTTPWarning",
    "displayName": "It is generally recommended to use HTTPS rather than HTTP, due to higher security.",
    "enablingConditions": [
      {
        "paramName": "protocol",
        "paramValue": "http://",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "hostname",
    "displayName": "Hostname",
    "simpleValueType": true,
    "valueHint": "e.g. iihnordic.com",
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          ".+\\..+"
        ],
        "errorMessage": "Please input a valid hostname."
      }
    ],
    "help": "In this field, input which hostname you\u0027d like to use in you returned URL."
  },
  {
    "type": "TEXT",
    "name": "uriPath",
    "displayName": "Page Path / URI",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "^\\/.*"
        ],
        "errorMessage": "Any URI must start with a forward slash \u003cstrong\u003e/\u003c/strong\u003e"
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "defaultValue": "/",
    "help": "In this field, input which page path / URI you\u0027d like to use in you returned URL.\n\nThe input must begin with a forward slash, or can be left as \u003cstrong\u003eonly\u003c/strong\u003e a forward slash.",
    "valueHint": "e.g. /tracker"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "queryParameters",
    "displayName": "Query Parameters",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Query Key",
        "name": "key",
        "type": "TEXT",
        "valueHint": "e.g. apikey",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "defaultValue": "",
        "displayName": "Query Value",
        "name": "value",
        "type": "TEXT",
        "valueHint": "e.g. 12345",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ],
    "help": "In this table, input the query parameters you\u0027d like to include in your returned URL. Use the left column for query keys and the right column for corresponding values."
  },
  {
    "type": "CHECKBOX",
    "name": "includeFragment",
    "checkboxText": "Include URL fragment / anchor",
    "simpleValueType": true,
    "help": "Check this box if, in your output URL, you want to include a fragment identifier (\u003cstrong\u003e#\u003c/strong\u003efragment-id)"
  },
  {
    "type": "TEXT",
    "name": "fragment",
    "displayName": "Fragment",
    "simpleValueType": true,
    "valueHint": "e.g. page-element-id",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "includeFragment",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
// const log = require('logToConsole');
const encodeUri = require("encodeUri");

// Data variables
const protocol = data.protocol;
const hostname = data.hostname;
const uri = data.uriPath;
var queries = [];
const fragment = data.fragment;

var returnURL = protocol + hostname + uri;

// Logic
if (data.queryParameters){
    for (var i = 0; i < data.queryParameters.length; i++) {
		queries.push(data.queryParameters[i].key + "=" + data.queryParameters[i].value);
	}
  	
  	returnURL += "?" + queries.join("&");
}

if (fragment){
	returnURL += "#" + fragment;
}

// Variables must return a value.
return encodeUri(returnURL);


___TESTS___

scenarios: []


___NOTES___

Created on 2019-11-18 08:00:41



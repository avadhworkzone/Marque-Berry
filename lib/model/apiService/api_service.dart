// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socialv/model/apis/api_exception.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/enum_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';

import 'base_service.dart';

/// USE HTTP TO API CALLING
class ApiService extends BaseService {
  var response;

  Future<dynamic> getResponse({
    @required APIType? apiType,
    @required String? url,
    Map<String, dynamic>? body,
    bool fileUpload = false,
    bool createPostData = false,
    bool applyCampaignData = false,
    bool applyContestData = false,
    bool uploadTemplateData = false,
  }) async {
    try {
      logs("URL ---> ${Uri.parse(url!)}");
      logs('BODY :=> ${jsonEncode(body)}');
      logs('API TYPE :$apiType');
      logs('TOKEN ---> ${PreferenceUtils.getString(key: 'token')}');
      logs('user id ---> ${PreferenceUtils.getInt(key: 'userid')}');

      ///------------------------------------ GET METHOD -------------------------------------///
      if (apiType == APIType.aGet) {
        var result = await http.get(
          // Uri.parse(baseURL + url), /* headers: headerTokenGet*/
          Uri.parse(url),
          /* headers: headerTokenGet*/
          // headers: header(status: APIHeaderType.jsonBodyWithToken),
          headers: header(status: APIHeaderType.onlyToken),
        );
        response = returnResponse(
          result.statusCode,
          result.body,
        );

        logs("Get response......$response");
      }

      ///------------------------------------ FILE UPLOAD METHOD -------------------------------------///
      else if (fileUpload) {
        logs("body:=====> $body");
        var request = http.MultipartRequest(
          "POST",
          Uri.parse(url),
        );
        var pic = await http.MultipartFile.fromPath(
          body!.keys.toList().first,
          body.values.toList().first,
        );
        request.files.add(pic);
        request.headers.addAll(
          {"token": PreferenceUtils.getString(key: PreferenceUtils.token)},
        );

        if (createPostData == true) {
          request.fields.addAll({});
        }
        var result = await request.send();
        var responseData = await result.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print("FILE UPLOAD STATUS ==  $responseString");
        response = returnResponse(result.statusCode, responseString);
        logs("response......$response");
      }

      ///------------------------------------ CREATE POST METHOD -------------------------------------///
      else if (createPostData) {
        logs("body:=====> $body");
        var request = http.MultipartRequest(
          "POST",
          Uri.parse(url),
        );
        var pic = await http.MultipartFile.fromPath(
          "content_url",
          body!["file"],
        );
        request.files.add(pic);
        request.headers.addAll(
          {
            "token": PreferenceUtils.getString(key: PreferenceUtils.token),
          },
        );

        body.keys.toList().forEach((element) {
          if (element != "file") {
            request.fields.addAll({element: body[element]});
          }
        });

        var result = await request.send();
        var responseData = await result.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print("FILE UPLOAD STATUS ==  $responseString");
        response = returnResponse(result.statusCode, responseString);
        logs("response......$response");
      }

      ///------------------------------------ APPLY CAMPAIGN POST METHOD -------------------------------------///
      else if (applyCampaignData) {
        logs("body:=====> $body");
        var request = http.MultipartRequest("POST", Uri.parse(url));
        var pic = await http.MultipartFile.fromPath("media", body!["file"]);

        request.files.add(pic);
        request.headers.addAll(
          {
            "token": PreferenceUtils.getString(key: PreferenceUtils.token),
          },
        );

        body.keys.toList().forEach((element) {
          if (element != "file") {
            request.fields.addAll({element: body[element]});
          }
        });

        var result = await request.send();
        var responseData = await result.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print("FILE UPLOAD STATUS ==  $responseString");
        response = returnResponse(result.statusCode, responseString);
        logs("response......$response");
      }

      ///------------------------------------ APPLY CONTEST POST METHOD -------------------------------------///
      else if (applyContestData) {
        logs("body:=====> $body");
        var request = http.MultipartRequest("POST", Uri.parse(url));

        var pic = await http.MultipartFile.fromPath("media", body!["file"]);
        request.files.add(pic);
        request.headers.addAll(
          {
            "token": PreferenceUtils.getString(key: PreferenceUtils.token),
          },
        );

        body.keys.toList().forEach((element) {
          if (element != "file") {
            request.fields.addAll({element: body[element]});
          }
        });

        var result = await request.send();
        var responseData = await result.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print("FILE UPLOAD STATUS ==  $responseString");
        response = returnResponse(result.statusCode, responseString);
        logs("response......$response");
      }

      ///------------------------------------ UPLOAD TEMPLATE POST METHOD -------------------------------------///
      else if (uploadTemplateData) {
        logs("body:=====> $body");
        var request = http.MultipartRequest("POST", Uri.parse(url));

        var pic = await http.MultipartFile.fromPath("template", body!["file"]);
        request.files.add(pic);
        request.headers.addAll(
          {
            "token": PreferenceUtils.getString(key: PreferenceUtils.token),
          },
        );

        body.keys.toList().forEach((element) {
          if (element != "file") {
            request.fields.addAll({element: body[element]});
          }
        });

        var result = await request.send();
        var responseData = await result.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);

        print("FILE UPLOAD STATUS ==  $responseString");
        response = returnResponse(result.statusCode, responseString);
        logs("response......$response");
      }

      ///------------------------------------ POST METHOD -------------------------------------///

      else if (apiType == APIType.aPost) {
        String encodeBody = jsonEncode(body);
        var result = await http.post(
          Uri.parse(url),
          headers: header(status: APIHeaderType.jsonBodyWithToken),
          body: encodeBody,
        );
        response = returnResponse(result.statusCode, result.body);
        logs("response......$response");
      }
      return response;
    } catch (e) {
      logs('Error=>.. $e');
    }
  }

  dynamic returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 400:
        throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}

Map<String, String> header({APIHeaderType? status}) {
  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('CRMAPIS:API@CRMAPIS!#\$WEB\$'));

  if (status == APIHeaderType.fileUploadWithToken) {
    return {
      // "accept": "*/*",
      // "Content-type": "form-data",
      // "CRMAPIS-API-KEY": "kkcoswggwgwkkc8w4ok808o48kswc40c0www4wss",
      // "USER-ID": PreferenceUtils.getUserId(),
      // "CRMAPIS-LOGslogsIN-TOKEN": PreferenceUtils.getLogslogsinTokenId(),
      // "Authorization": basicAuth,

      'Content-Type': "form-data",
      "Authorization":
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiY2Q1OWRmMmRjZTVlN2IyNjc0ZGY2OTVjNzM1OWZkNGM0MTY3ZGE4Y2VjNjkxYWUzNTYyNjZlZWZmOTRmMzgwZTY5YTM3Yjg1OGEyN2EwZjciLCJpYXQiOjE2Mjg0MDA2NjUuOTMwMzEyLCJuYmYiOjE2Mjg0MDA2NjUuOTMwMzE4LCJleHAiOjE2NTk5MzY2NjUuODcwNjcxLCJzdWIiOiIxNDgiLCJzY29wZXMiOltdfQ.P2ck7V0qJALgeEk9xUbpI_lHgUHcO7L5qwvGfjK8wC4omfZvOWfm8hTl9qTj9CSkhcDhW84XnSULJqwN4__dADsqWja_8O7ZyIkeBQqqfIjSrjhw3YYttU3LQpf4xDuwhbw6XElhaSmxMzqdC9Im4TDDlyyU29Wzk_-cB0Pux3X0dfq0xAJzG8wO1IafNmCIPyCi_L13UbAvINh_ok-CfDFoGog9siEj182_QhkIxlvnF788hnO8xTmieFoCxIYYHmkafzs3ccT6hSXg7aPfliqMIJ10LP9b3mwZNFAx7Xhocx_lvNnnZlF1LCsPmgYRKBgPlXll4xPi4_LhCLErpNmvB6JepiFOXDwKANgdiP4MyCA-4SOLj4r4vfCO0_BIUkXWMHylV6bekVmsV_AbrblZd8k6Q0uxqq14vFsSz5BYqqbfXsWJ-2JyLX-hE_OrbmkU3-3zRry7v2hwjBkJIh-xMF6TtDaSlpGDJLxNA0QwgcIOLQVm8ILXAYFVwP0gKN5X4H2AbR0yCRTF9eT5fXwHMPwx04Tv98cXF299dhz21gJOtWKOurmB5wBdQ2DGN7P6KbriPxsQ0AxKLaYgN5fDikBGsFzxYyYI7tvTjv2hMqGeJyE50BSNj8DMSObW0UIo9uRPGGtPCTVBMvGWwRCj6dfnFINPiH2xBEQmwn8'
    };
  } else if (status == APIHeaderType.fileUploadWithoutToken) {
    return {
      'Content-Type': "form-data",
    };
  } else if (status == APIHeaderType.jsonBodyWithToken) {
    return {
      'Content-Type': 'application/json',
      "token": "${PreferenceUtils.getString(key: PreferenceUtils.token)}"
    };
  } else if (status == APIHeaderType.onlyToken) {
    return {
      // "Authorization": "a3f077a1-b766-4c8b-98f4-c2105f3539e9",
      "token": "${PreferenceUtils.getString(key: PreferenceUtils.token)}"
    };
  } else {
    return {'Content-Type': 'application/json', "Authorization": basicAuth};
  }
}

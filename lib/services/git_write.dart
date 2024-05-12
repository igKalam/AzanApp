import 'dart:convert';
import 'package:http/http.dart' as http;
 class GitWrite {
  GitWrite();
  
   // GitHub repository details
String username = 'igKalam';
String repository = 'json';
String branch = 'main';
String filePath = 'demo.json';
String githubToken = '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';

// Read the file
Future<String> readFile() async {
  try{
String url = 'https://api.github.com/repos/$username/$repository/contents/$filePath';
  Map<String, String> headers = {
    'Authorization': 'token $githubToken',
    'Accept': 'application/vnd.github.v3+json'
  };
  http.Response response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode == 200) {
    String content = jsonDecode(response.body)['content'];
    String decodedContent = utf8.decode(base64.decode(content.replaceAll('\n', '')));
   return decodedContent;
  } else {
    return "";
  }
  } catch (e){
    return "";
  }
  
}

// Write to the file
Future<void> writeFile(Map<String, dynamic> data) async {
  String url = 'https://api.github.com/repos/$username/$repository/contents/$filePath';
  String newContentJson = jsonEncode(data);
  String newContentBase64 = base64.encode(utf8.encode(newContentJson)).toString();
  Map<String, String> headers = {
    'Authorization': 'token $githubToken',
    'Accept': 'application/vnd.github.v3+json'
  };

  // Get the current content and SHA of the file
  http.Response currentResponse = await http.get(Uri.parse(url), headers: headers);
  Map<String, dynamic> currentContent = jsonDecode(currentResponse.body);
  String currentSha = currentContent['sha'];

  Map<String, dynamic> updateData = {
    "message": "Update file",
    "content": newContentBase64,
    "sha": currentSha,
    "branch": branch
  };
  http.Response response = await http.put(Uri.parse(url), headers: headers, body: jsonEncode(updateData));
  if (response.statusCode == 200) {
    //print("File updated successfully.");
  } else {
    //print("Failed to update file.");
  }
}
 }


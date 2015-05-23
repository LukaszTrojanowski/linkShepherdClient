import 'dart:html';
import 'post.dart';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';
import 'dart:convert';

Element menu_content;
Element toggle_menu;
Element account_label;
Element login_label;
ElementList all_tabs;
Element hot_tab;
Element newest_tab;
Element sign_in;
Element post_list;
bool authenticated = false;

void main() {
  init_query_slectors();
  set_up_constants();
  
}

/* Setting up query selectors for visual effects 
 * and requests
 */

void init_query_slectors(){
  /* side menu */
  menu_content = querySelector('#menu_content');
  toggle_menu = querySelector('#open_menu');
  post_list = querySelector('#post_list');
  toggle_menu.onClick.listen((e) => toggleSideMenu());
  
  account_label = querySelector('#account');
  login_label = querySelector('#login_box');
  setLabelVisibility();
  /* end of side menu visual */
  sign_in = querySelector('#sign_in');
  
  /* top bar tabs */
  all_tabs = querySelectorAll('.menu_tab');
  hot_tab = querySelector('#hot_tab');
  hot_tab.onClick.listen((e) => handleHotTabClick());
  newest_tab = querySelector('#newest_tab');
  newest_tab.onClick.listen((_)=> handleNewestTabClick());
  
}

/* Code for visual features on site */

void toggleSideMenu() {
  menu_content.classes.toggle('hidden');
  if (menu_content.classes.contains('hidden')) {
    post_list.style.paddingLeft = '20px';
  } else {
    post_list.style.paddingLeft = '200px';
  }
}

void handleHotTabClick() {
  all_tabs.classes.remove('menu_tab_selected');
  hot_tab.classes.add('menu_tab_selected');
  makeRequest('http://127.0.0.1:8080/hot');
}

void handleNewestTabClick() {
  all_tabs.classes.remove('menu_tab_selected');
  newest_tab.classes.add('menu_tab_selected');
  makeRequest('http://127.0.0.1:8080/newest');
}

void setLabelVisibility() {
  account_label.classes.toggle('hidden', !authenticated);
  login_label.classes.toggle('hidden', authenticated);
}

/* end of code setting up visual features */

/* Code setting up query related constants */
void set_up_constants() {
  authenticated = false;
}



/* HttpRequest related functions */
void makeRequest(String path) {
  //String path = 'http://127.0.0.1:8080/newest';
  var client = new BrowserClient();
  client.get(path)
    .then((response){
    post_list.children.clear();
    //post_list.appendText('response status: ${response.statusCode}');
    List postsList = JSON.decode(response.body);
    postsList.forEach((post){
      post_list.appendHtml((new Post.fromMap(post)).toHTML());
    });
  })
  .whenComplete(client.close);
}
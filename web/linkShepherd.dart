import 'dart:html';
import 'post.dart';

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
  newest_tab.onClick.listen((e)=> handleNewestTabClick());
  
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
  
}

void handleNewestTabClick() {
  all_tabs.classes.remove('menu_tab_selected');
  newest_tab.classes.add('menu_tab_selected');
  print('newest tab has been clickt');
  makeRequestNewest();
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
void makeRequestNewest() {
  String path = 'http://127.0.0.1:8080/newest';
  //var httpReq = new HttpRequest();
  HttpRequest.getString(path)
    .then((String newestContent){
    post_list.appendText(newestContent);
  })
  .catchError((Error error){
    post_list.appendText(error.toString());
  });
  //httpRequest
  //  ..open('GET', path)
  //  ..onLoadEnd.listen((e) => contentRequestComplete(httpRequest))
  //  ..send('');
}

/*contentRequestComplete(HttpRequest request) {
  if (request.status == 200) {    
    //print(request.responseText);
    post_list.appendText('got a succesfull newest request');
  } else {
    post_list.appendText('failed to get context');
    print('reqest for new failed');
  }
}*/
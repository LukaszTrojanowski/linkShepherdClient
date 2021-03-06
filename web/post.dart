import 'dart:convert';

/* Post in web client */
class Post {
  int post_id;
  String title;
  String description;
  DateTime posted_at;
  DateTime last_edited;
  String user;
  String editor;
  int up_votes;
  int down_votes;
  int total_votes;
  String links_to;
  List<String> tags;
  
  Post.fromJSON(String json_post){
    Map post_from_json = JSON.decode(json_post);
    this..post_id = post_from_json['post_id']
        ..title = post_from_json['title']
        ..description = post_from_json['description']
        ..posted_at = post_from_json['posted_at']
        ..last_edited = post_from_json['last_eidited']
        ..user = post_from_json['user']
        ..editor = post_from_json['editor']
        ..up_votes = post_from_json['up_votes']
        ..down_votes = post_from_json['down_votes']
        ..total_votes = post_from_json['total_votes']
        ..links_to = post_from_json['links_to'];
  }
  
  Post.fromMap(Map post_from_map){
    this..post_id = post_from_map['post_id']
        ..title = post_from_map['title']
        ..description = post_from_map['description']
        ..posted_at = DateTime.parse(post_from_map['posted_at'])
        ..last_edited = DateTime.parse(post_from_map['last_edited'])
        ..user = post_from_map['user']
        ..editor = post_from_map['editor']
        ..up_votes = post_from_map['up_votes']
        ..down_votes = post_from_map['down_votes']
        ..total_votes = post_from_map['total_votes']
        ..links_to = post_from_map['links_to']
        ..tags = post_from_map['tags'];
  }
  
  Map toJson(){
    Map fromObject = {
      'post_id' : post_id,
      'title' : title,
      'description' : description,
      'posted_at' : posted_at.toIso8601String(),
      'last_edited' : last_edited.toIso8601String(),
      'user' : user,
      'editor' : editor,
      'up_votes' : up_votes,
      'dwon_votes' : down_votes,
      'total_votes' : total_votes,
      'links_to' : links_to,
      'tags' : tags
    };
    
    return fromObject;
  }
  
  String toHTML(){
    String html = '''<div class="post">
      <div class="title">${this.title}</div>
      <div class="content">${this.description}</div>
      <div class="posted_at">${this.posted_at}</div>
    </div>''';
    return html;
  }
}
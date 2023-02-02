import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget {
  const RandomWords({super.key});
  
  @override
  RandomwordsState createState() => RandomwordsState();
}

class RandomwordsState extends State<RandomWords> { 
  final _randomWordPairs = <WordPair>[];
  final _savedWordPair = Set<WordPair>();

  Widget _biuldListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, item){
        if(item.isOdd){
          return Divider();
        }
        final index = item ~/ 2;
        if (index >=_randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
    }
    );
  }

  Widget _buildRow(WordPair pair){
    final _alreadySaved = _savedWordPair.contains(pair) ;
    return  ListTile(
          title: Text(pair.asPascalCase,
          style: TextStyle(fontSize: 18.0),
          ),
          trailing: Icon(
            _alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: _alreadySaved ? Colors.red : null,
          ),
          onTap: () {
            setState(() {
              if(_alreadySaved){
                _savedWordPair.remove(pair);
              } else {
                _savedWordPair.add(pair);
              }
            });
          },
        );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
          final Iterable<ListTile> tiles = _savedWordPair.map((WordPair pair) {
            return ListTile(
              title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)),
            
            );
          });

          final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

          return Scaffold(
            appBar:  AppBar(title: Text('Saved Pairs'),),
            body: ListView(children: divided,),
          );
      })
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ]
      ),
      body: _biuldListView(),
    );
  }
}
import 'package:flutter/material.dart';
import '../../model/search_songs_model.dart';
import '../../provider/dio_client.dart';
import '../../provider/event_bus.dart';
import 'result_song_card.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Future<SearchSongsModel>? _searchSongs;
  List<SongModel> _list = [];
  String _searchKeywords = '';
  int _page = 1;
  String _source = 'storage';
  final int pageLimit = 6;
  bool _isSearchEnd = false;

  Future<SearchSongsModel> searchSongs() async {
    final response = await dioClient().get('/song/search', queryParameters: {
      'keywords': _searchKeywords,
      'source': _source,
      'page': _page
    });

    return SearchSongsModel.fromJson(response.data);
  }

  void triggerSearch() {
    setState(() {
      _searchSongs = searchSongs();
    });
  }

  void initSearch() {
    _list = [];
    _page = 1;
    _source = 'storage';
    _isSearchEnd = false;
  }

  void setPageSource(List data) {
    if (data.length < pageLimit) {
      if (_source == 'storage') {
        _source = 'netease';
      } else if (_source == 'netease') {
        _isSearchEnd = true;
      }
    } else {
      _page++;
    }
  }

  @override
  void initState() {
    super.initState();

    eventBus.on<SearchEvent>().listen((event) {
      final String text = event.keywords;
      if (text.isNotEmpty && text != _searchKeywords) {
        initSearch();
        _searchKeywords = text;
        triggerSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<SearchSongsModel>(
                future: _searchSongs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<SongModel?> data = snapshot.data!.result;
                    for (var element in data) {
                      _list.add(element!);
                    }

                    setPageSource(data);
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return ListView(children: [
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 56,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 30,
                          crossAxisCount:
                              (MediaQuery.of(context).size.width ~/ 300)
                                  .toInt(),
                        ),
                        itemCount: _list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ResultSongCard(song: _list[index]);
                        }),
                    if (snapshot.connectionState == ConnectionState.done &&
                        !_isSearchEnd)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: OutlinedButton(
                            onPressed: () {
                              triggerSearch();
                            },
                            child: const Text('Search More')),
                      ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                                color: Colors.grey[800]),
                          )
                        ],
                      )
                  ]);
                }),
          ),
        ],
      ),
    );
  }
}

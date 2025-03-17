import 'dart:math';

import 'package:untitled/exam-practaice.dart';
void main() {
  List<int?> myNums = [null, null];
  print(myNums);
  myNums[1] = 0;
  print(myNums);

  String? nullableString = "Hello";
  print(nullableString);

  if (nullableString != null) {
    String str = nullableString;
    print(str);
  }

  if (nullableString != null) {
    print(nullableString.substring(0, nullableString.length ~/ 2));
  }

  Map<String, int> myMap = {"a" : 2, "b" : 1};
  var mapEntries = myMap.entries.toList();
  mapEntries.sort(compareValues);
  Map<String, int> sortedMap = Map.fromEntries(mapEntries);
  print(sortedMap);

  List<int> wordLengths ({required List<String> words}) {
    return words.map((word) => word.length).toList();
  }
  print(wordLengths(words: ["apple", "pear"]));

  String joinwords (List<String> words) {
    return words.join(" ");
  }
  print(joinwords(["apple", "pear"]));

  List<String> splitWords (String sentance) {
    return sentance.split(" ");
  }
  print(splitWords("apple pear"));

  List<Fruit> fruits = [Fruit("pear"), Fruit("apple")];
  for (var fruit in fruits) {
    print(fruit.fruit);
  }
}

int compareValues (MapEntry<String, int> a, MapEntry<String, int> b) {
  return a.value.compareTo(b.value);
}

class Fruit implements Comparable<Fruit> {
  String fruit;
  Fruit(this.fruit);

  @override toString() => fruit;
  @override compareTo(Fruit other) => fruit.compareTo(other.fruit);
}

import 'dart:math';
void main() {
  List<int?> myNums = [null, null];
  print(myNums);
  myNums[1] = 0;
  print("#1 - myNums: $myNums");

  String? nullableString = "Hello";
  print("#2 - nullableString: $nullableString");

  if (nullableString != null) {
    String str = nullableString;
    print("#3 - str: $str");
  }

  if (nullableString != null) {
    print("#4 - substring: ${nullableString.substring(0, nullableString.length ~/ 2)}");
  } else {
    print("");
  }

  List<int> nums = [2, -6, 7, 3, -8, 5];
  final int max_nums = nums.reduce(max);
  print("#5 - max_nums: $max_nums");

  int n = -1;
  for (int i = 0; i < nums.length; i++) {
    if (nums[i] < 0) {
      n = i;
      break;
    }
  }
  print("#6 - n: $n");

  List<int> even_nums = nums.where((num) => num.isEven).toList();
  print("#7 even_nums: $even_nums");

  Map<int, int> numsMap = nums.asMap();
  print("#8 - numsMap: $numsMap");

  nums.sort();
  print("#9a - nums: $nums");

  Map<String, int> myMap = {"a" : 2, "b" : 1};
  var mapEntries = myMap.entries.toList();
  mapEntries.sort(compareValues);
  Map<String, int> sortedMap = Map.fromEntries(mapEntries);
  print("#9b - sortedMap: $sortedMap");

  List<int> stringLengths({required List<String> words}) {
    return words.map((word) => word.length).toList();
  }
  print("#10 - stringLengths: ${stringLengths(words: ["apple", "pear"])}");

  String joinWords(List<String> words) {
    return words.join(" ");
  }
  String word = joinWords(["apple", "pear"]);
  print("#11 - joinWords: $word");

  List<String> splitWords(String sentance) {
    return sentance.split(" ");
  }
  List<String> words = splitWords("apple pear");
  print("#12 - splitWords: $words");

  List<Fruit> fruits = [Fruit("pear"), Fruit("apple")];
  for (var fruit in fruits) {
    print("#13 - fruit: ${fruit.fruit}");
  }

  Map<Name, int> nameMap = {Name("Alice") : 25};
  print("#14 - nameMap: $nameMap");

  String secondLetter = 'hello'.graphemeClusterAt(1);
  print("#15 - secondLetter: $secondLetter");
}

int compareValues(MapEntry<String, int> a, MapEntry<String, int> b) {
  return a.value.compareTo(b.value);
}

class Fruit implements Comparable<Fruit> {
  String fruit;
  Fruit(this.fruit);

  @override toString() => fruit;
  @override compareTo(Fruit other) => fruit.compareTo(other.fruit);
}

class Name {
  String name;
  Name(this.name);

  @override String toString() => name;
  @override int get hashCode => name.hashCode;
  @override
  bool operator ==(Object other) {
    return name == (other as Name).name;
  }
}

extension on String {
  graphemeClusterAt(int i) => this[i];
}
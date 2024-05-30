
class StringUtil {
  static String configureBirdName(String name) {
    List<String> tokenizedName = name.split("-");
    List<String> titleArr =[];
    for(int i = 1; i < tokenizedName.length ;i++) {
      titleArr.add(tokenizedName[i]);
    }
    return titleArr.join(" ");
  }

  static List<double> roundValue(List<double> values) {
    List<double> roundedValues = values.map((value) => double.parse(value.toStringAsFixed(2))).toList();
    double initialSum = roundedValues.reduce((a, b) => a + b);
    double difference = double.parse((100 - initialSum).toStringAsFixed(2));
    int maxIndex = values.indexWhere((value) => value == values.reduce((a, b) => a > b ? a : b));
    roundedValues[maxIndex] = double.parse((roundedValues[maxIndex] + difference).toStringAsFixed(2));
    return roundedValues;
  }
}
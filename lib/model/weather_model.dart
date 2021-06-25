class WeatherModel {
  final String? cityName;
  final int? temperature;
  final String? iconCode;
  final String? description;
  final DateTime? time;

  WeatherModel(
      {this.cityName,
      this.temperature,
      this.iconCode,
      this.description,
      this.time});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        cityName: json['name'],
        temperature: double.parse(json['main']['temp'].toString()).toInt(),
        iconCode: json['weather'][0]['icon'],
        description: json['weather'][0]['main'],
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000));
  }
}

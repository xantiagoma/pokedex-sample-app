import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String capitalize(String val) {
  return '${val[0].toUpperCase()}${val.substring(1)}';
}

String padId(String id) {
  return id.padLeft(3, '0');
}

const METERS_TO_FET = 3.28084;
const METERS_TO_IN = 39.3701;
const KILOGRAMS_TO_POUNDS = 2.20462;

double metersToFeets(double meters) {
  return meters * METERS_TO_FET;
}

double metersToInches(double meters) {
  return meters * METERS_TO_IN;
}

double feetsToMeters(double feets) {
  return feets * (1 / METERS_TO_FET);
}

double inchesToMeters(double feets) {
  return feets * (1 / METERS_TO_IN);
}

double feetsToInches(double feets) {
  return metersToInches(feetsToMeters(feets));
}

double kilogramsToPounds(double kilograms) {
  return kilograms * KILOGRAMS_TO_POUNDS;
}

double poundsToKilograms(double pounds) {
  return pounds * (1 / KILOGRAMS_TO_POUNDS);
}

String metersToFeetsAndInches(double meters) {
  var feets = metersToFeets(meters);
  var fullFeets = feets.floor();
  var remainingFeets = feets - fullFeets;
  var inchesInRemainingFeets = feetsToInches(remainingFeets);
  return "$fullFeets'${inchesInRemainingFeets.toStringAsFixed(1)}\"";
}

///  GraphQL
String uuidFromObject(Object object) {
  if (object is Map<String, Object>) {
    final String typeName = object['__typename'] as String;
    final String id = object['id'].toString();
    if (typeName != null && id != null) {
      return <String>[typeName, id].join('/');
    }
  }
  return null;
}

final OptimisticCache cache = OptimisticCache(
  dataIdFromObject: uuidFromObject,
);

ValueNotifier<GraphQLClient> clientFor({
  @required String uri,
  String subscriptionUri,
}) {
  Link link = HttpLink(uri: uri);
  if (subscriptionUri != null) {
    final WebSocketLink websocketLink = WebSocketLink(
      url: subscriptionUri,
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    );

    link = link.concat(websocketLink);
  }

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: cache,
      link: link,
    ),
  );
}

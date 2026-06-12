import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final client = MqttServerClient('192.168.40.23', 'flutter_app');

  Function(String)? onMessage;

  Future<void> connect() async {
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.logging(on: false);

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_app')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMessage;

    try {
      await client.connect();
      print("MQTT conectado");

      client.subscribe('casa/cuarto1/luz/state', MqttQos.atLeastOnce);

      client.updates!.listen((messages) {
        final recMess = messages[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        if (onMessage != null) {
          onMessage!(payload);
        }
      });
    } catch (e) {
      print("Error MQTT: $e");
      client.disconnect();
    }
  }

  void publish(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }
}

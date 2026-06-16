#include <WiFi.h>
#include <PubSubClient.h>

// WiFi
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// MQTT (Broker local o remoto)
const char* mqtt_server = "YOUR_MQTT_SERVER_IP";  
const int mqtt_port = 1883;

WiFiClient espClient;
PubSubClient client(espClient);

// PIN IN ESP32
const int ledPin = 2;

// -------------------- WIFI --------------------
void conectarWiFi() {
  Serial.print("Conectando a WiFi");

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWiFi conectado");
  Serial.print("IP: ");
  Serial.println(WiFi.localIP());
}

// -------------------- MQTT --------------------
void conectarMQTT() {
  while (!client.connected()) {
    Serial.print("Conectando a MQTT...");

    if (client.connect("ESP32_CUARTO1")) {
      Serial.println("Conectado");

      client.subscribe("casa/cuarto1/luz/set");
      Serial.println("Suscrito a casa/cuarto1/luz/set");

    } else {
      Serial.print("Error MQTT, estado: ");
      Serial.print(client.state());
      Serial.println(" → Reintentando en 3s...");
      delay(3000);
    }
  }
}

// -------------------- CALLBACK --------------------
void callback(char* topic, byte* payload, unsigned int length) {
  String mensaje;

  for (int i = 0; i < length; i++) {
    mensaje += (char)payload[i];
  }

  Serial.print("Mensaje recibido en [");
  Serial.print(topic);
  Serial.print("]: ");
  Serial.println(mensaje);

  if (String(topic) == "casa/cuarto1/luz/set") {
    manejarLuz(mensaje);
  }
}

// -------------------- LÓGICA --------------------
void manejarLuz(String mensaje) {
  if (mensaje == "ON") {
    digitalWrite(ledPin, HIGH);
    Serial.println("LED ENCENDIDO");
    client.publish("casa/cuarto1/luz/state", "ON");
  } 
  else if (mensaje == "OFF") {
    digitalWrite(ledPin, LOW);
    Serial.println("LED APAGADO");
    client.publish("casa/cuarto1/luz/state", "OFF");
  }
}

// -------------------- SETUP --------------------
void setup() {
  Serial.begin(115200);

  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  conectarWiFi();

  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
}

// -------------------- LOOP --------------------
void loop() {
  if (!client.connected()) {
    conectarMQTT();
  }

  client.loop();
}

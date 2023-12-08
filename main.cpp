#include <WiFi.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// ... (previous code)

// Define the pin for the MQ-7 gas sensor
const int mq7Pin = 34;

// Define the pin for the button
const int buttonPin = 5; // Change to the GPIO pin you connect the button to

// Define the state of the device
bool deviceState = true; // true means ON, false means OFF

// ... (previous code)

void setup() {
  // ... (previous setup code)

  // Set the button pin as an input
  pinMode(buttonPin, INPUT_PULLUP);

  // Print the initial device state
  Serial.print("Device is ");
  Serial.println(deviceState ? "ON" : "OFF");
}

void loop() {
  // Read the state of the button
  int buttonState = digitalRead(buttonPin);

  // Check if the button is pressed
  if (buttonState == LOW) {
    // Invert the device state
    deviceState = !deviceState;

    // Print the updated device state
    Serial.print("Device is ");
    Serial.println(deviceState ? "ON" : "OFF");

    // If the device is ON, continue with the loop
    if (deviceState) {
      // Read gas sensor value
      // ... (rest of the loop code)
    } else {
      // If the device is OFF, print a message and wait
      Serial.println("Device is OFF. Waiting...");
      delay(2000); // Adjust the delay as needed
    }
  }

  // ... (rest of the loop code)
}

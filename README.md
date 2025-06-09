

<table>
<tr>
  <td>

### 🌫️ Air Quality Monitor App

A Flutter-based mobile and web application that displays real-time air quality data using the [WAQI (World Air Quality Index)](https://aqicn.org/api/) API. This app uses your current location to fetch and display AQI (Air Quality Index) data.

- 🌍 Real-time air quality data based on your current location  
- 📍 Geolocation support using `geolocator`  
- 🌐 Works on both Android and Web  
- 📊 Clean and responsive UI with readable AQI levels  
- 🧾 Uses WAQI API for accurate global air quality info 

  </td>
  <td>
    <img src="https://github.com/user-attachments/assets/465899d7-ac7b-4a4e-8df6-cb7f44ec0665" width="300"/>
  </td>
</tr>
</table>
📥 Download

You can download the latest Android APK here:  
[⬇️ Download app-arm64-v8a-release.apk](https://github.com/ezhil-kumaran/air_quality/blob/5f01c0a6877b93d2ed5596426f2f80cbc2787c65/app-arm64-v8a-release.apk)


```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.14.0
  geolocator: ^11.0.0

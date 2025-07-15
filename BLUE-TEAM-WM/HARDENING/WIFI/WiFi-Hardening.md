# WiFi Attack Identification

## Wireshark Filter for DeAuth Frames

- Set WiFi adapter into monitor mode
- Select the Inteface that is placed into monitor mode (e.g., wlan0mon)
- Filter for the DeAuth subtype below:

```bash
wlan.fc.type == 0 && wlan.fc.type_subtype == 0x0C
```

- For additional **[reference](https://www.yeahhub.com/analyzing-deauthentication-packets-wireshark/)**

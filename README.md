# Riftbound Arena – Android-App (APK) bauen lassen

Dieses Paket verpackt das Spiel (eine HTML-Datei) als Android-App (Version 5.0). Den Bau übernimmt GitHub kostenlos für dich. Du brauchst keine Entwickler-Software.

Die App startet im Querformat und im Vollbild, der Bildschirm bleibt während des Spiels an. Für die Kartenbilder braucht sie Internet (ohne Netz läuft das Spiel mit gezeichneten Karten). Enthalten sind die Sets Origins, Spiritforged, Unleashed, Vendetta und Radiance.

## 1. GitHub-Konto anlegen
1. Öffne https://github.com und klicke auf "Sign up".
2. E-Mail, Passwort und Benutzernamen eingeben, E-Mail bestätigen.

## 2. Neues, leeres Repository anlegen
1. Oben rechts auf "+" → "New repository".
2. Name z. B. `riftbound-arena`. Sichtbarkeit "Private" oder "Public" (beides geht).
3. KEINE Häkchen bei "Add a README", ".gitignore" oder "license" setzen. Es muss leer bleiben.
4. "Create repository" klicken.

## 3. Dateien hochladen
1. Entpacke die ZIP-Datei auf dem Computer.
2. Im neuen Repository auf den Link "uploading an existing file" klicken (oder "Add file" → "Upload files").
3. Öffne den entpackten Ordner und markiere ALLES darin (Strg+A), auch den Ordner `.github`. Ziehe alles in das Browserfenster.
4. Warte, bis alle Dateien aufgelistet sind, dann unten "Commit changes" klicken.

**Stolperfalle: der Ordner `.github`.** Er ist "versteckt" (beginnt mit einem Punkt). Manche Dateimanager zeigen ihn nicht an, oder das Drag & Drop überspringt ihn. Ohne ihn startet kein Bau. Prüfe nach dem Hochladen, ob im Repository der Ordner `.github` sichtbar ist. Unter Windows: Explorer → Ansicht → "Ausgeblendete Elemente". Unter Mac: Cmd+Shift+Punkt.

Falls `.github` fehlt, lege die Datei von Hand an:
1. "Add file" → "Create new file".
2. Ins Namensfeld genau `.github/workflows/build-apk.yml` tippen (die Schrägstriche erzeugen die Ordner automatisch).
3. Den kompletten Inhalt der Datei `build-apk.yml` aus dem entpackten Ordner (`.github/workflows/`, mit einem Texteditor öffnen) hineinkopieren.
4. "Commit changes" klicken.

Der Branch muss `main` heißen (ist bei neuen Repositories Standard).

## 4. Auf den Bau warten
1. Oben im Repository den Reiter "Actions" öffnen. (Beim ersten Mal ggf. "I understand my workflows, go ahead and enable them" klicken.)
2. Es läuft ein Eintrag "Build APK" (gelber Punkt). Das dauert etwa 3 bis 6 Minuten.
3. Wenn der Haken grün ist, ist die App fertig. Bei rotem X: auf den Eintrag klicken, den roten Schritt öffnen und den Fehlertext an jemanden schicken, der helfen kann.
4. Manuell neu starten: Actions → "Build APK" → "Run workflow".

## 5. APK herunterladen
- Variante A (einfach): Im Repository rechts auf "Releases" → "Riftbound Arena (latest)" → unter "Assets" `app-debug.apk` antippen. Das geht auch direkt vom Handy aus.
- Variante B: Actions → den grünen Lauf anklicken → ganz unten bei "Artifacts" `Riftbound-Arena-APK` herunterladen. Das ist eine ZIP-Datei, die du entpacken musst. Darin liegt `app-debug.apk`.

## 6. Auf dem Handy installieren
1. APK auf das Handy bringen (direkt dort herunterladen oder per Kabel/Cloud übertragen).
2. Antippen. Android fragt, ob die Installation aus dieser Quelle erlaubt sein soll: "Einstellungen" → Installation aus unbekannten Quellen für den Browser bzw. Dateimanager zulassen. Danach erneut die APK antippen und "Installieren" wählen.
3. Ein Hinweis von Play Protect ("App unbekannt") kann erscheinen: "Trotzdem installieren". Die App ist ein Eigenbau und nicht im Play Store.

## 7. Nur die Spieldatei tauschen (Update)
Du musst nicht alles neu hochladen, nur die Spieldatei:
1. Benenne die neue Spieldatei auf deinem Computer in `index.html` um.
2. Im Repository den Ordner `app/src/main/assets` öffnen → "Add file" → "Upload files".
3. Die neue `index.html` hineinziehen (gleicher Name überschreibt die alte) → "Commit changes".
4. Der Bau startet automatisch (Reiter "Actions", 3 bis 6 Minuten). Danach wie in Schritt 5 und 6 die neue APK laden und über die alte installieren.

### Update über die alte App installieren
Die Signatur der App liegt als feste Datei `app/debug.keystore` im Repository. Dadurch haben alle Builds dieselbe Signatur, und eine neue APK lässt sich einfach über die alte installieren. Gespeicherte Decks und Einstellungen bleiben erhalten. Lösche die Datei `app/debug.keystore` nicht und ersetze sie nicht. Sonst musst du die App vor dem Update deinstallieren und verlierst die gespeicherten Daten.
Hinweis: Das ist ein öffentlich bekannter Test-Schlüssel (Passwort `android`). Für den privaten Gebrauch ist das in Ordnung. Für den Play Store wäre er ungeeignet.

## Technik (nur zur Info)
- Das Spiel läuft in einem WebView unter `https://appassets.androidplatform.net/assets/index.html`. Das ist ein sicherer Kontext, deshalb funktionieren Zwischenablage, localStorage und WebRTC.
- Die App hat eine Brücke `AndroidBridge` mit `copy(text)`, `paste()` und `share(text)` als Ersatz für Zwischenablage und Teilen.
- Die Zurück-Taste geht im Spiel einen Schritt zurück, sonst wird die App in den Hintergrund gelegt.
- Das Skript `tools/update-game.sh` kopiert die Spieldatei lokal in den Ordner (nur für Entwickler).
- Version 5.0 (versionCode 5): Querformat (`sensorLandscape`), Vollbild mit Kamera-Ausschnitt, Bildschirm bleibt an, DOM-Speicher und Audio ohne Tippen aktiv.

# Configuring Maven Mirrors for Java Packages in Iran 🇮🇷

When the default Maven Central Repository (`repo1.maven.org`) becomes slow or unreachable due to internet disruptions, switching to a locally‑hosted mirror inside Iran ensures that your dependencies download quickly and reliably. This guide covers how to configure your Maven settings to use the available Iranian mirrors.

---

## 🗺️ Available Maven Mirrors

| Mirror Provider | Mirror URL | Notes |
|-----------------|------------|-------|
| **Hmirror**     | `https://repo.hmirror.ir/maven` | Full mirror of Maven Central |
| **MVN Hub**     | `https://mvnhub.ir` | High‑performance mirror of Maven Central |

Both mirrors cache artifacts from Maven Central. You only need to configure **one** as your primary mirror – Maven will automatically fall back if a mirror is temporarily unavailable only if you define multiple mirrors for different repositories. For simplicity, choose one that works best for you.

---

## 📁 Global Configuration (`settings.xml`)

Maven uses `~/.m2/settings.xml` (or `%USERPROFILE%\.m2\settings.xml` on Windows) for user‑wide settings. If the file doesn’t exist, create it.

### 1. Backup existing settings (if any)

```bash
cp ~/.m2/settings.xml ~/.m2/settings.xml.bak 2>/dev/null || true
```

### 2. Add the mirror configuration

Open or create the file with your favourite editor:

```bash
nano ~/.m2/settings.xml
```

Add the following content. Choose **one** mirror block. The `<mirrorOf>` value `central` means this mirror will be used instead of the official Maven Central.

#### Option A – Hmirror

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
          https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <mirrors>
    <mirror>
      <id>hmirror</id>
      <name>Hmirror Maven Central Mirror</name>
      <url>https://repo.hmirror.ir/maven</url>
      <mirrorOf>central</mirrorOf>
    </mirror>
  </mirrors>
</settings>
```

#### Option B – MVN Hub

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
          https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <mirrors>
    <mirror>
      <id>mvnhub</id>
      <name>MVN Hub Maven Central Mirror</name>
      <url>https://mvnhub.ir</url>
      <mirrorOf>central</mirrorOf>
    </mirror>
  </mirrors>
</settings>
```

#### Using Both Mirrors for Redundancy?

Maven does **not** support automatic fallback among mirrors for the same repository. If you define two mirrors with `mirrorOf` set to `central`, only the first one listed is used.  
You can, however, define mirrors for **different** repository IDs. For basic usage, choose a single, reliable mirror.

---

## 🧪 Verification

Check which mirror Maven is actively using:

```bash
mvn help:effective-settings
```

Look for the `<mirrors>` section in the output. You should see your chosen mirror listed.

You can also run a quick build to test the speed:

```bash
mvn -v
mvn dependency:resolve
```

Dependencies should now be fetched from the mirror (you’ll see the mirror’s URL in the download logs).

---

## 🔁 Reverting to Maven Central

To go back to the official Maven Central, simply remove the `<mirror>` block from `settings.xml` or comment it out. If you had no other settings, you can delete the file.

```bash
rm ~/.m2/settings.xml   # if you only used mirrors
```

Or use the backup:

```bash
cp ~/.m2/settings.xml.bak ~/.m2/settings.xml
```

---

## 📦 Per‑Project Repository Override (Optional)

While mirrors are global, you can also define a custom repository in your project’s `pom.xml`. This does not replace Maven Central but adds another repository that Maven will search **in addition** to Central (unless you disable Central with `<mirrorOf>` in the global settings). For production use, the global mirror approach is cleaner.

Example (only for illustration; mirrors are preferred):

```xml
<repositories>
  <repository>
    <id>hmirror</id>
    <url>https://repo.hmirror.ir/maven</url>
  </repository>
</repositories>
```
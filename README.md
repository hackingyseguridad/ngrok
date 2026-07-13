### ngrok

**Scripts de instalación y uso rápido de [ngrok](https://ngrok.com/) para exponer servicios locales (por ejemplo, un servidor Apache en `localhost:80`) a través de un túnel seguro hacia Internet.**

Ngrok crea un túnel entre tu máquina local —que puede estar detrás de un router o NAT sin IP pública— e Internet, generando una URL pública temporal que redirige el tráfico hacia el puerto que elijas. Muy útil para pruebas, demos, webhooks o exponer temporalmente un servicio sin tocar el firewall o el router.

[![nat](https://github.com/hackingyseguridad/ngrok/raw/master/nat.png)](https://github.com/hackingyseguridad/ngrok/blob/master/nat.png)

[![Licencia](https://img.shields.io/badge/licencia-GPL--3.0-blue.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/lenguaje-Shell-89e051.svg)](https://github.com/hackingyseguridad/ngrok/search?l=shell)
[![Plataforma](https://img.shields.io/badge/plataforma-Debian%20%7C%20Ubuntu%20%7C%20Kali-orange.svg)]()

---

### Tabla de contenidos

- [¿Qué es ngrok?](#qué-es-ngrok)
- [Tabla resumen de scripts](#tabla-resumen-de-scripts)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Detalle de cada script](#detalle-de-cada-script)
- [Preguntas frecuentes](#preguntas-frecuentes)
- [Aviso importante](#aviso-importante)
- [Licencia](#licencia)
- [Autor y enlaces](#autor-y-enlaces)

---

### ngrok

Ngrok es una herramienta que crea un túnel seguro desde Internet hacia tu máquina local, exponiendo temporalmente un servidor web (u otro servicio) que estés ejecutando en tu equipo, sin necesidad de configurar redirección de puertos (*port forwarding*) en el router.

Casos de uso típicos:

| Escenario | Ejemplo |
|---|---|
| Demos rápidas | Enseñar una web en desarrollo a un cliente sin desplegarla |
| Webhooks | Recibir callbacks de servicios externos (Stripe, GitHub, Telegram…) en `localhost` |
| Pruebas móviles | Acceder desde un móvil a un servicio que corre en tu PC |
| Pentesting / labs | Exponer temporalmente un servicio de laboratorio para pruebas remotas |

---

### Tabla resumen de scripts

| Script | Requiere `sudo` | Qué hace | Uso típico |
|---|:---:|---|---|
| **`instalar.sh`** | ✅ | Actualiza el sistema, instala `wget` y `zip`, descarga el binario de ngrok y lo instala en `/usr/bin` | `sh instalar.sh` |
| **`ngrok.sh`** | ✅ (para `service apache2 start`) | Arranca Apache, lanza `ngrok http 80` en segundo plano y muestra la URL pública generada y las conexiones activas | `sh ngrok.sh` |

> ⚠️ Ninguno de los dos scripts configura el **authtoken** de tu cuenta ngrok. Debes ejecutar `ngrok config add-authtoken <TU_TOKEN>` una vez, tras la instalación y antes de crear túneles — ver [Uso](#uso).

---

## Requisitos

- Distribución basada en Debian (Debian, Ubuntu, Kali Linux, Parrot OS, etc.).
- Permisos de administrador (`sudo`).
- Cuenta gratuita en [ngrok.com](https://dashboard.ngrok.com/signup) y su **authtoken** personal.
- Conexión a Internet.
- (Opcional) Apache2 instalado si vas a usar `ngrok.sh` tal cual, ya que arranca ese servicio.

---

### Instalación

```bash
git clone https://github.com/hackingyseguridad/ngrok
cd ngrok
sh instalar.sh
```

`instalar.sh` realiza estos pasos:

1. Actualiza el sistema (`apt update && apt full-upgrade -y`).
2. Instala las dependencias `wget` y `zip`.
3. Descarga el binario de ngrok y lo descomprime en `/usr/bin`.
4. Lanza `ngrok` para verificar que el binario funciona.

Tras la instalación, vincula tu cuenta (paso obligatorio, no incluido en el script):

```bash
ngrok config add-authtoken <TU_AUTHTOKEN>
```

---

### Uso

```bash
sh ngrok.sh
```

`ngrok.sh` hace lo siguiente:

1. Arranca el servicio `apache2` (asume que quieres exponer un sitio en el puerto 80).
2. Espera unos segundos y lanza `ngrok http 80` en segundo plano.
3. Consulta la API local de ngrok (`http://127.0.0.1:4040/api/tunnels`) y muestra la URL pública generada.
4. Muestra las conexiones activas relacionadas con el túnel (`ss | grep https`).

Para exponer un puerto distinto a 80, o un servicio distinto a Apache, edita la línea `ngrok http 80` del script o ejecuta manualmente:

```bash
ngrok http <PUERTO>
```

---

### Detalle de cada script

**`instalar.sh`** — Instalador de ngrok. Descarga el paquete `.zip` del binario y lo coloca en `/usr/bin` para que quede disponible como comando `ngrok` en cualquier ruta.

**`ngrok.sh`** — Automatiza el flujo completo para exponer un servidor web local: arranca Apache, crea el túnel HTTP en segundo plano y muestra en pantalla la URL pública (`*.ngrok.io` o `*.ngrok-free.app`, según el plan) junto con las conexiones activas.

---

---

## importante

- El enlace de descarga en `instalar.sh` apunta a un binario **legacy** de ngrok v2 (`bin.equinox.io`). Ngrok ha migrado su distribución oficial a un repositorio APT propio y a la CLI v3; si la descarga falla o el binario queda desactualizado, instala la versión oficial más reciente siguiendo la guía en [ngrok.com/download](https://ngrok.com/download) (repositorio `apt` oficial) en lugar de este script.
- Exponer un servicio a Internet, aunque sea temporalmente, implica riesgos de seguridad: usa `ngrok http --basic-auth` u otras opciones de autenticación si el contenido es sensible, y cierra el túnel cuando termines (`Ctrl+C` o `killall ngrok`).

---

#
[hackingyseguridad.com](http://www.hackingyseguridad.com/)
#
